import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/validation_service.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/auth/signup_screen.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:get/get.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValidationService _inputValidator = ValidationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78D14D),
      resizeToAvoidBottomInset: false,
      body: Column(
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
                color: whiteColor, // Set background color here
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0), // Set border radius
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
                          "Masuk",
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
                            "Masuk ke akun anda, untuk melanjutkan",
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
                                  "Email",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: blackColor),
                                ),
                                SizedBox(height: 8.0),
                                // Container with background color
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
                                          vertical: 12.0, horizontal: 15.0)
                                      // Adjust vertical padding
                                      ),
                                  validator: _inputValidator.validateEmail,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: blackColor),
                                ),
                                SizedBox(height: 8.0),
                                // Container with background color
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: obscureText,
                                  decoration: InputDecoration(
                                      hintText: "*********",
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 15.0, fontWeight: light),
                                      prefixIcon: PhosphorIcon(
                                        PhosphorIconsRegular.lock,
                                        size: 19.0,
                                        color: Color(0xff8594AC),
                                      ),
                                      suffixIcon: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                        child: PhosphorIcon(
                                            obscureText
                                                ? PhosphorIconsRegular.eyeSlash
                                                : PhosphorIconsRegular.eye,
                                            size: 19.0,
                                            color: Color(0xff8594AC)),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none),
                                      fillColor: Color(0xffE7EFF2),
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 15.0)
                                      // Adjust vertical padding
                                      ),
                                  validator: _inputValidator.validatePassword,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  print('Email: ${_emailController.text}');
                                  print(
                                      'Password: ${_passwordController.text}');
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
                                'Masuk',
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
                          Get.to(() => SignUpScreen());
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
    );
  }
}
