import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/workshop_detail.dart';
import 'package:flutter_kawan_tani/presentation/pages/workshops/workshops_filter.dart';
import 'package:flutter_kawan_tani/presentation/controllers/workshop/workshop_controller.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";

class WorkshopsList extends StatefulWidget {
  const WorkshopsList({super.key});

  @override
  State<WorkshopsList> createState() => _WorkshopsListState();
}

class _WorkshopsListState extends State<WorkshopsList> {
  final TextEditingController _searchController = TextEditingController();
  final WorkshopController _workshopController = Get.put(WorkshopController());

  @override
  void initState() {
    super.initState();
    _workshopController.fetchActiveWorkshops();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            toolbarHeight: 80.0,
            title: Padding(
              padding: const EdgeInsets.all(0),
              child: Text(
                'Workshop Pertanian',
                style: GoogleFonts.poppins(
                    fontSize: 22, color: blackColor, fontWeight: bold),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.to(() => WorkshopsFilter());
                },
                icon: PhosphorIcon(
                  PhosphorIconsFill.dotsThreeOutlineVertical,
                  size: 32.0,
                  color: blackColor,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  // You can implement search functionality here
                },
                decoration: InputDecoration(
                  hintText: "Cari Workshop pertanian....",
                  hintStyle:
                      GoogleFonts.poppins(fontSize: 15.0, fontWeight: light),
                  prefixIcon: const PhosphorIcon(
                    PhosphorIconsRegular.magnifyingGlass,
                    size: 19.0,
                    color: Color(0xff8594AC),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xffC3C6D4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xffC3C6D4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xffC3C6D4)),
                  ),
                  fillColor: const Color(0xffE7EFF2),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 13.0),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(() {
                  if (_workshopController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_workshopController.activeWorkshops.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak ada workshop tersedia',
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  }

                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 21);
                    },
                    itemCount: _workshopController.activeWorkshops.length,
                    itemBuilder: (BuildContext context, int index) {
                      final workshop =
                          _workshopController.activeWorkshops[index];
                      return InkWell(
                        onTap: () async {
                          await _workshopController
                              .fetchWorkshopById(workshop.idWorkshop);
                          Get.to(() => const WorkshopDetail());
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffC3C6D4)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    image: NetworkImage(workshop
                                            .gambarWorkshop.isNotEmpty
                                        ? 'http://localhost:2000/uploads/workshops/${workshop.gambarWorkshop}'
                                        : 'https://via.placeholder.com/150'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          workshop.judulWorkshop,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20, fontWeight: bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const PhosphorIcon(
                                              PhosphorIconsRegular.mapPin,
                                              size: 17.0,
                                            ),
                                            const SizedBox(width: 5),
                                            Expanded(
                                              child: Text(
                                                workshop.alamatLengkapWorkshop,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 13),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const PhosphorIcon(
                                              PhosphorIconsRegular.clock,
                                              size: 17.0,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              workshop.waktuMulai +
                                                  ' - ' +
                                                  workshop.waktuBerakhir,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 8),
                                    width: MediaQuery.of(context).size.width *
                                        0.18,
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          _getMonthName(_getDateFromString(
                                                  workshop.tanggalWorkshop)
                                              .month),
                                          style: GoogleFonts.poppins(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                        Text(
                                          _getDateFromString(
                                                  workshop.tanggalWorkshop)
                                              .day
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: whiteColor, fontSize: 15),
                                        ),
                                        Text(
                                          _getDateFromString(
                                                  workshop.tanggalWorkshop)
                                              .year
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: whiteColor, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Navbar(),
    );
  }

  DateTime _getDateFromString(String dateString) {
    try {
      return DateTime.parse(dateString);
    } catch (e) {
      return DateTime.now();
    }
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
