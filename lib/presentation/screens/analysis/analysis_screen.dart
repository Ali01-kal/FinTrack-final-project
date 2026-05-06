import 'package:fintrack/core/constants/app_constants.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_event.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatisticsBloc>().add(LoadStatisticsByPeriod('Weekly'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Analysis',
          style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1B3D3D), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white24,
              child: IconButton(
                icon: Icon(Icons.notifications_none, color: isDark ? Colors.white : const Color(0xFF1B3D3D)),
                onPressed: () => context.push(AppConstants.routeNotifications),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      body: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          if (state is StatisticsLoading) {
            return Center(child: CircularProgressIndicator(color: isDark ? Colors.white : const Color(0xFF1B3D3D)));
          }
          if (state is StatisticsError) {
            return Center(
              child: Text(state.message, style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1B3D3D))),
            );
          }
          if (state is StatisticsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTopStat(context, 'Total Balance', _formatMoney(state.totalBalance), Icons.account_balance_wallet_outlined),
                          _buildTopStat(context, 'Total Expense', '-${_formatMoney(state.totalExpense)}', Icons.analytics_outlined),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Stack(
                        children: [
                          Container(
                            height: 8,
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(10)),
                          ),
                          FractionallySizedBox(
                            widthFactor: state.ratio,
                            child: Container(
                              height: 8,
                              decoration: BoxDecoration(color: const Color(0xFF1B3D3D), borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${state.ratioPercent}%', style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1B3D3D), fontSize: 10, fontWeight: FontWeight.bold)),
                          Text(_formatMoney(state.totalIncome), style: TextStyle(color: isDark ? Colors.white : const Color(0xFF1B3D3D), fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(35)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['Daily', 'Weekly', 'Monthly', 'Year'].map((period) {
                      final isSelected = state.selectedPeriod == period;
                      return GestureDetector(
                        onTap: () {
                          context.read<StatisticsBloc>().add(LoadStatisticsByPeriod(period));
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF00D19E) : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            period,
                            style: TextStyle(
                              color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF1B3D3D).withOpacity(0.6)),
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF141414) : const Color(0xFFF4FAF6),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(45)),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Income & Expenses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1B3D3D))),
                              Row(
                                children: [
                                  _buildSmallIcon(Icons.search, () => context.push(AppConstants.routeSearch)),
                                  const SizedBox(width: 8),
                                  _buildSmallIcon(Icons.calendar_today_outlined, () => context.push(AppConstants.routeCalendar)),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          _buildDynamicChart(context, state.chartLabels, state.chartBars),
                          const SizedBox(height: 35),
                          Row(
                            children: [
                              _buildStatCard(context, 'Income', _formatMoney(state.totalIncome), Icons.arrow_outward, const Color(0xFF00D19E)),
                              const SizedBox(width: 15),
                              _buildStatCard(context, 'Expense', '-${_formatMoney(state.totalExpense)}', Icons.call_received, Colors.blueAccent),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  String _formatMoney(double value) => '\$${value.toStringAsFixed(2)}';

  Widget _buildTopStat(BuildContext context, String title, String amount, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: isDark ? Colors.white : const Color(0xFF1B3D3D)),
            const SizedBox(width: 4),
            Text(title, style: TextStyle(color: isDark ? Colors.white70 : const Color(0xFF1B3D3D), fontSize: 11)),
          ],
        ),
        const SizedBox(height: 4),
        Text(amount, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
      ],
    );
  }

  Widget _buildSmallIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF00D19E).withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF00D19E)),
      ),
    );
  }

  Widget _buildDynamicChart(BuildContext context, List<String> labels, List<double> bars) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 200,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: BarChart(
        BarChartData(
          maxY: 100,
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(enabled: true),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= labels.length) return const SizedBox.shrink();
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      labels[idx],
                      style: TextStyle(fontSize: 9, color: isDark ? Colors.white70 : Colors.black45),
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                },
              ),
            ),
          ),
          barGroups: List.generate(
            bars.length,
            (index) => BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: bars[index].clamp(0, 100),
                  width: 14,
                  borderRadius: BorderRadius.circular(6),
                  color: index % 2 == 0 ? const Color(0xFF00D19E) : Colors.blueAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String amount, IconData icon, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 10),
            Text(title, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 12)),
            const SizedBox(height: 4),
            Text(amount, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isDark ? Colors.white : const Color(0xFF1B3D3D))),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 1,
      selectedItemColor: const Color(0xFF00D19E),
      unselectedItemColor: Colors.black26,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.layers_outlined), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
      ],
      onTap: (index) {
        if (index == 0) context.go(AppConstants.routeHome);
        if (index == 1) context.go(AppConstants.routeAnalysis);
        if (index == 2) context.go(AppConstants.routeTransaction);
        if (index == 3) context.go(AppConstants.routeCategories);
        if (index == 4) context.go(AppConstants.routeProfile);
      },
    );
  }
}
