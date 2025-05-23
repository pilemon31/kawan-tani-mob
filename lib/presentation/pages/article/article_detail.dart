import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_comments.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/presentation/widgets/toast/custom_toast.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({super.key});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  bool isBookmarked = false;

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
                      PhosphorIconsBold.arrowLeft,
                      size: 32.0,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Get.to(() => ArticleComments());
                      },
                      icon: PhosphorIcon(
                        PhosphorIconsBold.chatCircle,
                        size: 32.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: whiteColor,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: PhosphorIcon(
                                            PhosphorIconsBold.x,
                                            size: 25.0,
                                            color: blackColor,
                                          ),
                                        )),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Beri Rating Artikel",
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.poppins(
                                              fontSize: 20, fontWeight: bold)),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Berikan rating Anda untuk artikel ini dan bantu kami meningkatkan kualitas konten yang disajikan.",
                                      style: GoogleFonts.poppins(fontSize: 12),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: List.generate(
                                          5,
                                          (index) => IconButton(
                                                onPressed: () {},
                                                icon: PhosphorIcon(
                                                  PhosphorIconsBold.star,
                                                  size: 30.0,
                                                  color: blackColor,
                                                ),
                                              )),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            elevation: 0.0,
                                            minimumSize:
                                                Size(double.infinity, 42)),
                                        child: Text(
                                          "Beri Rating",
                                          style: GoogleFonts.poppins(
                                              color: whiteColor,
                                              fontSize: 15,
                                              fontWeight: bold),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: PhosphorIcon(
                        PhosphorIconsBold.star,
                        size: 32.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (isBookmarked == false) {
                          showCustomToast(
                              context, "Berhasil menambah artikel!");
                          setState(() {
                            isBookmarked = true;
                          });
                        } else {
                          showCustomToast(
                              context, "Berhasil mennghapus artikel!");
                          setState(() {
                            isBookmarked = false;
                          });
                        }
                      },
                      icon: PhosphorIcon(
                        isBookmarked
                            ? PhosphorIconsFill.bookmarkSimple
                            : PhosphorIconsBold.bookmarkSimple,
                        size: 32.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: PhosphorIcon(
                        PhosphorIconsBold.shareNetwork,
                        size: 32.0,
                      ),
                    ),
                  ],
                ))),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/apple.jpg",
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Tips Hasil Panen Apel Dengan Baik",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: bold),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/farmer2.jpg"),
                              fit: BoxFit.cover),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Pak Darmono",
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: light),
                      )
                    ],
                  ),
                  Text(
                    "Feb 20, 2025",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: greyColor, fontWeight: light),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    "Panen jagung merupakan tahap akhir yang krusial dalam siklus pertanian, dan untuk menghasilkan jagung berkualitas tinggi, perhatian yang cermat pada beberapa aspek sangat penting. Salah satu hal pertama yang perlu diperhatikan adalah pemilihan waktu panen yang tepat. Jagung sebaiknya dipanen ketika bijinya sudah cukup keras dan matang, dengan ciri-ciri seperti sisik tongkol yang mengering dan biji yang berwarna kuning atau sesuai dengan varietasnya. Pemilihan waktu yang tepat akan menghindari kerugian akibat pemanenan terlalu dini atau terlambat, yang dapat mempengaruhi kualitas jagung secara signifikan.",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Setelah dipanen, langkah penting berikutnya adalah pengeringan jagung. Pengeringan harus dilakukan dengan hati-hati untuk mencegah biji jagung rusak akibat kelembaban berlebih. Jagung yang baru dipanen sebaiknya dijemur di bawah sinar matahari langsung selama 2-3 hari, namun harus dihindarkan dari hujan agar biji tetap kering dan tidak mengalami pembusukan.  Bila cuaca tidak mendukung, penggunaan alat pengering khusus untuk jagung bisa ",
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
        bottomNavigationBar: Navbar());
  }
}
