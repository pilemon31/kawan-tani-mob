import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get
import 'package:flutter_kawan_tani/presentation/pages/intro/onboarding_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    if (authController.isLoggedIn.value) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const OnboardingPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF78D14D),
              Color(0xFF349107),
            ],
          ),
        ),
        child: Center(
          child: Container(
            width: 200.78,
            height: 211.74,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
