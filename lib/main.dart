import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_comments.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_list.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/intro/splash_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/login/login_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/intro/onboarding_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/plants/start_planting_screen.dart';
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
        GetPage(name: "/", page: () => const HomeScreen()),
        GetPage(name: "/onboarding", page: () => const OnboardingPage()),
        GetPage(name: "/login", page: () => LogInScreen()),
        GetPage(name: "/home", page: () => HomeScreen()),
        GetPage(name: "/plants", page: () => StartPlantingScreen()),
        GetPage(name: "/articles", page: () => ArticleList()),
        GetPage(name: "/workshops", page: () => WorkshopsList())
      ],
    );
  }
}
