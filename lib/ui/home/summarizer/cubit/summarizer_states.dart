abstract class SummarizerState {
  const SummarizerState();
}

class SummarizerInitialState extends SummarizerState {
  const SummarizerInitialState();
}

class SummarizerLoadingState extends SummarizerState {
  const SummarizerLoadingState();
}

class SummarizerErrorState extends SummarizerState {
  const SummarizerErrorState({required this.errorMessage});

  final String errorMessage;
}

class SummarizerSuccessState extends SummarizerState {
  const SummarizerSuccessState();
}
