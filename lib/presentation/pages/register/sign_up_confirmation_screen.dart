import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/registration_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/register/createpassword_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";

class SignUpConfirmationScreen extends StatefulWidget {
  const SignUpConfirmationScreen({super.key});

  @override
  State<SignUpConfirmationScreen> createState() => _SignUpConfirmationState();
}

class _SignUpConfirmationState extends State<SignUpConfirmationScreen> {
  final RegistrationController controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = controller.firstName.value;
    _lastNameController.text = controller.lastName.value;
    _emailController.text = controller.email.value;
    _phoneNumberController.text = controller.phoneNumber.value;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
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
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Konfirmasi Data Diri",
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
                                "Konfirmasi data diri akun anda, pastikan sudah sesuai!",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.poppins(
                                    fontSize: 15.0,
                                    color: blackColor,
                                    fontWeight: light),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Nama Depan
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Depan",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Color(0xffE7EFF2),
                                              width: 2.0)),
                                      child: Row(
                                        children: [
                                          PhosphorIcon(
                                            PhosphorIconsRegular.user,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              controller.firstName.value,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: light),
                                            ),
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Nama Belakang
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Belakang",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Color(0xffE7EFF2),
                                              width: 2.0)),
                                      child: Row(
                                        children: [
                                          PhosphorIcon(
                                            PhosphorIconsRegular.user,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              controller.lastName.value,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: light),
                                            ),
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Email
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Color(0xffE7EFF2),
                                              width: 2.0)),
                                      child: Row(
                                        children: [
                                          PhosphorIcon(
                                            PhosphorIconsRegular.user,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              controller.email.value,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: light),
                                            ),
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Tanggal Lahir
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Tanggal Lahir",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Color(0xffE7EFF2),
                                              width: 2.0)),
                                      child: Row(
                                        children: [
                                          PhosphorIcon(
                                            PhosphorIconsRegular.user,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              controller.dateOfBirth.value,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: light),
                                            ),
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Nomor Telepon
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nomor Telepon",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Color(0xffE7EFF2),
                                              width: 2.0)),
                                      child: Row(
                                        children: [
                                          PhosphorIcon(
                                            PhosphorIconsRegular.user,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              controller.phoneNumber.value,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: light),
                                            ),
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                // Jenis Kelamin
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jenis Kelamin",
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0),
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                              color: Color(0xffE7EFF2),
                                              width: 2.0)),
                                      child: Row(
                                        children: [
                                          PhosphorIcon(
                                            PhosphorIconsRegular.user,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              controller.gender.value,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 15.0,
                                                  fontWeight: light),
                                            ),
                                          )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 56),
                                // Button Selanjutnya
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Get.to(() => CreatePasswordScreen());
                                    }
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
                                    _formKey.currentState?.save();
                                    Get.back();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: whiteColor,
                                      elevation: 0.0,
                                      shadowColor: Colors.transparent,
                                      minimumSize: Size(double.infinity, 48),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
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
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
