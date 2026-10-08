import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/chat_repository.dart';
import 'chat_ai_states.dart';

class ChatAiViewModel extends Cubit<ChatAiState> {
  ChatAiViewModel(this.repository) : super(const ChatAiInitialState());

  final ChatRepository repository;
}
