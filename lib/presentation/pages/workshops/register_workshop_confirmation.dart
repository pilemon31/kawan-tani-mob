import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/workshop/register_workshop_controller.dart';
import 'package:flutter_kawan_tani/presentation/controllers/workshop/workshop_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/dashboard/home_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/workshops_list.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RegisterWorkshopConfirmation extends StatefulWidget {
  const RegisterWorkshopConfirmation({super.key});

  @override
  State<RegisterWorkshopConfirmation> createState() =>
      _RegisterWorkshopConfirmationState();
}

class _RegisterWorkshopConfirmationState
    extends State<RegisterWorkshopConfirmation> {
  final controller = Get.put(RegisterWorkshopController());
  final WorkshopController _workshopController = Get.find();

  @override
  Widget build(BuildContext context) {
    final workshop = _workshopController.selectedWorkshop.value;
    Future<void> _handlePayment() async {
      try {
        await controller.registerForWorkshop(
          workshopId: workshop.idWorkshop,
          firstName: controller.firstName.value,
          lastName: controller.lastName.value,
          email: controller.emailAddress.value,
          phoneNumber: controller.phoneNumber.value,
          gender: controller.gender.value,
          paymentMethod: controller.paymentMethod.value,
        );

        controller.resetForm();

        Get.offAll(() => const HomeScreen());
      } catch (e) {
        // Error handling sudah ada di controller
      }
    }

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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: ListView(
          children: [
            Text(
              'Konfirmasi Pendaftaran',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Konfirmasi pendaftaran untuk workshop ini',
              style: greyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              'Informasi Peserta:',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text('Nama Depan',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium)),
                    ),
                    Text(': ${controller.firstName.value}',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium)),
                  ],
                )),
            const SizedBox(height: 12),
            Obx(() => Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text('Nama Belakang',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium)),
                    ),
                    Text(': ${controller.lastName.value}',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium)),
                  ],
                )),
            const SizedBox(height: 12),
            Obx(() => Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text('Email',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium)),
                    ),
                    Text(': ${controller.emailAddress.value}',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium)),
                  ],
                )),
            const SizedBox(height: 12),
            Obx(() => Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text('Nomor Telepon',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium)),
                    ),
                    Text(': ${controller.phoneNumber.value}',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium)),
                  ],
                )),
            const SizedBox(height: 12),

            Obx(() => Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text('Jenis Kelamin',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium)),
                    ),
                    Text(
                        ': ${controller.gender.value == 0 ? "Laki-laki" : "Perempuan"}',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium)),
                  ],
                )),
            const SizedBox(height: 32),
            Text(
              'Informasi Pembayaran:',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 16),
            Obx(() => Row(
                  children: [
                    SizedBox(
                      width: 130,
                      child: Text('Metode',
                          style: blackTextStyle.copyWith(
                              fontSize: 14, fontWeight: medium)),
                    ),
                    Text(': ${controller.paymentMethodText}',
                        style: blackTextStyle.copyWith(
                            fontSize: 14, fontWeight: medium)),
                  ],
                )),
            const SizedBox(height: 12),
            // Obx(() => Row(
            //       children: [
            //         SizedBox(
            //           width: 130,
            //           child: Text('Jumlah',
            //               style: blackTextStyle.copyWith(
            //                   fontSize: 14, fontWeight: medium)),
            //         ),
            //         Text(': ${paymentController.jumlah.value}',
            //             style: blackTextStyle.copyWith(
            //                 fontSize: 14, fontWeight: medium)),
            //       ],
            //     )),
            // const SizedBox(height: 12),
            // Obx(() => Row(
            //       children: [
            //         SizedBox(
            //           width: 130,
            //           child: Text('Status',
            //               style: blackTextStyle.copyWith(
            //                   fontSize: 14, fontWeight: medium)),
            //         ),
            //         Text(': ${paymentController.status.value}',
            //             style: blackTextStyle.copyWith(
            //                 fontSize: 14, fontWeight: medium)),
            //       ],
            //     )),
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: _handlePayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Pembayaran',
                style: whiteTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
            ),
            const SizedBox(height: 18),
            OutlinedButton(
              onPressed: () {
                Get.to(() => WorkshopsList());
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                side: BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Keluar',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
