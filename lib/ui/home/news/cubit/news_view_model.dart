import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/news_repository.dart';
import 'news_states.dart';

class NewsViewModel extends Cubit<NewsState> {
  NewsViewModel(this.repository) : super(const NewsInitialState());

  final NewsRepository repository;
}
