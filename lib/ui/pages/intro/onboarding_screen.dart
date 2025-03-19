import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:flutter_kawan_tani/ui/pages/auth/login_screen.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 60);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _OnboardingPageState extends State<OnboardingPage> {
  int currentIndex = 0;

  final List<String> images = [
    'assets/splash_screen1.jpg',
    'assets/splash_screen2.jpg',
    'assets/splash_screen3.jpg',
  ];

  final List<String> title = [
    'Jaminan Kualitas Terbaik',
    'Aplikasi Ramah Pengguna',
    'Distribusi Seluruh Indonesia',
  ];

  final List<String> subtitle = [
    'Dapatkan produk pangan berkualitas terbaik yang diproduksi langsung oleh petani dan peternak dengan penuh cinta',
    'Aplikasi dengan antarmuka ramah pengguna, dilengkapi dengan berbagai fitur yang  mempermudah kebutuhan pengguna.',
    'Seluruh produk pangan dapat didistribusikan ke seluruh Indonesia dengan tarif ongkir yang terjangkau dan terjamin keamannanya.',
  ];

  void _nextPage() {
    if (currentIndex < images.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LogInScreen()),
      );
    }
  }

  void _prevPage() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipPath(
            clipper: CurvedBottomClipper(),
            child: Image.asset(
              images[currentIndex],
              width: double.infinity,
              height: mediaQuery.size.height * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                  child: Column(
                    children: [
                      Text(
                        title[currentIndex],
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        subtitle[currentIndex],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(bottom: 60.0, right: 60.0, left: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _prevPage,
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                          backgroundColor: primaryColor,
                        ),
                        child: PhosphorIcon(
                          PhosphorIconsRegular.arrowLeft,
                          color: Colors.white,
                          size: 24.0,
                          semanticLabel: 'Prev Section',
                        ),
                      ),
                      Row(children: [
                        ...List.generate(
                            3,
                            (index) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 6),
                                  width: 10,
                                  height: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: index == currentIndex
                                        ? primaryColor
                                        : greyColor,
                                  ),
                                )),
                      ]),
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(10),
                          backgroundColor: primaryColor,
                        ),
                        child: PhosphorIcon(
                          PhosphorIconsRegular.arrowRight,
                          color: Colors.white,
                          size: 24.0,
                          semanticLabel: 'Next Section',
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
