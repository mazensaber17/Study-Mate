import '../api/api_manager.dart';
import '../api/end_points.dart';
import '../model/news_model.dart';
import '../utils/local_storage.dart';

class NewsRepository {
  NewsRepository(this.apiManager);

  final ApiManager apiManager;

  List<NewsModel> getCachedNews() {
    return AppLocalStorage.cachedNews;
  }

  Future<List<NewsModel>> getNews() async {
    final response = await apiManager.getData(endPoint: EndPoints.general);
    final statusCode = response.statusCode ?? 500;
    if (statusCode < 200 || statusCode >= 300) {
      throw Exception('News request failed with status $statusCode');
    }

    final body = response.data;
    if (body is! Map<String, dynamic> || body['items'] is! List) {
      throw const FormatException('Invalid news response format');
    }

    final news = (body['items'] as List)
        .whereType<Map>()
        .map((item) => NewsModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
    await AppLocalStorage.saveNews(news);
    return news;
  }
}
