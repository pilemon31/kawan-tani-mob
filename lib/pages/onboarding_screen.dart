import 'package:flutter_kawan_tani/pages/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class BottomEllipseClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - 50);
    path.quadraticBezierTo(size.width / 2, size.height, 0, size.height - 50);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
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
    'Dapatkan produk pangan berkualitas\nterbaik yang diproduksi langsung oleh\npetani dan peternak dengan penuh\ncinta',
    'Aplikasi dengan antarmuka ramah\npengguna, dilengkapi dengan berbagai\nfitur yang  mempermudah kebutuhan\npengguna.',
    'Seluruh produk pangan dapat\ndidistribusikan ke seluruh Indonesia\ndengan tarif ongkir yang terjangkau\ndan terjamin keamannanya.',
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 500,
            width: 410,
            child: ClipPath(
              clipper: BottomEllipseClipper(),
              child: Image.asset(
                images[currentIndex],
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 60),
          Text(
            title[currentIndex],
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            subtitle[currentIndex],
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0x59000000),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 60),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: currentIndex > 0 ? _prevPage : null,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF78D14D),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIcons.arrowLeft(),
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Row(
                children: List.generate(images.length, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex == index
                          ? Color(0xFF78D14D)
                          : Colors.grey,
                    ),
                  );
                }),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: _nextPage,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF78D14D),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    PhosphorIcons.arrowRight(),
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
