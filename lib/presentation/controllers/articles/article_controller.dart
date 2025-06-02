import 'package:get/get.dart';
import 'package:flutter_kawan_tani/models/article_model.dart';
import 'package:flutter_kawan_tani/services/articles/article_service.dart';

class ArticleController extends GetxController {
  final ArticleService _articleService = ArticleService();

  var articles = <Article>[].obs;
  var isLoading = true.obs;
  var selectedArticle = Article(
    id: '',
    title: '',
    content: '',
    author: '',
    authorImage: '',
    imageUrl: '',
    createdAt: DateTime.now(),
    rating: 0.0,
  ).obs;

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading(true);
      var result = await _articleService.getArticles();
      articles.assignAll(result);
      print('Articles loaded: ${articles.length}'); // Debug
    } catch (e) {
      print('Error loading articles: $e');
      // Anda bisa menampilkan error toast atau dialog di sini
    } finally {
      isLoading(false);
    }
  }

  // Method baru untuk set selected article berdasarkan ID
  void setSelectedArticle(String articleId) {
    try {
      final article = articles.firstWhere((article) => article.id == articleId);
      selectedArticle.value = article;
      print('Selected article: ${article.title}'); // Debug
    } catch (e) {
      print('Article not found: $articleId');
    }
  }

  // Method alternatif untuk set selected article langsung
  void setSelectedArticleDirectly(Article article) {
    selectedArticle.value = article;
  }
}
