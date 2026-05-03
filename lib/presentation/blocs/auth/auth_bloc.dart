// // Слой: presentation | Назначение: AuthBloc — управление состоянием авторизации

// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../domain/entities/user.dart';
// import '../../../domain/usecases/check_session_usecase.dart';
// import '../../../domain/usecases/login_usecase.dart';
// import '../../../domain/usecases/register_usecase.dart';
// import '../../../domain/repositories/auth_repository.dart';
// import '../../../domain/usecases/base_usecase.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc({
//     required LoginUseCase loginUseCase,
//     required RegisterUseCase registerUseCase,
//     required CheckSessionUseCase checkSessionUseCase,
//     required AuthRepository authRepository,
//   })  : _loginUseCase = loginUseCase,
//         _registerUseCase = registerUseCase,
//         _checkSessionUseCase = checkSessionUseCase,
//         _authRepository = authRepository,
//         super(const AuthInitial()) {
//     on<AuthLoginRequested>(_onLoginRequested);
//     on<AuthRegisterRequested>(_onRegisterRequested);
//     on<AuthCheckSessionRequested>(_onCheckSessionRequested);
//     on<AuthLogoutRequested>(_onLogoutRequested);
//   }

//   final LoginUseCase _loginUseCase;
//   final RegisterUseCase _registerUseCase;
//   final CheckSessionUseCase _checkSessionUseCase;
//   final AuthRepository _authRepository;

//   Future<void> _onLoginRequested(
//     AuthLoginRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(const AuthLoading());
//     try {
//       final user = await _loginUseCase(
//         LoginParams(email: event.email, password: event.password),
//       );
//       emit(AuthAuthenticated(user));
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   Future<void> _onRegisterRequested(
//     AuthRegisterRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(const AuthLoading());
//     try {
//       final user = await _registerUseCase(
//         RegisterParams(
//           name: event.name,
//           email: event.email,
//           password: event.password,
//         ),
//       );
//       emit(AuthAuthenticated(user));
//     } catch (e) {
//       emit(AuthError(e.toString()));
//     }
//   }

//   Future<void> _onCheckSessionRequested(
//     AuthCheckSessionRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     emit(const AuthLoading());
//     try {
//       final user = await _checkSessionUseCase(const NoParams());
//       if (user != null) {
//         emit(AuthAuthenticated(user));
//       } else {
//         emit(const AuthUnauthenticated());
//       }
//     } catch (e) {
//       emit(const AuthUnauthenticated());
//     }
//   }

//   Future<void> _onLogoutRequested(
//     AuthLogoutRequested event,
//     Emitter<AuthState> emit,
//   ) async {
//     await _authRepository.logout();
//     emit(const AuthUnauthenticated());
//   }
// }



import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    
    // Сессияны тексеру
    on<AuthCheckRequested>((event, emit) async {
      final user = await authRepository.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });

    // Жүйеге кіру
    on<AuthSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.signIn(event.email, event.password);
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(AuthError("Қате: Пайдаланушы табылмады"));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Жүйеден шығу
    on<AuthSignOutRequested>((event, emit) async {
      await authRepository.signOut();
      emit(Unauthenticated());
    });

    on<AuthSignUpRequested>((event, emit) async {
      emit(AuthLoading()); // Жүктеу күйін қосамыз
       try {
       // Repository арқылы тіркелуді шақырамыз
       final user = await authRepository.signUp(event.email, event.password);
    
       if (user != null) {
         emit(Authenticated(user)); // Сәтті тіркелсе - Authenticated
        } else {
          emit(AuthError("Тіркелу кезінде қате орын алды"));
      }
        } catch (e) {
          // Firebase-тен келетін қателерді ұстау
        emit(AuthError(e.toString()));
      }
   });
 }
}