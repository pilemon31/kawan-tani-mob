import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_kawan_tani/presentation/controllers/profile/profile_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/profile/profile_edit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController _controller = Get.find();

  Future<void> _goToEdit() async {
    print('🚀 Navigating to ProfileEdit');

    // Navigate to edit page and wait for result
    final result = await Get.to(() => ProfileEdit());

    // If edit was successful, refresh data
    if (result == 'updated') {
      print('🔄 Edit was successful, refreshing profile data');
      await _controller.refreshProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Load fresh data when this screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.user.isEmpty && !_controller.isLoading.value) {
        _controller.loadInitialData();
      }
    });

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
            onPressed: _goToEdit,
          ),
          // Add refresh button for manual refresh
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.arrowClockwise()),
            onPressed: () {
              print('🔄 Manual refresh triggered');
              _controller.refreshProfile();
            },
          ),
        ],
      ),
      body: Obx(() {
        print('🖼️ ProfileView rebuilding with user data: ${_controller.user}');

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

        return RefreshIndicator(
          onRefresh: () async {
            print('📱 Pull to refresh triggered');
            await _controller.refreshProfile();
          },
          child: SingleChildScrollView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Enable pull to refresh
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade300,
                  child:
                      const Icon(Icons.person, size: 60, color: Colors.white),
                ),
                const SizedBox(height: 16),
                Text(
                  '${user['firstName'] ?? ''} ${user['lastName'] ?? ''}',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Terakhir diperbarui: ${DateTime.now().toString().split('.')[0]}',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
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

                // Debug info (you can remove this in production)
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Debug Info:',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'User ID: ${user['id'] ?? 'N/A'}',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Data keys: ${user.keys.toList()}',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
    if (gender == 1) return 'Laki-laki';
    if (gender == 2) return 'Perempuan';
    return 'Tidak diketahui';
  }
}
