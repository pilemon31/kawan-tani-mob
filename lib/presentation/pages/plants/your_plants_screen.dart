import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class YourPlantsScreen extends StatefulWidget {
  const YourPlantsScreen({super.key});

  @override
  State<YourPlantsScreen> createState() => _YourPlantsScreenState();
}

class _YourPlantsScreenState extends State<YourPlantsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27),
                child: AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 80.0,
                  leading: IconButton(
                    onPressed: () {
                    },
                    icon: PhosphorIcon(
                      PhosphorIconsBold.arrowLeft,
                      size: 32.0,
                    ),
                  ),
                  title: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Mulai Bertanam',
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: blackColor, fontWeight: bold),
                      )),
                  actions: [
                    IconButton(
                      onPressed: () {
                        
                      },
                      icon: PhosphorIcon(
                        PhosphorIconsFill.dotsThreeOutlineVertical,
                        size: 32.0,
                      ),
                    ),
                  ],
                ))),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),

        ),
        bottomNavigationBar: Navbar());

  }
}