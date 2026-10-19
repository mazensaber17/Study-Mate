import '../../../../model/news_model.dart';

abstract class NewsState {
  const NewsState();
}

class NewsInitialState extends NewsState {
  const NewsInitialState();
}

class NewsLoadingState extends NewsState {
  const NewsLoadingState();
}

class NewsErrorState extends NewsState {
  const NewsErrorState({
    required this.errorMessage,
    this.isNetworkError = false,
  });

  final String errorMessage;
  final bool isNetworkError;
}

class NewsSuccessState extends NewsState {
  const NewsSuccessState(this.news);

  final List<NewsModel> news;
}
