import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/models/workshop_model.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WorkshopRegistrationSuccess extends StatelessWidget {
  final Workshop workshop;
  final WorkshopRegistration registration;

  const WorkshopRegistrationSuccess({
    super.key,
    required this.workshop,
    required this.registration,
  });

  @override
  Widget build(BuildContext context) {
    // Helper function to get payment method name from ID
    String _getPaymentMethodName(int methodId) {
      switch (methodId) {
        case 1:
          return 'Gopay';
        case 2:
          return 'DANA';
        case 3:
          return 'OVO';
        case 4:
          return 'QRIS';
        default:
          return 'Unknown';
      }
    }

    // Helper function to get gender name from ID
    String _getGenderName(int genderId) {
      return genderId == 1 ? 'Laki-Laki' : 'Perempuan';
    }

    // Helper function to format date string
    String _formatDate(String dateString) {
      try {
        final date = DateTime.parse(dateString);
        return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(date);
      } catch (e) {
        return '-';
      }
    }

    // Helper function to format time string
    String _formatTime(String timeString) {
      try {
        final time = TimeOfDay(
          hour: int.parse(timeString.split(':')[0]),
          minute: int.parse(timeString.split(':')[1]),
        );
        // Format to HH:mm and add timezone abbreviation
        return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} WIB';
      } catch (e) {
        return '-';
      }
    }

    // Base URL for images
    const String baseUrl =
        'https://kawan-tani-backend-production.up.railway.app/uploads/workshops/';

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: Text(
          'Pendaftaran Berhasil',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: blackColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat!',
              style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Anda telah terdaftar pada workshop ini, berikut adalah detail tiket Anda.',
              style: greyTextStyle.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Workshop Details
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      workshop.gambarWorkshop.isNotEmpty
                          ? '$baseUrl${workshop.gambarWorkshop}'
                          : 'https://via.placeholder.com/400x200',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 100),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    workshop.judulWorkshop,
                    style:
                        blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(PhosphorIconsRegular.calendar,
                      _formatDate(workshop.tanggalWorkshop)),
                  const SizedBox(height: 8),
                  _buildDetailRow(PhosphorIconsRegular.mapPin,
                      workshop.alamatLengkapWorkshop),
                  const SizedBox(height: 8),
                  _buildDetailRow(PhosphorIconsRegular.clock,
                      '${_formatTime(workshop.waktuMulai)} - ${_formatTime(workshop.waktuBerakhir)}'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Participant and Payment Info
            _buildInfoSection(
              title: 'Informasi Peserta:',
              details: {
                'Nomor Tiket': registration.nomorTiket,
                'Nama Peserta':
                    '${registration.namaDepanPeserta} ${registration.namaBelakangPeserta}',
                'Email': registration.emailPeserta,
                'Nomor Telepon': registration.nomorTeleponPeserta,
                'Jenis Kelamin':
                    _getGenderName(registration.jenisKelaminPeserta),
              },
            ),
            const SizedBox(height: 24),
            _buildInfoSection(
              title: 'Informasi Pembayaran:',
              details: {
                'Metode Pembayaran':
                    _getPaymentMethodName(registration.idMetodePembayaran),
                'Total Harga':
                    'Rp. ${workshop.hargaWorkshop?.toString() ?? '-'}',
                'Status Pembayaran':
                    registration.statusPembayaran ? 'Lunas' : 'Belum Lunas',
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Get.offAll(() => HomeScreen());
                },
                child: Text(
                  'Kembali Ke Halaman Utama',
                  style:
                      whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget helper for detail rows with icons
  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PhosphorIcon(icon, size: 20, color: blackColor),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: blackTextStyle.copyWith(fontSize: 14),
          ),
        ),
      ],
    );
  }

  // Widget helper for information sections (participant & payment)
  Widget _buildInfoSection(
      {required String title, required Map<String, String> details}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: details.entries
                .map((entry) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(entry.key,
                              style: greyTextStyle.copyWith(fontSize: 14)),
                          Expanded(
                            child: Text(
                              entry.value,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              style: blackTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
