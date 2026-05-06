import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:fintrack/presentation/blocs/notification_settings/notification_settings_bloc.dart';
import 'package:fintrack/presentation/blocs/notification_settings/notification_settings_event.dart';
import 'package:fintrack/presentation/blocs/notification_settings/notification_settings_state.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen> {
  final NotificationSettingsBloc _notificationBloc = NotificationSettingsBloc();

  bool generalNotification = true;
  bool sound = true;
  bool soundCall = true;
  bool vibrate = true;
  bool transactionUpdate = false;
  bool expenseReminder = false;
  bool budgetNotifications = false;
  bool lowBalanceAlerts = false;

  @override
  void initState() {
    super.initState();
    _notificationBloc.add(NotificationSettingsLoadRequested());
  }

  @override
  void dispose() {
    _notificationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationSettingsBloc, NotificationSettingsState>(
      bloc: _notificationBloc,
      listener: (context, state) {
        if (state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message!)));
        }
        if (expenseReminder != state.expenseReminder) {
          setState(() => expenseReminder = state.expenseReminder);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/profile');
              }
            },
          ),
          title: const Text(
            'Notification Settings',
            style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? const Color(0xFF141414)
                      : const Color(0xFFF4FAF6),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSwitchTile(context, 'General Notification', generalNotification, (val) {
                        setState(() => generalNotification = val);
                      }),
                      _buildSwitchTile(context, 'Sound', sound, (val) {
                        setState(() => sound = val);
                      }),
                      _buildSwitchTile(context, 'Sound Call', soundCall, (val) {
                        setState(() => soundCall = val);
                      }),
                      _buildSwitchTile(context, 'Vibrate', vibrate, (val) {
                        setState(() => vibrate = val);
                      }),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(color: Colors.black12, height: 1),
                      ),
                      _buildSwitchTile(context, 'Transaction Update', transactionUpdate, (val) {
                        setState(() => transactionUpdate = val);
                      }),
                      _buildSwitchTile(context, 'Expense Reminder', expenseReminder, (val) {
                        _onExpenseReminderChanged(val);
                      }),
                      _buildSwitchTile(context, 'Budget Notifications', budgetNotifications, (val) {
                        setState(() => budgetNotifications = val);
                      }),
                      _buildSwitchTile(context, 'Low Balance Alerts', lowBalanceAlerts, (val) {
                        setState(() => lowBalanceAlerts = val);
                      }),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _sendTestNotification,
                          icon: const Icon(Icons.notifications_active_outlined),
                          label: const Text('Send Test Notification'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: _scheduleTestIn30Sec,
                          icon: const Icon(Icons.schedule_send_outlined),
                          label: const Text('Schedule Test (30 sec)'),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomNav(context),
      ),
    );
  }

  Widget _buildSwitchTile(
    BuildContext context,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF00D19E),
            activeTrackColor: const Color(0xFFE0F2F1),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.black12,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 4,
      selectedItemColor: const Color(0xFF00D19E),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      ],
      onTap: (index) {
        if (index == 0) context.go('/home');
      },
    );
  }

  Future<void> _onExpenseReminderChanged(bool value) async {
    _notificationBloc.add(NotificationExpenseReminderChanged(value));
  }

  Future<void> _sendTestNotification() async {
    _notificationBloc.add(NotificationTestSendRequested());
  }

  Future<void> _scheduleTestIn30Sec() async {
    _notificationBloc.add(NotificationTestScheduleRequested());
  }
}
