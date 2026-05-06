import 'package:fintrack/presentation/blocs/splash/splash_bloc.dart';
import 'package:fintrack/presentation/blocs/splash/splash_event.dart';
import 'package:fintrack/presentation/blocs/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashBloc _splashBloc = SplashBloc();

  @override
  void initState() {
    super.initState();
    _splashBloc.add(SplashResolveNextRouteRequested());
  }

  @override
  void dispose() {
    _splashBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      bloc: _splashBloc,
      listener: (context, state) {
        if (state.nextRoute != null) {
          context.go(state.nextRoute!);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/vector2.png',
                width: 200,
              ),
              const Text(
                'FinTrack',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 46,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00D09E)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
