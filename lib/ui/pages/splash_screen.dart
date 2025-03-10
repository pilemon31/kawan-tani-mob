import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/ui/pages/onboarding_screen.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), (){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage(),),);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF78D14D),
      body: Center(
        child: Container(
          width: 200.78,
          height: 211.74,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(
            'assets/logo.png',
            ),
          )),
        ),
      ),
    );
  }
}
