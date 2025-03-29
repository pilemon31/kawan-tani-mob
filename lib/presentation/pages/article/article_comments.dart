import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import "package:flutter_kawan_tani/shared/theme.dart";
import "package:phosphor_flutter/phosphor_flutter.dart";
import "package:get/get.dart";

class ArticleComments extends StatefulWidget {
  const ArticleComments({super.key});

  @override
  State<ArticleComments> createState() => _ArticleCommentsState();
}

class _ArticleCommentsState extends State<ArticleComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0), // Reduced from 100 to 80
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
                    PhosphorIconsBold.arrowLeft,
                    size: 32.0,
                  ),
                ),
                title: Padding(
                    padding: EdgeInsets.all(0),
                    child: Text(
                      'Komentar',
                      style: GoogleFonts.poppins(
                          fontSize: 20, color: blackColor, fontWeight: bold),
                    )),
              ))),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: Column(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: greyColor)),
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/apple.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: 13),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Bu Susi Marsinah",
                                      style:
                                          GoogleFonts.poppins(fontWeight: bold),
                                    ),
                                    Text(
                                      "Terima kasih artikelnya, Pak Darmono! Saya ingin bertanya, Pak. Cabai yang saya tanam sudah melewati masa panen, tetapi masih terlihat hijau. Apakah itu normal, Pak?",
                                      style: GoogleFonts.poppins(),
                                    ),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                          splashFactory: NoSplash.splashFactory,
                                          padding: EdgeInsets.zero,
                                        ),
                                        onPressed: () {},
                                        child: Text(
                                          "Balas",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.poppins(
                                              color: primaryColor),
                                        ))
                                  ],
                                ))
                              ]),
                        );
                      }),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    maxLines: 5,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: "Tulis Komentar.........",
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 15.0, fontWeight: light),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                        fillColor: Color(0xffE7EFF2),
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 15.0)),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.symmetric(vertical: 12)),
                  child: Text(
                    "Tambah Komentar",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: bold, fontSize: 15),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
