import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'package:flutter_kawan_tani/presentation/controllers/profile/profile_controller.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';

class ProfileEdit extends StatefulWidget {
  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final ProfileController _controller = Get.find();
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  int? _selectedGender;
  bool _isSubmitting = false;
  bool isMaleClicked = false;
  bool isFemaleClicked = false;

  @override
  void initState() {
    super.initState();
    final user = _controller.user;

    _firstNameController = TextEditingController(text: user['firstName'] ?? '');
    _lastNameController = TextEditingController(text: user['lastName'] ?? '');
    _emailController = TextEditingController(text: user['email'] ?? '');
    _phoneController = TextEditingController(text: user['phoneNumber'] ?? '');
    _birthDateController = TextEditingController(
      text: user['dateOfBirth'] != null
          ? DateFormat('yyyy-MM-dd').format(DateTime.parse(user['dateOfBirth']))
          : '',
    );
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _selectedGender =
        (user['gender'] == 1 || user['gender'] == 2) ? user['gender'] : 1;

    if (_selectedGender == 1) {
      isMaleClicked = true;
      isFemaleClicked = false;
    } else if (_selectedGender == 2) {
      isMaleClicked = false;
      isFemaleClicked = true;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _birthDateController.text.isNotEmpty
          ? DateTime.parse(_birthDateController.text)
          : DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _birthDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void clickedMale() {
    _selectedGender = 1;
    setState(() {
      isMaleClicked = true;
      isFemaleClicked = false;
    });
  }

  void clickedFemale() {
    _selectedGender = 2;
    setState(() {
      isMaleClicked = false;
      isFemaleClicked = true;
    });
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState?.validate() != true) return;
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
    });

    final updatedData = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'email': _emailController.text.trim(),
      'phoneNumber': _phoneController.text.trim(),
      'dateOfBirth': _birthDateController.text.isNotEmpty
          ? '${_birthDateController.text}T00:00:00.000Z'
          : null,
      'gender': _selectedGender,
      'password': _passwordController.text.trim(),
      'confirmPassword': _confirmPasswordController.text.trim(),
    };

    try {
      // Update profile
      final success = await _controller.updateProfile(updatedData);

      if (success) {
        // Show success message
        Get.snackbar(
          'Berhasil',
          'Profil berhasil diperbarui',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        await Future.delayed(const Duration(milliseconds: 800));
        Get.offAllNamed('/home');

        await _controller.refreshProfile();
        Get.back(result: 'updated');
      }
    } catch (e) {
      Get.snackbar(
        'Gagal',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
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
              'Edit Profil',
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
              'Detail Profil',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            Text(
              'Perbarui informasi profil Anda untuk menjaga data tetap akurat',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: greyColor,
                fontWeight: medium,
              ),
            ),
            SizedBox(height: 10),
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
                          hintText: "Masukkan nama depan",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15.0, fontWeight: light),
                          prefixIcon: PhosphorIcon(
                            PhosphorIcons.user(),
                            size: 19.0,
                            color: Color(0xff8594AC),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xffE7EFF2),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                        ),
                        validator: (value) =>
                            value == null || value.trim().isEmpty
                                ? 'Nama depan wajib diisi'
                                : null,
                      ),
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
                      TextFormField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "Masukkan nama belakang",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15.0, fontWeight: light),
                          prefixIcon: PhosphorIcon(
                            PhosphorIcons.user(),
                            size: 19.0,
                            color: Color(0xff8594AC),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xffE7EFF2),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                        ),
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
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "contoh@email.com",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15.0, fontWeight: light),
                          prefixIcon: PhosphorIcon(
                            PhosphorIcons.envelope(),
                            size: 19.0,
                            color: Color(0xff8594AC),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xffE7EFF2),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Nomor HP
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nomor HP",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: blackColor),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
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
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xffE7EFF2),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                        ),
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
                        controller: _birthDateController,
                        readOnly: true,
                        onTap: () => _selectDate(context),
                        decoration: InputDecoration(
                          hintText: "Pilih tanggal lahir",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15.0, fontWeight: light),
                          prefixIcon: PhosphorIcon(
                            PhosphorIcons.calendar(),
                            size: 19.0,
                            color: Color(0xff8594AC),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xffE7EFF2),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                        ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: clickedMale,
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: isMaleClicked
                                    ? Color(0x00ffffff)
                                    : Color(0xffE7EFF2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                side: isMaleClicked
                                    ? BorderSide(color: Color(0xffE7EFF2))
                                    : BorderSide.none,
                              ),
                              child: Text(
                                "Laki-Laki",
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Color(0xff4993F8)),
                              ),
                            ),
                          ),
                          SizedBox(width: 18),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: clickedFemale,
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: isFemaleClicked
                                    ? Color(0x00ffffff)
                                    : Color(0xffE7EFF2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: isFemaleClicked
                                      ? BorderSide(color: Color(0xffE7EFF2))
                                      : BorderSide.none,
                                ),
                              ),
                              child: Text(
                                "Perempuan",
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Color(0xffF99D9D)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Password Baru
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password Baru",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: blackColor),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Kosongkan jika tidak ingin mengubah",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15.0, fontWeight: light),
                          prefixIcon: PhosphorIcon(
                            PhosphorIcons.lock(),
                            size: 19.0,
                            color: Color(0xff8594AC),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xffE7EFF2),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  // Konfirmasi Password
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Konfirmasi Password Baru",
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: blackColor),
                      ),
                      SizedBox(height: 8.0),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Kosongkan jika tidak ingin mengubah",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 15.0, fontWeight: light),
                          prefixIcon: PhosphorIcon(
                            PhosphorIcons.lock(),
                            size: 19.0,
                            color: Color(0xff8594AC),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Color(0xffE7EFF2),
                          filled: true,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 15.0),
                        ),
                        validator: (value) {
                          if (_passwordController.text.isNotEmpty &&
                              value != _passwordController.text) {
                            return 'Password tidak cocok';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 28),

                  // Button Simpan
                  ElevatedButton(
                    onPressed: _isSubmitting ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isSubmitting
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Simpan Perubahan',
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: BorderSide(color: primaryColor)),
                    child: Text(
                      'Batal',
                      style: GoogleFonts.poppins(
                          color: primaryColor, fontSize: 16, fontWeight: bold),
                    ),
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
