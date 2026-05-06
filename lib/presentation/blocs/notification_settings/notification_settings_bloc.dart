import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fintrack/core/constants/app_constants.dart';
import 'package:fintrack/core/services/notification_service.dart';
import 'package:hive/hive.dart';
import 'notification_settings_event.dart';
import 'notification_settings_state.dart';

class NotificationSettingsBloc
    extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  NotificationSettingsBloc()
      : super(const NotificationSettingsState(expenseReminder: false)) {
    on<NotificationSettingsLoadRequested>(_onLoadRequested);
    on<NotificationExpenseReminderChanged>(_onExpenseReminderChanged);
    on<NotificationTestSendRequested>(_onTestSendRequested);
    on<NotificationTestScheduleRequested>(_onTestScheduleRequested);
  }

  Future<void> _onLoadRequested(
    NotificationSettingsLoadRequested event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    final box = Hive.box(AppConstants.kUserBox);
    final enabled =
        box.get(AppConstants.kExpenseReminderEnabledKey, defaultValue: false)
            as bool;
    emit(state.copyWith(expenseReminder: enabled));
  }

  Future<void> _onExpenseReminderChanged(
    NotificationExpenseReminderChanged event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    final box = Hive.box(AppConstants.kUserBox);
    await box.put(AppConstants.kExpenseReminderEnabledKey, event.value);
    if (event.value) {
      await NotificationService.scheduleDailyExpenseReminder();
    } else {
      await NotificationService.cancelDailyExpenseReminder();
    }
    emit(
      state.copyWith(
        expenseReminder: event.value,
        message: event.value
            ? 'Daily reminder enabled (21:00).'
            : 'Daily reminder disabled.',
      ),
    );
  }

  Future<void> _onTestSendRequested(
    NotificationTestSendRequested event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    await NotificationService.showTestNotification();
    emit(state.copyWith(message: 'Test notification sent.'));
  }

  Future<void> _onTestScheduleRequested(
    NotificationTestScheduleRequested event,
    Emitter<NotificationSettingsState> emit,
  ) async {
    await NotificationService.scheduleTestInSeconds(seconds: 30);
    emit(state.copyWith(message: 'Scheduled: notification in 30 seconds.'));
  }
}
