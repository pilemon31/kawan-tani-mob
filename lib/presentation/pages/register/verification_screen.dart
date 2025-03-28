import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/register/verification_successful.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:flutter/services.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String warningMessage = "";
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  final _formKey = GlobalKey<FormState>();

  void _onNodeChanged(value, index) {
    if (value.length == 1) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
      } else {
        _verifyCode();
      }
    }
  }

  void _verifyCode() {
    String verificationCode =
        _controllers.map((controller) => controller.text).join();

    if (verificationCode.length < 3) {
      setState(() {
        warningMessage = "Kode verifikasi harus diisi!";
      });
    } else {
      Get.to(() => VerificationSuccessfulScreen());
    }
  }

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
                                "Verifikasi Akun",
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
                                  "Cek kotak masuk ke email anda untuk menerima kode verifikasi",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                      color: blackColor,
                                      fontWeight: light),
                                ),
                              ),
                            ),
                          ]),
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "Kode verifikasi anda kami kirimkan ke alamat ",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: "johndoe@examplemail.com",
                                    style: TextStyle(color: Color(0xff78D14D)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 22),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(4, (index) {
                                return Container(
                                    width: 63,
                                    height: 63,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: TextField(
                                      controller: _controllers[index],
                                      focusNode: _focusNodes[index],
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      style: const TextStyle(fontSize: 24),
                                      decoration: InputDecoration(
                                        counterText: '',
                                        filled: true,
                                        fillColor: Color(0xffE7EFF2),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      onChanged: (value) =>
                                          _onNodeChanged(value, index),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                    ));
                              }),
                            ),
                            if (warningMessage.isNotEmpty) ...[
                              SizedBox(height: 22),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  warningMessage,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.red),
                                ),
                              ),
                            ],
                            SizedBox(height: 22),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Tidak menerima kode?",
                                style: GoogleFonts.poppins(fontSize: 15),
                              ),
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        splashFactory: NoSplash.splashFactory),
                                    child: Text(
                                      "Kirim ulang",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          color: Color(0xff78D14D)),
                                    )))
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _verifyCode();
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
                          'Verifikasi',
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
