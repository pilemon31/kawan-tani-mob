import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/registration_controller.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/validation_service.dart';
import 'package:flutter_kawan_tani/presentation/pages/login/login_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/register/signup_detail_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final RegistrationController controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final ValidationService _inputValidator = ValidationService();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = controller.firstName.value;
    _emailController.text = controller.emailAddress.value;
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
                  padding: EdgeInsets.symmetric(vertical: 28.0) +
                      EdgeInsets.symmetric(horizontal: 38.0),
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
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.77,
                              child: Text(
                                "Daftar sekarang dan nikmati berbagai fitur menarik!",
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama Depan",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _firstNameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "John",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIconsRegular.user,
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator: _inputValidator.validateName,
                                      onSaved: (value) {
                                        controller.firstName.value =
                                            value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        hintText: "johndoe@examplemail.com",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIconsRegular.envelope,
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator: _inputValidator.validateEmail,
                                      onSaved: (value) {
                                        controller.emailAddress.value =
                                            value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.0),
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Get.to(() => SignUpDetailScreen());
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
                                    'Daftar Akun',
                                    style: GoogleFonts.poppins(
                                        color: whiteColor,
                                        fontSize: 16,
                                        fontWeight: bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Belum memiliki akun?",
                            style: GoogleFonts.poppins(
                                fontSize: 14, fontWeight: light),
                          ),
                          SizedBox(height: 15.0),
                          ElevatedButton(
                            onPressed: () {
                              Get.to(() => LogInScreen());
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
                              'Daftar Akun',
                              style: GoogleFonts.poppins(
                                  color: primaryColor,
                                  fontSize: 16,
                                  fontWeight: bold),
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
