import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/auth/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget buildTextField(
      IconData icon, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            prefixIcon: Icon(icon, color: Colors.grey),
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  void handleNext() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi semua data sebelum melanjutkan."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

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
                    "Daftar Akun",
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text("Daftar sekarang dan nikmati berbagai\nfitur menarik!",
                      style: GoogleFonts.poppins(fontSize: 14)),

                  const SizedBox(height: 20),

                  buildTextField(
                      Icons.email, "johndoe@examplemail.com", emailController),
                  buildTextField(
                      Icons.lock, "****************", passwordController),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: handleNext,
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

                  const SizedBox(height: 250),

                  // Tombol di bagian bawah
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      children: [
                        Text(
                          "Belum memiliki akun?",
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF78D14D)),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text("Daftar",
                              style: GoogleFonts.poppins(
                                  color: const Color(0xFF78D14D),
                                  fontSize: 16)),
                        ),
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
