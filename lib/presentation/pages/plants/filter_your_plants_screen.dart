import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/plants/filter_controller.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FilterYourPlantsScreen extends StatefulWidget {
  const FilterYourPlantsScreen({super.key});

  @override
  State<FilterYourPlantsScreen> createState() => _FilterYourPlantsScreenState();
}

class _FilterYourPlantsScreenState extends State<FilterYourPlantsScreen> {
  final FilterController controller = Get.put(FilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(100.0),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27),
                child: AppBar(
                  backgroundColor: Colors.white,
                  toolbarHeight: 80.0,
                  leading: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: PhosphorIcon(
                      PhosphorIconsBold.x,
                      size: 32.0,
                    ),
                  ),
                  title: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Filter Tanaman',
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: blackColor, fontWeight: bold),
                      )),
                ))),
        body: Column(
          children: [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 44),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Kategori Tanaman",
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: blackColor,
                          fontWeight: semiBold),
                    ),
                    const SizedBox(height: 10),
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: controller.tanamanPangan.value,
                              activeColor: Color(0xFF78D14D),
                              side: BorderSide(
                                  color: Color(0xFF78D14D), width: 2),
                              onChanged: (value) =>
                                  controller.tanamanPangan.value = value!,
                            ),
                            const SizedBox(width: 10),
                            Text("Tanaman Pangan",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          ],
                        )),
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: controller.tanamanPerkebunan.value,
                              activeColor: Color(0xFF78D14D),
                              side: BorderSide(
                                  color: Color(0xFF78D14D), width: 2),
                              onChanged: (value) =>
                                  controller.tanamanPerkebunan.value = value!,
                            ),
                            const SizedBox(width: 10),
                            Text("Tanaman Perkebunan",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          ],
                        )),
                    Obx(() => Row(
                          children: [
                            Checkbox(
                              value: controller.tanamanHortikultura.value,
                              activeColor: Color(0xFF78D14D),
                              side: BorderSide(
                                  color: Color(0xFF78D14D), width: 2),
                              onChanged: (value) =>
                                  controller.tanamanHortikultura.value = value!,
                            ),
                            const SizedBox(width: 10),
                            Text("Tanaman Hortikultura",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          ],
                        )),
                  ],
                )),
            SizedBox(
              height: 19,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: greyColor,
            )
          ],
        ),
        bottomNavigationBar: Navbar());
  }
}
