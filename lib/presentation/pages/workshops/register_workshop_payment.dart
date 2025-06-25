import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/models/workshop_model.dart'; // Import model
import 'package:flutter_kawan_tani/presentation/controllers/workshop/register_workshop_controller.dart';
import 'package:flutter_kawan_tani/presentation/controllers/workshop/workshop_controller.dart'; // Import controller
import 'package:flutter_kawan_tani/presentation/pages/workshops/register_workshop_confirmation.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:intl/intl.dart'; // Import intl untuk format harga

class RegisterWorkshopPayment extends StatefulWidget {
  const RegisterWorkshopPayment({super.key});

  @override
  State<RegisterWorkshopPayment> createState() =>
      _RegisterWorkshopPaymentState();
}

class _RegisterWorkshopPaymentState extends State<RegisterWorkshopPayment> {
  // Dapatkan instance controller
  final RegisterWorkshopController registerWorkshopController =
      Get.find<RegisterWorkshopController>();
  final WorkshopController workshopController = Get.find<WorkshopController>();

  @override
  Widget build(BuildContext context) {
    // Ambil data workshop yang dipilih
    final Workshop workshop = workshopController.selectedWorkshop.value;

    // Format harga agar lebih mudah dibaca
    final currencyFormatter =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    final String formattedPrice = currencyFormatter
        .format(double.tryParse(workshop.hargaWorkshop ?? '0') ?? 0);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            toolbarHeight: 80,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: PhosphorIcon(
                PhosphorIconsBold.arrowLeft,
                color: blackColor,
                size: 32,
              ),
            ),
            title: Text(
              'Daftar Workshop',
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
              'Pilih Metode Pembayaran',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: blackColor,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Pilih metode untuk melakukan pembayaran workshop',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: greyColor,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 28),

            // Menggunakan widget builder untuk setiap pilihan pembayaran
            _buildPaymentOption(
              index: 0,
              assetPath: 'assets/gopay.png',
              price: formattedPrice,
            ),
            _buildPaymentOption(
              index: 1,
              assetPath: 'assets/dana.png',
              price: formattedPrice,
            ),
            _buildPaymentOption(
              index: 2,
              assetPath: 'assets/ovo.png',
              price: formattedPrice,
            ),
            _buildPaymentOption(
              index: 3,
              assetPath: 'assets/qris.png',
              price: formattedPrice,
            ),

            const SizedBox(height: 32),

            // Bungkus tombol dengan Obx agar state-nya reaktif
            Obx(() => ElevatedButton(
                  // Tombol akan aktif jika salah satu metode sudah dipilih
                  onPressed: registerWorkshopController.paymentMethod.value !=
                          -1
                      ? () => Get.to(() => const RegisterWorkshopConfirmation())
                      : null, // null akan membuat tombol nonaktif
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    disabledBackgroundColor:
                        Colors.grey[300], // Warna saat nonaktif
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Lanjutkan',
                    style: GoogleFonts.poppins(
                      color: whiteColor,
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                )),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Get.back(),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: primaryColor),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Kembali',
                style: GoogleFonts.poppins(
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Widget builder yang bisa digunakan kembali untuk pilihan pembayaran
  Widget _buildPaymentOption(
      {required int index, required String assetPath, required String price}) {
    // Bungkus dengan Obx agar UI otomatis update saat state di controller berubah
    return Obx(
      () => GestureDetector(
        onTap: () {
          // Cukup ubah nilai di controller, UI akan update otomatis
          registerWorkshopController.paymentMethod(index);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          height: 80,
          decoration: BoxDecoration(
            color: registerWorkshopController.paymentMethod.value == index
                ? primaryColor.withOpacity(0.1)
                : const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: registerWorkshopController.paymentMethod.value == index
                  ? primaryColor
                  : Colors.grey.shade300,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(assetPath, height: 40),
              Text(
                price,
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
