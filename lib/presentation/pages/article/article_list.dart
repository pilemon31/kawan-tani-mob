import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_filter.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
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
                        'Berita Pertanian',
                        style: GoogleFonts.poppins(
                            fontSize: 20, color: blackColor, fontWeight: bold),
                      )),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => FilterArticleScreen());
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
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Cari berita pertanian....",
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
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffC3C6D4)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/apple.jpg"),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Mencegah Hama yang Baik pada Tanaman Apel",
                                style: GoogleFonts.poppins(fontSize: 12),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 27,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/farmer2.jpg"),
                                            fit: BoxFit.cover),
                                        shape: BoxShape.circle),
                                  ),
                                  SizedBox(width: 4.5),
                                  Text(
                                    "Pak Darmono",
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Feb 20, 2025",
                                    style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: light,
                                        color: greyColor),
                                  ),
                                  Row(
                                    children: [
                                      PhosphorIcon(
                                        PhosphorIconsFill.star,
                                        size: 17.0,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "4.7/5",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: light,
                                            color: greyColor),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ))
            ],
          ),
        )),
        bottomNavigationBar: Navbar());
  }
}
