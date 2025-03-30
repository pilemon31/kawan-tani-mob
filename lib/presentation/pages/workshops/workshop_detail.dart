import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";

class WorkshopDetail extends StatefulWidget {
  const WorkshopDetail({super.key});

  @override
  State<WorkshopDetail> createState() => _WorkshopDetailState();
}

class _WorkshopDetailState extends State<WorkshopDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: PhosphorIcon(
                  PhosphorIconsBold.arrowLeft,
                  size: 32.0,
                )),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: PhosphorIcon(
                    PhosphorIconsBold.bookmarkSimple,
                    size: 32.0,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: PhosphorIcon(
                    PhosphorIconsBold.shareNetwork,
                    size: 32.0,
                  ))
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 27),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                "assets/seminar1_image.webp",
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Teknik Genjot Padi",
                      style:
                          GoogleFonts.poppins(fontWeight: bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular.houseLine,
                          size: 17.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Lumbung Desa Mojokerto",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular.mapPin,
                          size: 17.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Mojokerto, Jawa Timur",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        PhosphorIcon(
                          PhosphorIconsRegular.clock,
                          size: 17.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "07.00 - 15.00 WIB",
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: primaryColor),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Feb",
                        style: GoogleFonts.poppins(
                            color: whiteColor, fontSize: 12),
                      ),
                      Text(
                        "10",
                        style: GoogleFonts.poppins(
                            color: whiteColor, fontSize: 15),
                      ),
                      Text(
                        "2025",
                        style: GoogleFonts.poppins(
                            color: whiteColor, fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Deskripsi",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: bold),
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  "Workshop \"Teknik Tanam Padi\" adalah sebuah acara yang dirancang untuk memberikan pelatihan dan pengetahuan kepada para petani atau praktisi pertanian tentang teknik-teknik terbaru dalam meningkatkan hasil produksi padi. Dalam workshop ini, peserta akan mempelajari berbagai metode inovatif untuk meningkatkan efisiensi dan produktivitas lahan pertanian padi, termasuk teknik pengelolaan air yang tepat, pemilihan varietas padi unggul, penggunaan pupuk yang efektif, serta pengendalian hama dan penyakit secara ramah lingkungan.",
                  style: GoogleFonts.poppins(fontSize: 14),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
