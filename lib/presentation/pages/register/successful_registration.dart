import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/register/verification_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";

class SuccessfulRegistration extends StatefulWidget {
  const SuccessfulRegistration({super.key});

  @override
  State<SuccessfulRegistration> createState() => _SuccessfulRegistrationState();
}

class _SuccessfulRegistrationState extends State<SuccessfulRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF78D14D),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF78D14D),
                Color(0xFF349107),
              ],
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0) +
                    EdgeInsets.symmetric(horizontal: 16.0) +
                    EdgeInsets.symmetric(vertical: 54.0),
                child: Column(
                  children: [
                    Text(
                      "KawanTani",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 36.0, fontWeight: bold, color: whiteColor),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      "Teman Bertani Anda",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18.0, fontWeight: light, color: whiteColor),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 38.0, vertical: 28.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Daftar Akun Berhasil",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontSize: 28.0,
                                    color: blackColor,
                                    fontWeight: semiBold),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.77,
                                child: Text(
                                  "Selamat akun anda berhasil dibuat, silahkan verifikasi akun anda",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                      color: blackColor,
                                      fontWeight: light),
                                ),
                              ),
                            ),
                          ]),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Sekarang, Anda dapat melanjutkan dengan memasukkan kode OTP yang dikirim melalui email Anda.",
                          style: GoogleFonts.poppins(fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => VerificationScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 0.0,
                          shadowColor: Colors.transparent,
                          minimumSize: Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Masuk',
                          style: GoogleFonts.poppins(
                              color: whiteColor,
                              fontSize: 16,
                              fontWeight: bold),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
