import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/workshop/workshop_controller.dart';
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
  final WorkshopController _workshopController = Get.find();

  void changeBookmark() {
    setState(() {
      isBookMarked = !isBookMarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final workshop = _workshopController.selectedWorkshop.value;
    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 80,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: PhosphorIcon(PhosphorIconsBold.arrowLeft, size: 32.0)),
            actions: [
              IconButton(
                  onPressed: () {
                    isBookMarked
                        ? showCustomToast(context, "Berhasil menghapus workshop!")
                        : showCustomToast(context, "Berhasil menambahkan workshop!");
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
                  icon: PhosphorIcon(PhosphorIconsBold.shareNetwork, size: 32.0))
            ],
          ),
        ),
      ),
      body: Obx(() {
        if (_workshopController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  workshop.gambarWorkshop.isNotEmpty
                      ? 'http://localhost:2000/uploads/workshops/${workshop.gambarWorkshop}'
                      : 'https://via.placeholder.com/150',
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workshop.judulWorkshop,
                        style: GoogleFonts.poppins(fontWeight: bold, fontSize: 20),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          PhosphorIcon(PhosphorIconsRegular.houseLine, size: 17.0),
                          SizedBox(width: 5),
                          Text(
                            workshop.facilitator?.namaFacilitator ?? 'N/A',
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 13),
                      Row(
                        children: [
                          PhosphorIcon(PhosphorIconsRegular.mapPin, size: 17.0),
                          SizedBox(width: 5),
                          Text(
                            workshop.alamatLengkapWorkshop,
                            style: GoogleFonts.poppins(fontSize: 12),
                          ),
                        ],
                      ),
                      SizedBox(height: 13),
                      Row(
                        children: [
                          PhosphorIcon(PhosphorIconsRegular.clock, size: 17.0),
                          SizedBox(width: 5),
                          Text(
                            '${workshop.waktuMulai} - ${workshop.waktuBerakhir}',
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
                      children: [
                        Text(
                          _getMonthName(DateTime.parse(workshop.tanggalWorkshop).month),
                          style: GoogleFonts.poppins(color: whiteColor, fontSize: 12),
                        ),
                        Text(
                          DateTime.parse(workshop.tanggalWorkshop).day.toString(),
                          style: GoogleFonts.poppins(color: whiteColor, fontSize: 15),
                        ),
                        Text(
                          DateTime.parse(workshop.tanggalWorkshop).year.toString(),
                          style: GoogleFonts.poppins(color: whiteColor, fontSize: 12),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Deskripsi",
                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: bold),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    workshop.deskripsiWorkshop ?? 'Tidak ada deskripsi',
                    style: GoogleFonts.poppins(fontSize: 14),
                  )
                ],
              ),
              SizedBox(height: 11),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lokasi",
                    style: GoogleFonts.poppins(fontSize: 14, fontWeight: bold),
                  ),
                  SizedBox(height: 11),
                  Container(
                    height: 238,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(
                            workshop.latLokasi ?? -8.4671, 
                            workshop.longLokasi ?? 115.6122
                          ),
                          initialZoom: 13.0,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                            subdomains: ['a', 'b', 'c'],
                          ),
                          if (workshop.latLokasi != null && workshop.longLokasi != null)
                            MarkerLayer(
                              markers: [
                                Marker(
                                  point: LatLng(workshop.latLokasi!, workshop.longLokasi!),
                                  child: Icon(Icons.location_pin, color: Colors.red, size: 40),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 19),
                  ElevatedButton(
                    onPressed: () => Get.to(() => RegisterWorkshop()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
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
                  SizedBox(height: 23)
                ],
              )
            ],
          ),
        );
      }),
    );
  }

String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'Mei';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Agu';
      case 9:
        return 'Sep';
      case 10:
        return 'Okt';
      case 11:
        return 'Nov';
      case 12:
        return 'Des';
      default:
        return 'Jan';
    }
  }
}