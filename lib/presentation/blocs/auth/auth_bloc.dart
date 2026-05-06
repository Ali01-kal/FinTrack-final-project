import 'package:fintrack/core/constants/app_constants.dart';
import 'package:fintrack/domain/entities/user_entity.dart';
import 'package:fintrack/domain/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthCheckRequested>((event, emit) async {
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });

    on<AuthSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signIn(event.email, event.password);
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError('User not found'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthSignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signUp(event.email, event.password);
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError('Registration failed'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthSignOutRequested>((event, emit) async {
      await authRepository.signOut();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConstants.kOnboardingDoneKey, false);
      final userBox = Hive.box(AppConstants.kUserBox);
      await userBox.delete(AppConstants.kLastRouteKey);
      emit(Unauthenticated());
    });

    on<AuthProfileUpdateRequested>((event, emit) async {
      final currentState = state;
      if (currentState is! Authenticated) return;

      final updatedUser = await authRepository.updateCurrentUser(
        UserEntity(
          id: currentState.user.id,
          email: event.email.trim().isEmpty ? currentState.user.email : event.email.trim(),
          name: event.name.trim().isEmpty ? currentState.user.name : event.name.trim(),
          photoUrl: currentState.user.photoUrl,
        ),
      );
      if (updatedUser != null) {
        emit(Authenticated(updatedUser));
      }
    });
  }
}
