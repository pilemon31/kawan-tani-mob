import 'package:get/get.dart';
import 'package:flutter_kawan_tani/models/article_model.dart';
import 'package:flutter_kawan_tani/services/articles/article_service.dart';

class ArticleController extends GetxController {
  final ArticleService _articleService = ArticleService();

  var articles = <Article>[].obs;
  var userArticles = <Article>[].obs;
  var savedArticles = <Article>[].obs;
  var selectedArticle = Article(
    id: '',
    title: '',
    description: '',
    content: '',
    imageUrl: '',
    category: '',
    author: '',
    authorImage: '',
    createdAt: DateTime.now(),
    isActive: true,
    status: '',
    isVerified: '',
  ).obs;
  var isLoading = false.obs;
  var isCreating = false.obs;
  var isUpdating = false.obs;
  var isDeleting = false.obs;

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
    } catch (e) {
      Get.snackbar('Error', 'Failed to load articles: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAllArticles() async {
    try {
      isLoading(true);
      var result = await _articleService.getAllArticles();
      articles.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load all articles: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserArticles() async {
    try {
      isLoading(true);
      var result = await _articleService.getUserArticles();
      userArticles.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load user articles: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchSavedArticles() async {
    try {
      isLoading(true);
      var result = await _articleService.getSavedArticles();
      savedArticles.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load saved articles: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getArticleById(String id) async {
    try {
      isLoading(true);
      var result = await _articleService.getArticleById(id);
      selectedArticle.value = result;
    } catch (e) {
      Get.snackbar('Error', 'Failed to load article: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<bool> createArticle({
    required String title,
    required String description,
    required String content,
    required String imagePath,
    required String category,
    required String status,
  }) async {
    try {
      isCreating(true);
      await _articleService.createArticle(
        title: title,
        description: description,
        content: content,
        imagePath: imagePath,
        category: category,
        status: status,
      );
      await fetchUserArticles();
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to create article: $e');
      return false;
    } finally {
      isCreating(false);
    }
  }

  Future<bool> updateArticle({
    required String id,
    required String title,
    required String description,
    required String content,
    String? imagePath,
    required String status,
  }) async {
    try {
      isUpdating(true);
      await _articleService.updateArticle(
        id: id,
        title: title,
        description: description,
        content: content,
        imagePath: imagePath,
        status: status,
      );
      await fetchUserArticles();
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to update article: $e');
      return false;
    } finally {
      isUpdating(false);
    }
  }

  Future<bool> deleteArticle(String id) async {
    try {
      isDeleting(true);
      final success = await _articleService.deleteArticle(id);
      if (success) {
        userArticles.removeWhere((article) => article.id == id);
      }
      return success;
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete article: $e');
      return false;
    } finally {
      isDeleting(false);
    }
  }

  Future<bool> toggleArticleStatus(String id) async {
    try {
      final success = await _articleService.toggleArticleStatus(id);
      if (success) {
        await getArticleById(id);
      }
      return success;
    } catch (e) {
      Get.snackbar('Error', 'Failed to toggle article status: $e');
      return false;
    }
  }

  Future<bool> verifyArticle(String id) async {
    try {
      final success = await _articleService.verifyArticle(id);
      if (success) {
        await getArticleById(id);
      }
      return success;
    } catch (e) {
      Get.snackbar('Error', 'Failed to verify article: $e');
      return false;
    }
  }

  Future<bool> addComment(String articleId, String content) async {
    try {
      final comment = await _articleService.addComment(articleId, content);
      selectedArticle.update((article) {
        article?.comments.add(comment);
      });
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to add comment: $e');
      return false;
    }
  }

  Future<bool> saveArticle(String articleId) async {
    try {
      isUpdating(true);
      final updatedArticle = await _articleService.saveArticle(articleId);
      selectedArticle.value = updatedArticle;
      await fetchSavedArticles(); // Update saved articles list
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to save article: $e');
      return false;
    } finally {
      isUpdating(false);
    }
  }

  Future<bool> unsaveArticle(String articleId) async {
    try {
      isUpdating(true);
      final updatedArticle = await _articleService.unsaveArticle(articleId);
      selectedArticle.value = updatedArticle;
      await fetchSavedArticles(); // Update saved articles list
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to unsave article: $e');
      return false;
    } finally {
      isUpdating(false);
    }
  }

  Future<bool> likeArticle(String articleId) async {
    try {
      isUpdating(true);
      final updatedArticle = await _articleService.likeArticle(articleId);
      selectedArticle.value = updatedArticle;
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to like article: $e');
      return false;
    } finally {
      isUpdating(false);
    }
  }

  Future<bool> unlikeArticle(String articleId) async {
    try {
      isUpdating(true);
      final updatedArticle = await _articleService.unlikeArticle(articleId);
      selectedArticle.value = updatedArticle;
      return true;
    } catch (e) {
      Get.snackbar('Error', 'Failed to unlike article: $e');
      return false;
    } finally {
      isUpdating(false);
    }
  }

  void setSelectedArticle(Article article) {
    selectedArticle.value = article;
    getArticleById(article.id); // Fetch latest data
  }

  void searchArticles(String query) {
    if (query.isEmpty) {
      fetchArticles();
      return;
    }

    var filteredArticles = articles.where((article) {
      return article.title.toLowerCase().contains(query.toLowerCase()) ||
          article.author.toLowerCase().contains(query.toLowerCase()) ||
          article.category.toLowerCase().contains(query.toLowerCase());
    }).toList();

    articles.assignAll(filteredArticles);
  }

  void resetSearch() {
    fetchArticles();
  }
}
