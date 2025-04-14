import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/register_workshop.dart';
import 'package:flutter_kawan_tani/presentation/widgets/toast/custom_toast.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";
import "package:google_fonts/google_fonts.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class WorkshopDetail extends StatefulWidget {
  const WorkshopDetail({super.key});

  @override
  State<WorkshopDetail> createState() => _WorkshopDetailState();
}

class _WorkshopDetailState extends State<WorkshopDetail> {
  bool isBookMarked = false;

  void changeBookmark() {
    setState(() {
      isBookMarked = !isBookMarked;
    });
  }

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
                  onPressed: () {
                    isBookMarked
                        ? showCustomToast(
                            context, "Berhasil menghapus workshop!")
                        : showCustomToast(
                            context, "Berhasil menambahkan workshop!");
                    changeBookmark();
                  },
                  icon: PhosphorIcon(
                    isBookMarked
                        ? PhosphorIconsFill.bookmarkSimple
                        : PhosphorIconsBold.bookmarkSimple,
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
            ),
            SizedBox(
              height: 11,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Lokasi",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: bold),
                  ),
                ),
                SizedBox(
                  height: 11,
                ),
                Container(
                  width: double.infinity,
                  height: 238,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(-8.4671, 115.6122),
                        initialZoom: 13.0,
                        interactionOptions: InteractionOptions(
                          flags: InteractiveFlag.none,
                        ),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: ['a', 'b', 'c'],
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 50.0,
                              height: 50.0,
                              point: LatLng(-8.4671, 115.6122),
                              child: Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => RegisterWorkshop());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0.0,
                      shadowColor: Colors.transparent,
                      minimumSize: Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Daftar Workshop',
                      style: GoogleFonts.poppins(
                          color: whiteColor, fontSize: 16, fontWeight: bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 23,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
