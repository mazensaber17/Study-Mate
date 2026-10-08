import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repository/summarizer_repository.dart';
import 'summarizer_states.dart';

class SummarizerViewModel extends Cubit<SummarizerState> {
  SummarizerViewModel(this.repository) : super(const SummarizerInitialState());

  final SummarizerRepository repository;
}
