import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import "package:flutter_kawan_tani/shared/theme.dart";
import "package:phosphor_flutter/phosphor_flutter.dart";
import "package:get/get.dart";
import 'package:flutter_kawan_tani/presentation/controllers/articles/article_controller.dart';
import 'package:flutter_kawan_tani/presentation/widgets/toast/custom_toast.dart';

class ArticleComments extends StatefulWidget {
  const ArticleComments({super.key});

  @override
  State<ArticleComments> createState() => _ArticleCommentsState();
}

class _ArticleCommentsState extends State<ArticleComments> {
  final ArticleController _articleController = Get.find<ArticleController>();
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    List<String> months = [
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

    return '${date.day + 1} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
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
                  child: Obx(() {
                    final article = _articleController.selectedArticle.value;
                    final comments = article.comments;

                    if (comments.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PhosphorIcon(
                              PhosphorIconsBold.chatCircle,
                              size: 48,
                              color: greyColor,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Belum ada komentar',
                              style: GoogleFonts.poppins(
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              'Jadilah yang pertama berkomentar!',
                              style: GoogleFonts.poppins(
                                color: greyColor,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (BuildContext context, int index) {
                          final comment = comments[index];
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
                                        image: comment.authorImage.isNotEmpty
                                            ? NetworkImage(
                                                'https://kawan-tani-backend-production.up.railway.app/uploads/users/${comment.authorImage}')
                                            : AssetImage("assets/apple.jpg")
                                                as ImageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 13),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            comment.author,
                                            style: GoogleFonts.poppins(
                                                fontWeight: bold),
                                          ),
                                          Text(
                                            _formatDate(comment.createdAt),
                                            style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: greyColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        comment.content,
                                        style: GoogleFonts.poppins(),
                                      ),
                                    ],
                                  ))
                                ]),
                          );
                        });
                  }),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _commentController,
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
                child: Obx(() => ElevatedButton(
                      onPressed: _articleController.isLoading.value
                          ? null
                          : () async {
                              final content = _commentController.text.trim();
                              if (content.isEmpty) {
                                showCustomToast(
                                    context, 'Komentar tidak boleh kosong!');
                                return;
                              }

                              final article =
                                  _articleController.selectedArticle.value;
                              final success = await _articleController
                                  .addComment(article.id, content);

                              if (success) {
                                _commentController.clear();
                                showCustomToast(
                                    context, 'Komentar berhasil ditambahkan!');
                                // Refresh artikel untuk mendapatkan komentar terbaru
                                await _articleController
                                    .getArticleById(article.id);
                              }
                            },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(vertical: 12)),
                      child: _articleController.isLoading.value
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              "Tambah Komentar",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: bold,
                                  fontSize: 15),
                            ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
