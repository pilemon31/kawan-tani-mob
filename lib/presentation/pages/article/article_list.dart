import 'package:flutter/material.dart';
import 'package:flutter_kawan_tani/presentation/controllers/articles/article_controller.dart';
import 'package:flutter_kawan_tani/presentation/pages/article/article_detail.dart';
import 'package:flutter_kawan_tani/presentation/widgets/navbar/navbar.dart';
import 'package:flutter_kawan_tani/shared/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final TextEditingController _searchController = TextEditingController();
  final ArticleController _articleController = Get.put(ArticleController());

  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _articleController.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 27),
          child: AppBar(
            backgroundColor: whiteColor,
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
                'Artikel Pertanian',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: blackColor,
                  fontWeight: bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                keyboardType: TextInputType.name,
                onChanged: (value) {
                  // Update search query and rebuild UI
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: "Cari artikel pertanian....",
                  hintStyle: GoogleFonts.poppins(
                      fontSize: 15.0, fontWeight: FontWeight.w300),
                  prefixIcon: const PhosphorIcon(
                    PhosphorIconsRegular.magnifyingGlass,
                    size: 19.0,
                    color: Color(0xff8594AC),
                  ),
                  // Add clear button when searching
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                          icon: const PhosphorIcon(
                            PhosphorIconsRegular.x,
                            size: 16,
                            color: Color(0xff8594AC),
                          ),
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xffC3C6D4)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xffC3C6D4)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xffC3C6D4)),
                  ),
                  fillColor: const Color(0xffE7EFF2),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 13.0),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(() {
                  if (_articleController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_articleController.articles.isEmpty) {
                    return Center(
                      child: Text(
                        'Tidak ada artikel tersedia',
                        style: GoogleFonts.poppins(),
                      ),
                    );
                  }

                  // Filter articles based on search query
                  final filteredArticles =
                      _articleController.articles.where((article) {
                    if (_searchQuery.isEmpty) return true;

                    return article.title.toLowerCase().contains(_searchQuery) ||
                        article.author.toLowerCase().contains(_searchQuery);
                  }).toList();

                  // Show message if no results found
                  if (filteredArticles.isEmpty && _searchQuery.isNotEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PhosphorIcon(
                            PhosphorIconsRegular.magnifyingGlass,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Tidak ada artikel ditemukan',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Coba kata kunci lain',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    itemCount: filteredArticles.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final article = filteredArticles[index];
                      return InkWell(
                        onTap: () {
                          _articleController.setSelectedArticle(article);
                          Get.to(() => const ArticleDetail());
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffC3C6D4)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(article
                                            .imageUrl.isNotEmpty
                                        ? 'https://kawan-tani-backend-production.up.railway.app/uploads/articles/${article.imageUrl}'
                                        : 'https://via.placeholder.com/150'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      article.title,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Oleh',
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
                                        ),
                                        const SizedBox(width: 4.5),
                                        Text(
                                          article.author,
                                          style:
                                              GoogleFonts.poppins(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${article.createdAt.day} ${_getMonthName(article.createdAt.month)} ${article.createdAt.year}",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                            color: greyColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
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
