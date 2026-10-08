abstract class ChatAiState {
  const ChatAiState();
}

class ChatAiInitialState extends ChatAiState {
  const ChatAiInitialState();
}

class ChatAiLoadingState extends ChatAiState {
  const ChatAiLoadingState();
}

class ChatAiErrorState extends ChatAiState {
  const ChatAiErrorState({required this.errorMessage});

  final String errorMessage;
}

class ChatAiSuccessState extends ChatAiState {
  const ChatAiSuccessState();
}
