import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../api/api_manager.dart';
import '../../../model/news_model.dart';
import '../../../repository/news_repository.dart';
import '../../../utils/app_colors.dart';
import '../../shared/widgets/empty_state.dart';
import '../../shared/widgets/error_state.dart';
import '../../shared/widgets/full_page_no_internet.dart';
import '../../shared/widgets/loading_indicator.dart';
import 'cubit/news_states.dart';
import 'cubit/news_view_model.dart';
import 'widgets/news_header.dart';
import 'widgets/news_section.dart';
import 'widgets/subject_filter_chips.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    final content = BlocProvider(
      create: (_) => NewsViewModel(NewsRepository(ApiManager()))..fetchNews(),
      child: const _NewsContent(),
    );

    if (embedded) {
      return content;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: content,
    );
  }
}

class _NewsContent extends StatelessWidget {
  const _NewsContent();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _backgroundColor(context),
      child: SafeArea(
        child: Column(
          children: [
            const NewsHeader(),
            Expanded(
              child: BlocBuilder<NewsViewModel, NewsState>(
                builder: (context, state) {
                  if (state is NewsLoadingState) {
                    return const LoadingIndicator();
                  }
                  if (state is NewsErrorState) {
                    if (state.isNetworkError) {
                      return FullPageNoInternet(
                        onTryAgain: context.read<NewsViewModel>().fetchNews,
                      );
                    }
                    return ErrorState(
                      message: 'Unable to load news',
                      onRetry: context.read<NewsViewModel>().fetchNews,
                    );
                  }
                  if (state is NewsSuccessState) {
                    return _NewsList(
                      news: state.news,
                      onRefresh: () => context
                          .read<NewsViewModel>()
                          .fetchNews(forceRefresh: true),
                    );
                  }
                  return const EmptyState(message: 'No news available');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _backgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? AppColors.backgroundDark
        : AppColors.backgroundLight;
  }
}

class _NewsList extends StatelessWidget {
  const _NewsList({
    required this.news,
    required this.onRefresh,
  });

  final List<NewsModel> news;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
        children: [
          const NewsAudienceLabel(),
          const SizedBox(height: 10),
          const SubjectFilterChips(),
          const SizedBox(height: 22),
          NewsSection(
            title: 'Campus news',
            items: news
                .map(
                  (item) => NewsItem(
                    title: item.title,
                    metadata: _formatDate(item.publishedAt),
                    snippet: item.snippet,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Date unavailable';
    return '${date.day}/${date.month}/${date.year}';
  }
}
