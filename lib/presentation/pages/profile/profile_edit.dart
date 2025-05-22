import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:flutter_kawan_tani/presentation/controllers/profile/profile_controller.dart';

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

    print('🚀 Submitting profile update: $updatedData');

    try {
      // Update profile
      final success = await _controller.updateProfile(updatedData);

      if (success) {
        print('✅ Profile update successful, showing success message');

        // Show success message
        Get.snackbar(
          'Berhasil',
          'Profil berhasil diperbarui',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        // Wait a moment then go back
        await Future.delayed(const Duration(milliseconds: 800));
        Get.offAllNamed('/home');

        // Trigger manual refresh pada controller sebelum kembali
        await _controller.refreshProfile();

        print('🔙 Going back to previous screen');
        Get.back(
            result: 'updated'); // Pass result to indicate update was successful
      }
    } catch (e) {
      print('❌ Profile update failed: $e');
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
      appBar: AppBar(
        title: Text('Edit Profil', style: GoogleFonts.poppins()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(_firstNameController, 'Nama Depan',
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Nama depan wajib diisi'
                      : null),
              const SizedBox(height: 20),
              _buildTextField(_lastNameController, 'Nama Belakang'),
              const SizedBox(height: 20),
              _buildTextField(_emailController, 'Email'),
              const SizedBox(height: 20),
              _buildTextField(
                _phoneController,
                'Nomor HP',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Lahir',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<int>(
                value: _selectedGender,
                decoration: const InputDecoration(labelText: 'Jenis Kelamin'),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Laki-laki')),
                  DropdownMenuItem(value: 2, child: Text('Perempuan')),
                ],
                onChanged: (value) => setState(() {
                  _selectedGender = value;
                }),
                validator: (value) =>
                    value == null ? 'Pilih jenis kelamin' : null,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                _passwordController,
                'Password Baru',
                hintText: 'Kosongkan jika tidak ingin mengubah',
                obscureText: true,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                _confirmPasswordController,
                'Konfirmasi Password Baru',
                hintText: 'Kosongkan jika tidak ingin mengubah',
                obscureText: true,
                validator: (value) {
                  if (_passwordController.text.isNotEmpty &&
                      value != _passwordController.text) {
                    return 'Password tidak cocok';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _saveProfile,
                  child: _isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Simpan Perubahan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
    );
  }
}
