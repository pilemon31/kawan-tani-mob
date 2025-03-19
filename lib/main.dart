import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/Auth/login_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/intro/onboarding_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/intro/splash_screen.dart';
import "package:get/get.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "KawanTani",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const SplashPage()),
        GetPage(name: "/onboarding", page: () => const OnboardingPage()),
        GetPage(name: "/login", page: () => LogInScreen())
      ],
    );
  }
}
