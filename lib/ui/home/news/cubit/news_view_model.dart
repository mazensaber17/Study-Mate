import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../../repository/news_repository.dart';
import '../../../../utils/network_service.dart';
import 'news_states.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsViewModel(this.repository) : super(const NewsInitialState());

  final NewsRepository repository;

  Future<void> fetchNews({bool forceRefresh = false}) async {
    emit(const NewsLoadingState());

    if (!await NetworkService.hasInternetConnection()) {
      emit(
        const NewsErrorState(
          errorMessage: 'No internet connection',
          isNetworkError: true,
        ),
      );
      return;
    }

    final cachedNews = repository.getCachedNews();
    if (!forceRefresh && cachedNews.isNotEmpty) {
      emit(NewsSuccessState(cachedNews));
      return;
    }

    try {
      final news = await repository.getNews();
      emit(NewsSuccessState(news));
    } on DioException catch (error) {
      emit(
        NewsErrorState(
          errorMessage: error.message ?? 'Network request failed',
          isNetworkError: true,
        ),
      );
    } catch (error) {
      emit(NewsErrorState(errorMessage: error.toString()));
    }
  }
}
