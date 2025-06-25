import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_comments.dart';
import 'package:flutter_kawan_tani/presentation/controllers/articles/article_controller.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/presentation/widgets/toast/custom_toast.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:get/get.dart';

class ArticleDetail extends StatefulWidget {
  const ArticleDetail({super.key});

  @override
  State<ArticleDetail> createState() => _ArticleDetailState();
}

class _ArticleDetailState extends State<ArticleDetail> {
  final ArticleController _articleController = Get.find<ArticleController>();
  double selectedRating = 0;

  @override
  void initState() {
    super.initState();
    if (_articleController.selectedArticle.value.id.isEmpty) {
      final articleId = Get.parameters['id'];
      if (articleId != null) {
        _articleController.getArticleById(articleId);
      }
    }
  }

  void _handleStarTap(bool isLiked, String articleId) {
    if (isLiked) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Batalkan Rating",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Apakah Anda yakin ingin membatalkan rating untuk artikel ini?",
            style: GoogleFonts.poppins(),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                "Batal",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () async {
                Get.back(); // Tutup dialog
                final success =
                    await _articleController.unlikeArticle(articleId);
                if (success) {
                  showCustomToast(context, "Rating berhasil dibatalkan!");
                } else {
                  showCustomToast(context, "Gagal membatalkan rating!");
                }
              },
              child: Text(
                "Ya, Batalkan",
                style: GoogleFonts.poppins(color: Colors.red),
              ),
            ),
          ],
        ),
      );
    } else {
      // Reset rating sebelum menampilkan dialog
      selectedRating = 0;

      // Jika belum liked, tampilkan dialog rating
      showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
          builder: (context, setDialogState) => Dialog(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text("Beri Rating Artikel",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: bold)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Berikan rating Anda untuk artikel ini dan bantu kami meningkatkan kualitas konten yang disajikan.",
                      style: GoogleFonts.poppins(fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => IconButton(
                          onPressed: () {
                            setDialogState(() {
                              selectedRating = (index + 1).toDouble();
                            });
                          },
                          icon: PhosphorIcon(
                            index < selectedRating
                                ? PhosphorIconsFill.star
                                : PhosphorIconsBold.star,
                            size: 30.0,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        if (selectedRating > 0) {
                          final success = await _articleController.likeArticle(
                              articleId, selectedRating);
                          if (success) {
                            showCustomToast(
                                context, "Rating berhasil diberikan!");
                            Get.back();
                          } else {
                            showCustomToast(
                                context, "Gagal memberikan rating!");
                          }
                        } else {
                          showCustomToast(
                              context, "Pilih rating terlebih dahulu!");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0.0,
                        minimumSize: Size(double.infinity, 42),
                      ),
                      child: Text(
                        "Beri Rating",
                        style: GoogleFonts.poppins(
                            color: whiteColor, fontSize: 15, fontWeight: bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final article = _articleController.selectedArticle.value;
      final isBookmarked = article.isSaved;
      final isLiked = article.isLiked;

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
                  onPressed: () => _handleStarTap(isLiked, article.id),
                  icon: PhosphorIcon(
                    isLiked ? PhosphorIconsFill.star : PhosphorIconsBold.star,
                    size: 32.0,
                    color: isLiked ? Colors.yellow : blackColor,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (isBookmarked) {
                      final success =
                          await _articleController.unsaveArticle(article.id);
                      if (success) {
                        showCustomToast(context, "Berhasil menghapus artikel!");
                      }
                    } else {
                      final success =
                          await _articleController.saveArticle(article.id);
                      if (success) {
                        showCustomToast(context, "Berhasil menambah artikel!");
                      }
                    }
                  },
                  icon: PhosphorIcon(
                    isBookmarked
                        ? PhosphorIconsFill.bookmarkSimple
                        : PhosphorIconsBold.bookmarkSimple,
                    size: 32.0,
                    color: isBookmarked ? primaryColor : blackColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement share functionality
                  },
                  icon: PhosphorIcon(
                    PhosphorIconsBold.shareNetwork,
                    size: 32.0,
                  ),
                ),
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
                child: Image.network(
                  article.imageUrl.isNotEmpty
                      ? 'https://kawan-tani-backend-production.up.railway.app/uploads/articles/${article.imageUrl}'
                      : 'https://via.placeholder.com/150',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/placeholder.jpg",
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 18),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  article.title,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: bold),
                ),
              ),
              SizedBox(height: 24),
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
                            image: article.authorImage.isNotEmpty
                                ? NetworkImage(
                                    'https://kawan-tani-backend-production.up.railway.app/uploads/users/${article.authorImage}')
                                : AssetImage("assets/farmer2.jpg")
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        article.author,
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: light),
                      )
                    ],
                  ),
                  Text(
                    "${article.createdAt.day} ${_getMonthName(article.createdAt.month)} ${article.createdAt.year}",
                    style: GoogleFonts.poppins(
                        fontSize: 14, color: greyColor, fontWeight: light),
                  )
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    article.content,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
        bottomNavigationBar: Navbar(),
      );
    });
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
        return '';
    }
  }
}