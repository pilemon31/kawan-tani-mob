import 'package:flutter_kawan_tani/services/auth/auth_service.dart';
import 'package:get/get.dart';
import 'package:flutter_kawan_tani/models/article_model.dart';
import 'package:flutter_kawan_tani/services/articles/article_service.dart';

class ArticleController extends GetxController {
  final ArticleService _articleService = ArticleService();
  final AuthService _authService = AuthService();

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
  var selectedSavedArticle = Article(
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
  var isTogglingLike = false.obs;
  var isTogglingSave = false.obs;

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
      // Sekarang ini akan mengembalikan List<Article> yang benar
      var result = await _articleService.getSavedArticles();
      savedArticles.assignAll(result);
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat artikel yang disimpan: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getArticleById(String id) async {
    try {
      isLoading(true);
      final articleData = await _articleService.getArticleById(id);
      final savedData = await _articleService.getSavedArticles();
      final user = await _authService.getCurrentUser();

      if (user != null) {
        articleData.isLiked =
            articleData.likes.any((like) => like.userId == user['id_pengguna']);
        articleData.isSaved =
            savedData.any((saved) => saved.id == articleData.id);
      }

      // Update nilai dari selectedArticle yang sudah diobservasi
      selectedArticle.value = articleData;
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat detail artikel: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> getSavedArticleById(String id) async {
    try {
      isLoading(true);
      var result = await _articleService.getArticleById(id);
      selectedSavedArticle.value = result;
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
      return await _articleService.toggleArticleStatus(id);
    } catch (e) {
      Get.snackbar('Error', 'Failed to toggle article status: $e');
      return false;
    }
  }

  Future<void> toggleSaveStatus() async {
    if (isTogglingSave.value) return;

    final articleId = selectedArticle.value.id;
    if (articleId.isEmpty) return;

    try {
      isTogglingSave(true);
      bool isCurrentlySaved = selectedArticle.value.isSaved;

      bool success = isCurrentlySaved
          ? await _articleService.unsaveArticle(articleId)
          : await _articleService.saveArticle(articleId);

      if (success) {
        // Buat objek baru untuk memastikan GetX mendeteksi perubahan
        var updatedArticle = selectedArticle.value;
        updatedArticle.isSaved = !isCurrentlySaved;
        selectedArticle.value = updatedArticle;
        selectedArticle.refresh(); // Panggil refresh untuk update UI

        _updateArticleInList(articleId, isSaved: !isCurrentlySaved);
      } else {
        Get.snackbar('Gagal', 'Gagal memperbarui status simpan artikel.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isTogglingSave(false);
    }
  }

  Future<void> toggleLikeStatus() async {
    if (isTogglingLike.value) return;

    final articleId = selectedArticle.value.id;
    if (articleId.isEmpty) return;

    try {
      isTogglingLike(true);
      bool isCurrentlyLiked = selectedArticle.value.isLiked;

      bool success = isCurrentlyLiked
          ? await _articleService.unlikeArticle(articleId)
          : await _articleService.likeArticle(articleId, 5.0);

      if (success) {
        // Buat objek baru untuk memastikan GetX mendeteksi perubahan
        var updatedArticle = selectedArticle.value;
        updatedArticle.isLiked = !isCurrentlyLiked;
        selectedArticle.value = updatedArticle;
        selectedArticle.refresh(); // Panggil refresh untuk update UI

        _updateArticleInList(articleId, isLiked: !isCurrentlyLiked);
      } else {
        Get.snackbar('Gagal', 'Gagal memperbarui status suka artikel.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isTogglingLike(false);
    }
  }

  void _updateArticleInList(String articleId, {bool? isLiked, bool? isSaved}) {
    int index = articles.indexWhere((a) => a.id == articleId);
    if (index != -1) {
      // Perlu membuat objek baru agar list reaktif
      var updatedArticle = articles[index];
      if (isLiked != null) updatedArticle.isLiked = isLiked;
      if (isSaved != null) updatedArticle.isSaved = isSaved;
      articles[index] = updatedArticle;
      articles.refresh();
    }
  }

  Future<bool> verifyArticle(String id) async {
    try {
      return await _articleService.verifyArticle(id);
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
      bool success = await _articleService.saveArticle(articleId);
      if (success) {
        var updatedArticle = selectedArticle.value;
        updatedArticle.isSaved = true;
        selectedArticle.value = updatedArticle;
        selectedArticle.refresh();

        int index = articles.indexWhere((article) => article.id == articleId);
        if (index != -1) {
          articles[index].isSaved = true;
          articles.refresh();
        }
      }
      return success;
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
      bool success = await _articleService.unsaveArticle(articleId);
      if (success) {
        var updatedArticle = selectedArticle.value;
        updatedArticle.isSaved = false;
        selectedArticle.value = updatedArticle;
        selectedArticle.refresh();

        int index = articles.indexWhere((article) => article.id == articleId);
        if (index != -1) {
          articles[index].isSaved = false;
          articles.refresh();
        }
      }
      return success;
    } catch (e) {
      Get.snackbar('Error', 'Failed to unsave article: $e');
      return false;
    } finally {
      isUpdating(false);
    }
  }

  Future<bool> likeArticle(String articleId, double rating) async {
    try {
      isUpdating(true);
      bool success = await _articleService.likeArticle(articleId, rating);
      if (success) {
        var updatedArticle = selectedArticle.value;
        updatedArticle.isLiked = true;
        selectedArticle.value = updatedArticle;
        selectedArticle.refresh();

        int index = articles.indexWhere((article) => article.id == articleId);
        if (index != -1) {
          articles[index].isLiked = true;
          articles.refresh();
        }
      }
      return success;
    } catch (e) {
      Get.snackbar('Error', 'Failed to like article: $e');
      return false;
    } finally {
      isUpdating(false);
    }
  }

  Future<bool> unlikeArticle(String articleId) async {
    try {
      final success = await _articleService.unlikeArticle(articleId);
      if (success) {
        articles.firstWhere((a) => a.id == articleId).isLiked = false;
        selectedArticle.update((article) {
          article?.isLiked = false;
        });
      }
      return success;
    } catch (e) {
      Get.snackbar('Error', 'Failed to unlike article: $e');
      return false;
    }
  }

  void setSelectedArticle(Article article) {
    getArticleById(article.id);
    selectedArticle.value = article;
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
