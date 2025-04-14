import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/registration_controller.dart';
import 'package:flutter_kawan_tani/presentation/controllers/auth/validation_service.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RegisterWorkshop extends StatefulWidget {
  const RegisterWorkshop({super.key});

  @override
  State<RegisterWorkshop> createState() => _RegisterWorkshopState();
}

class _RegisterWorkshopState extends State<RegisterWorkshop> {
    String warningMessage = "";
  final RegistrationController controller = Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final ValidationService _inputValidator = ValidationService();

    @override
  void initState() {
    super.initState();

    _firstNameController.text = controller.firstName.value;
    _emailController.text = controller.emailAddress.value;
    _phoneNumberController.text = controller.phoneNumber.value;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void verifyData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Get.to();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: PhosphorIcon(
                PhosphorIconsBold.arrowLeft,
                size: 32.0,
              ),
            ),
            title: Text(
              'Cabaiku Tani',
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: ListView(
          children: [
            Text(
              'Detail Pendaftaran',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            Text(
              'Detail kontak ini akan digunakan untuk pengisian data diri dan pengiriman e-tiket workshop',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: greyColor,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 10),
                                  Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                                    TextFormField(
                                      controller: _firstNameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "John",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIcons.user(),
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
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
                                    TextFormField(
                                      controller: _firstNameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "08/08/2008",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIcons.calendar(),
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator: _inputValidator.validateName,
                                      onSaved: (value) {
                                        controller.lastName.value = value ?? "";
                                      },
                                    ),
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
                                    TextFormField(
                                      controller: _firstNameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "johndoe@examplemail.com",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIcons.envelope(),
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator: _inputValidator.validateName,
                                      onSaved: (value) {
                                        controller.lastName.value = value ?? "";
                                      },
                                    ),
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
                                    TextFormField(
                                      controller: _firstNameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "+628234569",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIcons.phone(),
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator: _inputValidator.validateName,
                                      onSaved: (value) {
                                        controller.lastName.value = value ?? "";
                                      },
                                    ),
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
                                    TextFormField(
                                      controller: _firstNameController,
                                      keyboardType: TextInputType.name,
                                      decoration: InputDecoration(
                                        hintText: "Laki-laki",
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 15.0, fontWeight: light),
                                        prefixIcon: PhosphorIcon(
                                          PhosphorIcons.genderNeuter(),
                                          size: 19.0,
                                          color: Color(0xff8594AC),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        fillColor: Color(0xffE7EFF2),
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.0, horizontal: 15.0),
                                      ),
                                      validator: _inputValidator.validateName,
                                      onSaved: (value) {
                                        controller.lastName.value = value ?? "";
                                      },
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (warningMessage.isNotEmpty)
                                      Container(
                                        padding: EdgeInsets.only(left: 16),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            warningMessage,
                                            style: GoogleFonts.poppins(
                                                fontSize: 11.5,
                                                color: const Color.fromARGB(
                                                    255, 187, 53, 43)),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                                SizedBox(height: 28),
                                // Button Selanjutnya
                                ElevatedButton(
                                  onPressed: verifyData,
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
                                    'Lanjutkan',
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
                                    'Keluar',
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
    );
  }
}
