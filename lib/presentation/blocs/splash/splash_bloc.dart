import 'package:fintrack/core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<SplashResolveNextRouteRequested>(_onResolveNextRouteRequested);
  }

  Future<void> _onResolveNextRouteRequested(
    SplashResolveNextRouteRequested event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final onboardingDone =
        prefs.getBool(AppConstants.kOnboardingDoneKey) ?? false;
    final userBox = Hive.box(AppConstants.kUserBox);
    final hasUserSession = userBox.get('current_user') != null;
    final lastRoute = userBox.get(AppConstants.kLastRouteKey) as String?;

    if (hasUserSession && _canResumeRoute(lastRoute)) {
      emit(SplashState(nextRoute: lastRoute));
      return;
    }
    if (hasUserSession) {
      emit(const SplashState(nextRoute: AppConstants.routeHome));
      return;
    }
    emit(
      SplashState(
        nextRoute: onboardingDone
            ? AppConstants.routeWelcome
            : AppConstants.routeOnboarding,
      ),
    );
  }

  bool _canResumeRoute(String? route) {
    if (route == null) return false;
    const blocked = <String>{
      AppConstants.routeSplash,
      AppConstants.routeOnboarding,
      AppConstants.routeWelcome,
      AppConstants.routeLogin,
      AppConstants.routeRegister,
    };
    return !blocked.contains(route);
  }
}
