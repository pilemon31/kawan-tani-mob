import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/registration_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/register/verification_successful.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String warningMessage = "";
  bool isLoading = false;

  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final _formKey = GlobalKey<FormState>();

  final RegistrationController controller = Get.find<RegistrationController>();

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.clear();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onNodeChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
    } else if (index == 3 && value.isNotEmpty) {
      _verifyCode();
    }
  }

  Future<void> _verifyCode() async {
    String verificationCode =
        _controllers.map((controller) => controller.text).join();

    if (verificationCode.length < 4 || verificationCode.contains(' ')) {
      setState(() {
        warningMessage = "Kode verifikasi harus diisi!";
      });
      return;
    }

    setState(() {
      isLoading = true;
      warningMessage = "";
    });

    try {
      final token = controller.token.value;

      if (token.isEmpty) {
        setState(() {
          warningMessage = "Sesi tidak valid, silakan daftar ulang";
          isLoading = false;
        });
        return;
      }

      final response = await AuthService.verifyAccount(
        token: token,
        verificationCode: verificationCode,
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        Get.off(() => const VerificationSuccessfulScreen());
      } else {
        setState(() {
          warningMessage = responseData['message'] ?? "Verifikasi gagal";
        });
      }
    } catch (e) {
      setState(() {
        warningMessage = "Terjadi kesalahan, coba lagi nanti";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _resendCode() async {
    setState(() {
      isLoading = true;
      warningMessage = "";
    });

    try {
      final token = controller.token.value;
      final response = await AuthService.sendActivation(token);

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Successfully resent code
        Get.snackbar(
          "Berhasil",
          "Kode verifikasi baru telah dikirim ke email Anda",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        setState(() {
          warningMessage =
              responseData['message'] ?? "Gagal mengirim ulang kode";
        });
      }
    } catch (e) {
      setState(() {
        warningMessage = "Terjadi kesalahan, coba lagi nanti";
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78D14D),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
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
                  padding: const EdgeInsets.only(top: 30.0) +
                      const EdgeInsets.symmetric(horizontal: 16.0) +
                      const EdgeInsets.symmetric(vertical: 54.0),
                  child: Column(
                    children: [
                      Text(
                        "KawanTani",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 36.0,
                          fontWeight: bold,
                          color: whiteColor,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        "Teman Bertani Anda",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: light,
                          color: whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 38.0, vertical: 28.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: const BorderRadius.only(
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
                            Text(
                              "Verifikasi Akun",
                              style: GoogleFonts.poppins(
                                fontSize: 28.0,
                                fontWeight: semiBold,
                                color: blackColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.77,
                              child: Text(
                                "Cek kotak masuk ke email anda untuk menerima kode verifikasi",
                                style: GoogleFonts.poppins(
                                  fontSize: 15.0,
                                  fontWeight: light,
                                  color: blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: GoogleFonts.poppins(fontSize: 15),
                                  children: <TextSpan>[
                                    const TextSpan(
                                      text:
                                          "Kode verifikasi anda kami kirimkan ke alamat ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: controller.email.value,
                                      style: GoogleFonts.poppins(
                                        fontSize: 15.0,
                                        fontWeight: light,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 22),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(4, (index) {
                                  return Container(
                                    width: 63,
                                    height: 63,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
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
                                        fillColor: const Color(0xffE7EFF2),
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
                                    ),
                                  );
                                }),
                              ),
                              if (warningMessage.isNotEmpty) ...[
                                const SizedBox(height: 22),
                                Text(
                                  warningMessage,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 22),
                              Text(
                                "Tidak menerima kode?",
                                style: GoogleFonts.poppins(fontSize: 15),
                              ),
                              TextButton(
                                onPressed: isLoading ? null : _resendCode,
                                style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory,
                                ),
                                child: Text(
                                  "Kirim ulang",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: isLoading
                                        ? Colors.grey
                                        : const Color(0xff78D14D),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isLoading ? null : _verifyCode,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isLoading ? Colors.grey : primaryColor,
                            elevation: 0.0,
                            minimumSize: const Size(double.infinity, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Verifikasi',
                                  style: GoogleFonts.poppins(
                                    color: whiteColor,
                                    fontSize: 16,
                                    fontWeight: bold,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
