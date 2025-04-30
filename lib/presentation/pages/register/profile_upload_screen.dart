import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/register/sign_up_confirmation_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";
import 'package:flutter_kawan_tani/presentation/controllers/auth/registration_controller.dart';

class ProfileUpload extends StatefulWidget {
  const ProfileUpload({super.key});

  @override
  State<ProfileUpload> createState() => _ProfileUploadState();
}

class _ProfileUploadState extends State<ProfileUpload> {
  final RegistrationController controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = controller.firstName.value;
    _emailController.text = controller.email.value;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    super.dispose();
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
                    SizedBox(
                      height: 5.0,
                    ),
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
                    padding: EdgeInsets.symmetric(horizontal: 38.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: ListView(
                      children: [
                        Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Daftar Akun",
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
                                  "Masukkan Foto Profil",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15.0,
                                      color: blackColor,
                                      fontWeight: light),
                                ),
                              ),
                            ),
                            SizedBox(height: 29.0),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Foto Profil",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            fontSize: 20, color: blackColor),
                                      ),
                                      SizedBox(height: 9.0),
                                      Container(
                                        padding: EdgeInsets.all(56.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: PhosphorIcon(
                                          PhosphorIconsRegular.upload,
                                          size: 41.0,
                                          color: Color(0xff8594AC),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 42),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: whiteColor,
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        minimumSize: Size(double.infinity, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        side: BorderSide(color: primaryColor)),
                                    child: Text(
                                      'Ambil Foto',
                                      style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: bold),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: whiteColor,
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        minimumSize: Size(double.infinity, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        side: BorderSide(color: primaryColor)),
                                    child: Text(
                                      'Upload Dari Galeri',
                                      style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: bold),
                                    ),
                                  ),

                                  SizedBox(height: 56),
                                  // Button Selanjutnya
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.to(() => SignUpConfirmationScreen());
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
                                      'Selanjutnya',
                                      style: GoogleFonts.poppins(
                                          color: whiteColor,
                                          fontSize: 16,
                                          fontWeight: bold),
                                    ),
                                  ),
                                  SizedBox(height: 18),
                                  // Button Kembali
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: whiteColor,
                                        elevation: 0.0,
                                        shadowColor: Colors.transparent,
                                        minimumSize: Size(double.infinity, 48),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        side: BorderSide(color: primaryColor)),
                                    child: Text(
                                      'Kembali',
                                      style: GoogleFonts.poppins(
                                          color: primaryColor,
                                          fontSize: 16,
                                          fontWeight: bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ));
  }
}
