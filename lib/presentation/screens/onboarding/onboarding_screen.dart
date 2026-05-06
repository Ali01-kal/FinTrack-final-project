import 'package:fintrack/core/constants/app_constants.dart';
import 'package:fintrack/presentation/blocs/onboarding/onboarding_bloc.dart';
import 'package:fintrack/presentation/blocs/onboarding/onboarding_event.dart';
import 'package:fintrack/presentation/blocs/onboarding/onboarding_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final OnboardingBloc _onboardingBloc = OnboardingBloc();
  int _page = 0;

  final List<_OnboardingItem> _items = const [
    _OnboardingItem(
      title: 'Track Every Expense',
      subtitle: 'Log income and expenses in seconds and keep control of your daily budget.',
      icon: Icons.receipt_long_outlined,
    ),
    _OnboardingItem(
      title: 'See Smart Insights',
      subtitle: 'Understand where your money goes with clear analytics and categories.',
      icon: Icons.pie_chart_outline,
    ),
    _OnboardingItem(
      title: 'Grow Your Savings',
      subtitle: 'Build better habits and hit your goals with consistent tracking.',
      icon: Icons.savings_outlined,
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    _onboardingBloc.close();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    _onboardingBloc.add(OnboardingCompleteRequested());
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _page == _items.length - 1;
    return BlocListener<OnboardingBloc, OnboardingState>(
      bloc: _onboardingBloc,
      listener: (context, state) {
        if (state.isCompleted) {
          context.go(AppConstants.routeWelcome);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFC107),
        body: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: const Text('Skip', style: TextStyle(color: Color(0xFF1B3D3D))),
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _items.length,
                  onPageChanged: (index) => setState(() => _page = index),
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 140,
                            height: 140,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(item.icon, size: 64, color: const Color(0xFF00D19E)),
                          ),
                          const SizedBox(height: 36),
                          Text(
                            item.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF1B3D3D),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item.subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16, color: Color(0xFF2E5A5A)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _items.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _page == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _page == index ? const Color(0xFF1B3D3D) : Colors.white70,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (isLast) {
                        await _completeOnboarding();
                      } else {
                        await _controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOut,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D19E),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: Text(isLast ? 'Get Started' : 'Next'),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingItem {
  final String title;
  final String subtitle;
  final IconData icon;

  const _OnboardingItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
