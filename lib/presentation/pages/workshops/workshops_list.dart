import 'package:flutter/material.dart';
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
                      'Workshop',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: blackColor, fontWeight: bold),
                    )),
                actions: [
                  IconButton(
                    onPressed: () {},
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
              child: Column(children: [
                TextFormField(
                  controller: _searchController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "Cari Workshop pertanian....",
                    hintStyle:
                        GoogleFonts.poppins(fontSize: 15.0, fontWeight: light),
                    prefixIcon: PhosphorIcon(
                      PhosphorIconsRegular.magnifyingGlass,
                      size: 19.0,
                      color: Color(0xff8594AC),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Color(0xffC3C6D4)),
                    ),
                    fillColor: Color(0xffE7EFF2),
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 13.0),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                    child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 21);
                  },
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
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
                              height: 160,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/seminar1_image.webp"),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Teknik Genjot Padi",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20, fontWeight: bold),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            style: GoogleFonts.poppins(
                                                fontSize: 12),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                            style: GoogleFonts.poppins(
                                                fontSize: 12),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  width:
                                      MediaQuery.of(context).size.width * 0.18,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ))
              ]))),
      bottomNavigationBar: Navbar(),
    );
  }
}
