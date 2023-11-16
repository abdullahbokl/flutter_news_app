import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/custom_error_widget.dart';
import '../../../../core/shared/widgets/custom_loading_indicator.dart';
import '../../../../core/utils/enums.dart';
import '../bloc/news_bloc.dart';
import 'news_vertical_card.dart';

class TopHeadlinesNews extends StatelessWidget {
  const TopHeadlinesNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state.topHeadlinesRequestState == RequestState.loading) {
          return const CustomLoadingIndicator();
        } else if (state.topHeadlinesRequestState == RequestState.error) {
          return CustomErrorWidget(
            errorMessage: state.topHeadlinesErrorMessage,
          );
        } else {
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: state.topHeadlinesArticles.length,
            itemBuilder: (context, index) {
              final article = state.topHeadlinesArticles[index];
              return NewsVerticalCard(article: article);
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10.0),
          );
        }
      },
    );
  }
}
