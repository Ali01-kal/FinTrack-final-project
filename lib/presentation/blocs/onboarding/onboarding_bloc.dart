import 'package:fintrack/core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState(isCompleted: false)) {
    on<OnboardingCompleteRequested>(_onCompleteRequested);
  }

  Future<void> _onCompleteRequested(
    OnboardingCompleteRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.kOnboardingDoneKey, true);
    emit(const OnboardingState(isCompleted: true));
  }
}
