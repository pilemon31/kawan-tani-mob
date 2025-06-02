import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_comments.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/presentation/widgets/toast/custom_toast.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import "package:get/get.dart";
import 'package:flutter_kawan_tani/presentation/controllers/articles/article_controller.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({super.key});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  bool isBookmarked = false;
  final ArticleController _articleController = Get.find();

  @override
  void initState() {
    super.initState();

    // Ambil article ID dari arguments dan set selected article
    final articleId = Get.arguments;
    if (articleId != null) {
      _articleController.setSelectedArticle(articleId.toString());
    }
  }

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
                              context, "Berhasil menghapus artikel!");
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
        body: Obx(() {
          if (_articleController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          final article = _articleController.selectedArticle.value;

          // Cek apakah article kosong (tidak ada data)
          if (article.id.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PhosphorIcon(
                    PhosphorIconsBold.article,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Artikel tidak ditemukan",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 27),
            child: ListView(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    article.imageUrl,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey[200],
                        ),
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    article.title,
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
                                image: NetworkImage(article.authorImage),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          article.author,
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: light),
                        )
                      ],
                    ),
                    Text(
                      "${article.createdAt.day} ${_getMonthName(article.createdAt.month)}, ${article.createdAt.year}",
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
                      article.content,
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          );
        }),
        bottomNavigationBar: Navbar());
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
