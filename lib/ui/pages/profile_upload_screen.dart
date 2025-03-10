import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileUpload extends StatefulWidget {
  const ProfileUpload({super.key});

  @override
  State<ProfileUpload> createState() => _ProfileUploadState();
}

class _ProfileUploadState extends State<ProfileUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF78D14D),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 60, bottom: 30),
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
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),

                          const SizedBox(height: 20),

            // Form
            Container(
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
                    "Daftar Akun",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text("Lengkapi daftar diri anda",
                      style: GoogleFonts.poppins(fontSize: 14)),

                  const SizedBox(height: 20),



                  Text("Jenis Kelamin",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),

                  const SizedBox(height: 30),

                  // Buttons
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF78D14D),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Lanjutkan",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 16)),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF78D14D)),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text("Kembali",
                            style: GoogleFonts.poppins(
                                color: const Color(0xFF78D14D), fontSize: 16)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ],
          ),
        ));
  }
}
