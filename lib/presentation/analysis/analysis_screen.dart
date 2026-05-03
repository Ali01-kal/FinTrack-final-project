import 'package:fintrack/core/constants/app_constants.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_bloc.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_event.dart';
import 'package:fintrack/presentation/blocs/statistics/bloc/statistics_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  String selectedPeriod = 'Weekly';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadStatisticsForPeriod(selectedPeriod);
    });
  }

  void _loadStatisticsForPeriod(String period) {
    final now = DateTime.now();
    DateTime? startDate;

    switch (period) {
      case 'Daily':
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case 'Weekly':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case 'Monthly':
        startDate = DateTime(now.year, now.month, 1);
        break;
      case 'Year':
        startDate = DateTime(now.year, 1, 1);
        break;
    }

    context.read<StatisticsBloc>().add(
          LoadStatistics(startDate: startDate, endDate: now),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B3D3D)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Analysis',
          style: TextStyle(color: Color(0xFF1B3D3D), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.white24,
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Color(0xFF1B3D3D)),
                onPressed: () => context.push(AppConstants.routeNotifications),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
      body: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          // 1. Жүктелу күйі
          if (state is StatisticsLoading) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF1B3D3D)));
          }

          // 2. Қате шыққан күй
          if (state is StatisticsError) {
            return Center(
              child: Text(state.message, style: const TextStyle(color: Color(0xFF1B3D3D))),
            );
          }

          // 3. Деректер жүктелген күй (Осы жерде барлық есептеулер жасалады)
          if (state is StatisticsLoaded) {
            final totalIncome = state.totalIncome;
            final totalExpense = state.totalExpense;
            final totalBalance = totalIncome - totalExpense;
            final chartData = _buildChartData(state.categoryTotals);
            
            final ratio = totalIncome <= 0 ? 0.0 : (totalExpense / totalIncome).clamp(0.0, 1.0);
            final ratioPercent = (ratio * 100).toStringAsFixed(0);

            return Column(
              children: [
                // Статистика және Прогресс-бар бөлімі
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildTopStat('Total Balance', _formatMoney(totalBalance), Icons.account_balance_wallet_outlined),
                          _buildTopStat('Total Expense', '-${_formatMoney(totalExpense)}', Icons.analytics_outlined),
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
                            widthFactor: ratio,
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
                          Text('$ratioPercent%', style: const TextStyle(color: Color(0xFF1B3D3D), fontSize: 10, fontWeight: FontWeight.bold)),
                          Text(_formatMoney(totalIncome), style: const TextStyle(color: Color(0xFF1B3D3D), fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),

                // Период таңдау бөлімі
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(35)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['Daily', 'Weekly', 'Monthly', 'Year'].map((period) {
                      final isSelected = selectedPeriod == period;
                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedPeriod = period);
                          _loadStatisticsForPeriod(period);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF00D19E) : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            period,
                            style: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF1B3D3D).withOpacity(0.6),
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Төменгі ақ блок (График және Карталар)
                const SizedBox(height: 15),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF4FAF6),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(25, 35, 25, 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Income & Expenses', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B3D3D))),
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
                          _buildDynamicChart(chartData),
                          const SizedBox(height: 35),
                          Row(
                            children: [
                              _buildStatCard('Income', _formatMoney(totalIncome), Icons.arrow_outward, const Color(0xFF00D19E)),
                              const SizedBox(width: 15),
                              _buildStatCard('Expense', '-${_formatMoney(totalExpense)}', Icons.call_received, Colors.blueAccent),
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

  // Графикке деректерді дайындау
  Map<String, dynamic> _buildChartData(Map<String, double> categoryTotals) {
    if (categoryTotals.isEmpty) {
      return {'labels': ['No data'], 'bars': [0.0]};
    }

    final entries = categoryTotals.entries.toList()..sort((a, b) => b.value.compareTo(a.value));
    final topEntries = entries.take(6).toList();
    final maxValue = topEntries.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    return {
      'labels': topEntries.map((e) => e.key).toList(),
      'bars': topEntries.map((e) => maxValue == 0 ? 0.0 : (e.value / maxValue) * 100).toList(),
    };
  }

  String _formatMoney(double value) => '\$${value.toStringAsFixed(2)}';

  Widget _buildTopStat(String title, String amount, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF1B3D3D)),
            const SizedBox(width: 4),
            Text(title, style: const TextStyle(color: Color(0xFF1B3D3D), fontSize: 11)),
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

  Widget _buildDynamicChart(Map<String, dynamic> data) {
    final barHeights = (data['bars'] as List<double>);
    final labels = (data['labels'] as List<String>);

    return Container(
      height: 200,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(barHeights.length, (index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 12,
                height: (barHeights[index] * 1.2).clamp(5, 140), // Биіктігін шектеу
                decoration: BoxDecoration(
                  color: index % 2 == 0 ? const Color(0xFF00D19E) : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 46,
                child: Text(labels[index], textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 9, color: Colors.black45)),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStatCard(String title, String amount, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
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
            Text(title, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            const SizedBox(height: 4),
            Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1B3D3D))),
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