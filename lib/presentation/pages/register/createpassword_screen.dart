import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/register/successful_registration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";
import 'package:flutter_kawan_tani/presentation/controllers/auth/registration_controller.dart';
import 'package:flutter_kawan_tani/utils/validation_utils.dart';

class CreatePasswordScreen extends StatefulWidget {
  const CreatePasswordScreen({super.key});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final RegistrationController controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ValidationService _inputValidator = ValidationService();

  @override
  void initState() {
    super.initState();
    _passwordController.text = controller.password.value;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Konfirmasi password harus diisi!";
    }

    if (value != _passwordController.text) {
      return "Konfirmasi dan password harus sama!";
    }

    return null;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                              "Buat Password",
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
                                "Masukkan password akun anda agar lebih aman",
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
                                      "Password",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: obscurePassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          hintText: "*********",
                                          hintStyle: GoogleFonts.poppins(
                                              fontSize: 15.0,
                                              fontWeight: light),
                                          prefixIcon: PhosphorIcon(
                                            PhosphorIconsRegular.lock,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                obscurePassword =
                                                    !obscurePassword;
                                              });
                                            },
                                            child: PhosphorIcon(
                                                obscurePassword
                                                    ? PhosphorIconsRegular
                                                        .eyeSlash
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
                                              vertical: 12.0,
                                              horizontal: 15.0)),
                                      validator:
                                          _inputValidator.validatePassword,
                                      onSaved: (value) {
                                        controller.password.value = value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Konfirmasi Password",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15, color: blackColor),
                                    ),
                                    SizedBox(height: 8.0),
                                    TextFormField(
                                      controller: _confirmPasswordController,
                                      obscureText: obscureConfirmPassword,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          hintText: "*********",
                                          hintStyle: GoogleFonts.poppins(
                                              fontSize: 15.0,
                                              fontWeight: light),
                                          prefixIcon: PhosphorIcon(
                                            PhosphorIconsRegular.lock,
                                            size: 19.0,
                                            color: Color(0xff8594AC),
                                          ),
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                obscureConfirmPassword =
                                                    !obscureConfirmPassword;
                                              });
                                            },
                                            child: PhosphorIcon(
                                                obscureConfirmPassword
                                                    ? PhosphorIconsRegular
                                                        .eyeSlash
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
                                              vertical: 12.0,
                                              horizontal: 15.0)),
                                      validator: confirmPasswordValidator,
                                      onSaved: (value) {
                                        controller.confirmPassword.value =
                                            value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();

                                Get.dialog(
                                  const Center(
                                      child: CircularProgressIndicator()),
                                  barrierDismissible: false,
                                );

                                try {
                                  final success =
                                      await controller.registerAccount();

                                  if (success) {
                                    Get.off(
                                        () => const SuccessfulRegistration());
                                  }
                                } catch (e) {
                                  Get.back();
                                  Get.snackbar(
                                    'Error',
                                    'Terjadi kesalahan saat registrasi: ${e.toString()}',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                } finally {
                                  if (Get.isDialogOpen!) Get.back();
                                }
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
                          SizedBox(height: 15.0),
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
