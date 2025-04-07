import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/articles/article_filter_controller.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import "package:get/get.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class WorkshopsFilter extends StatefulWidget {
  const WorkshopsFilter({super.key});

  @override
  State<WorkshopsFilter> createState() => _WorkshopsFilterState();
}

class _WorkshopsFilterState extends State<WorkshopsFilter> {
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
                      'Filter Workshop',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: blackColor, fontWeight: bold),
                    )),
              ))),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lokasi",
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: blackColor, fontWeight: semiBold),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Provinsi",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xffC3C6D4)),
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0)),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Kabupaten",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xffC3C6D4)),
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Kota",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xffC3C6D4)),
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0)),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Desa",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xffC3C6D4)),
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0)),
                        ),
                      ),
                    ],
                  ),
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
                    "Tanggal",
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: blackColor, fontWeight: semiBold),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "12-11-2024",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xffC3C6D4)),
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0)),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "12-11-2024",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 15.0, fontWeight: light),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide:
                                    BorderSide(color: Color(0xffC3C6D4)),
                              ),
                              fillColor: Color(0xffE7EFF2),
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15.0)),
                        ),
                      ),
                    ],
                  ),
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
