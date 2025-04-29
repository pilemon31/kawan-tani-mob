import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_list.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/intro/splash_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/login/login_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/intro/onboarding_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/plants/start_planting_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/plants/your_plants_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/workshops_list.dart';
import "package:get/get.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "KawanTani",
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: [
        GetPage(name: "/", page: () => const SplashPage()),
        GetPage(name: "/onboarding", page: () => const OnboardingPage()),
        GetPage(name: "/login", page: () => const LogInScreen()),
        GetPage(name: "/home", page: () => const HomeScreen()),
        GetPage(name: "/plants", page: () => const YourPlantsScreen()),
        GetPage(name: "/articles", page: () => const ArticleList()),
        GetPage(name: "/workshops", page: () => const WorkshopsList()),
        GetPage(name: "/add", page: () => const StartPlantingScreen())
      ],
    );
  }
}
