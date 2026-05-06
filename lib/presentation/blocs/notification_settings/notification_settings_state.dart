class NotificationSettingsState {
  final bool expenseReminder;
  final String? message;

  const NotificationSettingsState({
    required this.expenseReminder,
    this.message,
  });

  NotificationSettingsState copyWith({
    bool? expenseReminder,
    String? message,
  }) {
    return NotificationSettingsState(
      expenseReminder: expenseReminder ?? this.expenseReminder,
      message: message,
    );
  }
}
