import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 секундтан кейін Login экранына өту
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/welcome'); // Немесе AppConstants.routeLogin
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      // Сен жіберген суреттегідей ақшыл-жасыл (Mint) түс
      backgroundColor: Colors.black, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
         
            Image.asset(
              'assets/images/vector2.png',
              width: 200, 
            ),

            Text(
              "FinTrack",
              style: TextStyle(
                color: Colors.white,
                fontSize: 46,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),
            
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}