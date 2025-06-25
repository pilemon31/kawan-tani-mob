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
            "Batalkan Suka",
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Apakah Anda yakin ingin membatalkan suka untuk artikel ini?",
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
                Get.back();
                final success =
                    await _articleController.unlikeArticle(articleId);
                if (success) {
                  showCustomToast(context, "Berhasil membatalkan suka!");
                } else {
                  showCustomToast(context, "Gagal membatalkan suka!");
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
      _articleController.likeArticle(articleId).then((success) {
        if (success) {
          showCustomToast(context, "Berhasil menyukai artikel!");
        } else {
          showCustomToast(context, "Gagal menyukai artikel!");
        }
      });
    }
  }

  void _handleBookmarkTap(bool isSaved, String articleId) {
    _articleController.saveArticle(articleId).then((success) {
      if (success) {
        showCustomToast(
            context,
            isSaved
                ? "Berhasil menghapus artikel dari simpanan!"
                : "Berhasil menyimpan artikel!");
      } else {
        showCustomToast(
            context,
            isSaved
                ? "Gagal menghapus artikel dari simpanan!"
                : "Gagal menyimpan artikel!");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final article = _articleController.selectedArticle.value;
      final isBookmarked = article.isSaved;
      final isLiked = article.isLiked;

      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: AppBar(
              backgroundColor: Colors.white,
              toolbarHeight: 80.0,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const PhosphorIcon(
                  PhosphorIconsBold.arrowLeft,
                  size: 32.0,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const ArticleComments());
                  },
                  icon: const PhosphorIcon(
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
                  onPressed: () => _handleBookmarkTap(isBookmarked, article.id),
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
                  icon: const PhosphorIcon(
                    PhosphorIconsBold.shareNetwork,
                    size: 32.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
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
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  article.title,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
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
                                : const AssetImage("assets/farmer2.jpg")
                                    as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        article.author,
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                  Text(
                    "${article.createdAt.day} ${_getMonthName(article.createdAt.month)} ${article.createdAt.year}",
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: greyColor,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                article.content,
                style: GoogleFonts.poppins(fontSize: 14),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
        bottomNavigationBar: const Navbar(),
      );
    });
  }

  String _getMonthName(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des'
    ];
    return months[month];
  }
}
