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
  const NewsErrorState({required this.errorMessage});

  final String errorMessage;
}

class NewsSuccessState extends NewsState {
  const NewsSuccessState();
}
