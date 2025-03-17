import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/ui/pages/auth/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordChangeVerificationScreen extends StatefulWidget {
  const PasswordChangeVerificationScreen({super.key});

  @override
  State<PasswordChangeVerificationScreen> createState() =>
      _PasswordChangeVerificationScreentate();
}

class _PasswordChangeVerificationScreentate
    extends State<PasswordChangeVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78D14D),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.only(top: 70, bottom: 30),
            child: Column(
              children: [
                Text(
                  "Kawan Tani",
                  style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  "Teman Bertani Anda",
                  style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),

          // Form dalam Expanded agar tombol tetap di bawah
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verifikasi Berhasil",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text("Selamat akun anda berhasil\ndiaktifkan",
                      style: GoogleFonts.poppins(fontSize: 14)),

                  const SizedBox(height: 180),

                  Center(
                    child: Text(
                      "Selamat! password akun anda\nberhasil diganti",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 300),

                  // Tombol di bagian bawah
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF78D14D),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Masuk",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 16)),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
