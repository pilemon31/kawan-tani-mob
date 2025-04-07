import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/articles/article_filter_controller.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FilterArticleScreen extends StatefulWidget {
  const FilterArticleScreen({super.key});

  @override
  State<FilterArticleScreen> createState() => _FilterArticleScreenState();
}

class _FilterArticleScreenState extends State<FilterArticleScreen> {
  final ArticleFilterController controller = Get.put(ArticleFilterController());

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
                    "Rating Artikel",
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: blackColor, fontWeight: semiBold),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            5,
                            (index) => Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Checkbox(
                                      value: controller.rating.value >=
                                          (index + 1),
                                      activeColor: Color(0xFF78D14D),
                                      side: BorderSide(
                                          color: Color(0xFF78D14D), width: 2),
                                      onChanged: (value) =>
                                          controller.changeRating(index + 1),
                                    ),
                                    Text(
                                      "${index + 1}",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    )
                                  ],
                                )),
                      )),
                  const SizedBox(height: 10),
                ],
              )),
          SizedBox(
            height: 19,
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: greyColor,
          ),
          SizedBox(
            height: 19,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kategori Artikel",
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: blackColor, fontWeight: semiBold),
                  ),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: controller.teknikPertanian.value,
                            activeColor: Color(0xFF78D14D),
                            side:
                                BorderSide(color: Color(0xFF78D14D), width: 2),
                            onChanged: (value) =>
                                controller.teknikPertanian.value = value!,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Teknik Pertanian dan Produksi",
                              style: GoogleFonts.poppins(fontSize: 16),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: controller.pengendalianHama.value,
                            activeColor: Color(0xFF78D14D),
                            side:
                                BorderSide(color: Color(0xFF78D14D), width: 2),
                            onChanged: (value) =>
                                controller.pengendalianHama.value = value!,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text("Pengendalian Hama dan Penyakit",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          )
                        ],
                      )),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: controller.peningkatanKualitas.value,
                            activeColor: Color(0xFF78D14D),
                            side:
                                BorderSide(color: Color(0xFF78D14D), width: 2),
                            onChanged: (value) =>
                                controller.peningkatanKualitas.value = value!,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                                "Peningkatan kualitas dan Kuantitas Hasil Pertanian",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          )
                        ],
                      )),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: controller.teknologiPertanian.value,
                            activeColor: Color(0xFF78D14D),
                            side:
                                BorderSide(color: Color(0xFF78D14D), width: 2),
                            onChanged: (value) =>
                                controller.teknologiPertanian.value = value!,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text("Teknologi Pertanian",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          )
                        ],
                      )),
                  const SizedBox(height: 10),
                  Obx(() => Row(
                        children: [
                          Checkbox(
                            value: controller.manajemenBisnis.value,
                            activeColor: Color(0xFF78D14D),
                            side:
                                BorderSide(color: Color(0xFF78D14D), width: 2),
                            onChanged: (value) =>
                                controller.manajemenBisnis.value = value!,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text("Manajemen dan Bisnis Pertanian",
                                style: GoogleFonts.poppins(fontSize: 16)),
                          )
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
    );
  }
}
