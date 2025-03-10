import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/ui/pages/profile_upload_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? selectedGender;

  Widget buildTextField(
      String label, IconData icon, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
        const SizedBox(height: 5),
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

  Widget buildGenderButton(String gender, Color color) {
    return Flexible(
      child: GestureDetector(
        onTap: () => setState(() => selectedGender = gender),
        child: Container(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: selectedGender == gender ? color : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            gender,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              color: selectedGender == gender ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void handleNext() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        selectedGender == null) {
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
      MaterialPageRoute(builder: (context) => const ProfileUpload()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF78D14D),
      body: SingleChildScrollView(
        child: Column(
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
                    style:
                        GoogleFonts.poppins(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),

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

                  buildTextField(
                      "Nama Depan", Icons.person, "John Doe", firstNameController),
                  buildTextField(
                      "Nama Belakang", Icons.person, "John Doe", lastNameController),
                  buildTextField("Email", Icons.email, "johndoe@examplemail.com",
                      emailController),
                  buildTextField("Nomor Telepon", Icons.phone, "+628234569",
                      phoneController),

                  Text("Jenis Kelamin",
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),

                  // Gender Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildGenderButton("Laki-Laki", Colors.blue),
                      const SizedBox(width: 10),
                      buildGenderButton("Perempuan", Colors.pink),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Buttons
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: handleNext,
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
      ),
    );
  }
}
