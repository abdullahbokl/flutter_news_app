import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/core/shared/widgets/custom_error_widget.dart';

import '../../../../core/shared/widgets/custom_loading_indicator.dart';
import '../../../../core/utils/enums.dart';
import '../bloc/news_bloc.dart';
import 'news_horizontal_card.dart';

class EverythingNews extends StatelessWidget {
  const EverythingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsLoadedState>(
      buildWhen: (previous, current) =>
          previous.everythingRequestState != current.everythingRequestState ||
          previous.favoriteState != current.favoriteState,
      builder: (context, state) {
        if (state.everythingRequestState == RequestState.loading) {
          return const CustomLoadingIndicator();
        } else if (state.everythingRequestState == RequestState.error) {
          return CustomErrorWidget(errorMessage: state.everythingErrorMessage);
        } else {
          return ListView.separated(
            shrinkWrap: true,
            itemCount: state.everythingArticles.length,
            itemBuilder: (context, index) {
              final article = state.everythingArticles[index];
              return NewsHorizontalCard(article: article);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
          );
        }
      },
    );
  }
}
