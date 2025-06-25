import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/articles/article_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_list.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/intro/splash_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/login/login_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/intro/onboarding_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/_addPlants/start_planting_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/_yourPlants/your_plants_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/workshops_list.dart';
import "package:get/get.dart";
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id', null);
  Get.put(AuthController());
  Get.put(ArticleController());
  runApp(const MyApp());
}

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
        GetPage(name: "/articles", page: () => ArticleList()),
        GetPage(name: "/workshops", page: () => const WorkshopsList()),
        GetPage(name: "/add", page: () => const StartPlantingScreen())
      ],
    );
  }
}
