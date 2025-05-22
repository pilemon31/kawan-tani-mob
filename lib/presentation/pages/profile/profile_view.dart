import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_kawan_tani/presentation/controllers/profile/profile_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/profile/profile_edit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    if (_controller.user.isEmpty && !_controller.isLoading.value) {
      _controller.loadInitialData();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          'Profil Saya',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.pencil()),
            onPressed: () => Get.to(() => ProfileEdit()),
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_controller.errorMessage.value),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _controller.loadInitialData(),
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        }

        final user = _controller.user;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade300,
                child: const Icon(Icons.person, size: 60, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildInfoCard('Email', user['email']),
              _buildInfoCard('No HP', user['phoneNumber']),
              _buildInfoCard(
                'Tanggal Lahir',
                (user['dateOfBirth']?.toString().split('T')[0]) ?? '-',
              ),
              _buildInfoCard(
                'Jenis Kelamin',
                _getGenderText(user['gender']),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoCard(String label, String? value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13, color: Colors.grey.shade600)),
            const SizedBox(height: 4),
            Text(
              value ?? '-',
              style: GoogleFonts.poppins(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  String _getGenderText(dynamic gender) {
    if (gender == 0) return 'Laki-laki';
    if (gender == 1) return 'Perempuan';
    return 'Tidak diketahui';
  }
}
