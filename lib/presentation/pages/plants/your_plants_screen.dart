import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/plants/filter_your_plants_screen.dart';
import 'package:flutter_kawan_tani/presentation/pages/plants/your_plants_detail_screen.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class YourPlantsScreen extends StatefulWidget {
  const YourPlantsScreen({super.key});

  @override
  State<YourPlantsScreen> createState() => _YourPlantsScreenState();
}

class _YourPlantsScreenState extends State<YourPlantsScreen> {
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
                    onPressed: () {},
                    icon: PhosphorIcon(
                      PhosphorIconsBold.arrowLeft,
                      size: 32.0,
                    ),
                  ),
                  title: Padding(
                      padding: EdgeInsets.all(0),
                      child: Text(
                        'Mulai Bertanam',
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: blackColor, fontWeight: bold),
                      )),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => FilterYourPlantsScreen());
                      },
                      icon: PhosphorIcon(
                        PhosphorIconsFill.dotsThreeOutlineVertical,
                        size: 32.0,
                      ),
                    ),
                  ],
                ))),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 27),
                child: Expanded(
                    child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 21);
                  },
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => YourPlantsDetailScreen());
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xffC3C6D4)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage("assets/apple.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(height: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cabaiku Tani (60%)",
                                  style: GoogleFonts.poppins(
                                      fontSize: 20, fontWeight: bold),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    PhosphorIcon(
                                      PhosphorIconsRegular.clock,
                                      size: 17.0,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "32 Hari hingga panen",
                                      style: GoogleFonts.poppins(fontSize: 12),
                                    )
                                  ],
                                ),
                                SizedBox(height: 4),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => const YourPlantsDetailScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF78D14D),
                                    minimumSize: Size(double.infinity, 30),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  child: Text(
                                    "Selesaikan Tugas Harian",
                                    style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: semiBold,
                                        color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )))),
        bottomNavigationBar: Navbar());
  }
}
