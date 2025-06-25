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

  void _handleStarTap() {
    _articleController.toggleLikeStatus().then((_) {
      final isLiked = _articleController.selectedArticle.value.isLiked;
      showCustomToast(
          context, isLiked ? "Artikel disukai!" : "Suka dibatalkan!");
    });
  }

  void _handleBookmarkTap() {
    _articleController.toggleSaveStatus().then((_) {
      final isSaved = _articleController.selectedArticle.value.isSaved;
      showCustomToast(context,
          isSaved ? "Artikel disimpan!" : "Artikel dihapus dari simpanan!");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Obx(() {
            final isBookmarked =
                _articleController.selectedArticle.value.isSaved;
            final isLiked = _articleController.selectedArticle.value.isLiked;

            return AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              toolbarHeight: 80.0,
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: PhosphorIcon(PhosphorIconsBold.arrowLeft,
                    size: 32.0, color: blackColor),
              ),
              actions: [
                IconButton(
                  onPressed: () => Get.to(() => ArticleComments()),
                  icon: PhosphorIcon(PhosphorIconsBold.chatCircle,
                      size: 32.0, color: blackColor),
                ),
                Obx(() => IconButton(
                      onPressed: _articleController.isTogglingLike.value
                          ? null
                          : _handleStarTap,
                      icon: _articleController.isTogglingLike.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : PhosphorIcon(
                              isLiked
                                  ? PhosphorIconsFill.star
                                  : PhosphorIconsBold.star,
                              size: 32.0,
                              color: isLiked
                                  ? const Color(0xFFFFC107)
                                  : blackColor,
                            ),
                    )),
                Obx(() => IconButton(
                      onPressed: _articleController.isTogglingSave.value
                          ? null
                          : _handleBookmarkTap,
                      icon: _articleController.isTogglingSave.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2))
                          : PhosphorIcon(
                              isBookmarked
                                  ? PhosphorIconsFill.bookmarkSimple
                                  : PhosphorIconsBold.bookmarkSimple,
                              size: 32.0,
                              color: isBookmarked ? primaryColor : blackColor,
                            ),
                    )),
                IconButton(
                  onPressed: () {/* TODO: Implement share */},
                  icon: PhosphorIcon(PhosphorIconsBold.shareNetwork,
                      size: 32.0, color: blackColor),
                ),
              ],
            );
          }),
        ),
      ),
      body: Obx(() {
        if (_articleController.isLoading.value &&
            _articleController.selectedArticle.value.id.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final article = _articleController.selectedArticle.value;

        if (article.id.isEmpty) {
          return const Center(child: Text("Artikel tidak ditemukan."));
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: ListView(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  article.imageUrl.isNotEmpty
                      ? 'https://kawan-tani-backend-production.up.railway.app/uploads/articles/${article.imageUrl}'
                      : 'https://via.placeholder.com/400x200.png?text=No+Image',
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
              Text(
                article.title,
                style: GoogleFonts.poppins(
                    fontSize: 24, fontWeight: bold, color: blackColor),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: article.authorImage.isNotEmpty
                            ? NetworkImage(
                                'https://kawan-tani-backend-production.up.railway.app/uploads/users/${article.authorImage}')
                            : const AssetImage("assets/farmer2.jpg")
                                as ImageProvider,
                      ),
                      const SizedBox(width: 10),
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
              const SizedBox(height: 20),
              Text(
                article.content,
                style: GoogleFonts.poppins(
                    fontSize: 14, height: 1.8, color: blackColor),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      }),
      bottomNavigationBar: const Navbar(),
    );
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
