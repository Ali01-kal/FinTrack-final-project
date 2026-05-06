abstract class NotificationSettingsEvent {}

class NotificationSettingsLoadRequested extends NotificationSettingsEvent {}

class NotificationExpenseReminderChanged extends NotificationSettingsEvent {
  NotificationExpenseReminderChanged(this.value);
  final bool value;
}

class NotificationTestSendRequested extends NotificationSettingsEvent {}

class NotificationTestScheduleRequested extends NotificationSettingsEvent {}
