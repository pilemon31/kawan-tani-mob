import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/register_workshop_confirmation.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RegisterWorkshopPayment extends StatefulWidget {
  const RegisterWorkshopPayment({super.key});

  @override
  State<RegisterWorkshopPayment> createState() =>
      _RegisterWorkshopPaymentState();
}

class _RegisterWorkshopPaymentState extends State<RegisterWorkshopPayment> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
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

            // GoPay
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? primaryColor
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        selectedIndex == 0 ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/gopay.png', width: 120, height: 120),
                      Text(
                        'Rp. 100.000,00',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: bold,
                          color: selectedIndex == 0 ? Colors.white : blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Dana
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? primaryColor
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        selectedIndex == 1 ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/dana.png', width: 120, height: 120),
                      Text(
                        'Rp. 100.000,00',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: bold,
                          color: selectedIndex == 0 ? Colors.white : blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // OVO
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 2),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                decoration: BoxDecoration(
                  color: selectedIndex == 2
                      ? primaryColor
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        selectedIndex == 2 ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/ovo.png', width: 120, height: 120),
                      Text(
                        'Rp. 100.000,00',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: bold,
                          color: selectedIndex == 0 ? Colors.white : blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // QRIS
            GestureDetector(
              onTap: () => setState(() => selectedIndex = 3),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 80,
                decoration: BoxDecoration(
                  color: selectedIndex == 3
                      ? primaryColor
                      : const Color(0xFFF2F2F2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        selectedIndex == 3 ? primaryColor : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/qris.png', width: 120, height: 120),
                      Text(
                        'Rp. 100.000,00',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: bold,
                          color: selectedIndex == 0 ? Colors.white : blackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: selectedIndex != -1
                  ? () => Get.to(() => const RegisterWorkshopConfirmation())
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
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
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: whiteColor,
                side: BorderSide(color: primaryColor),
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Keluar',
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
}
