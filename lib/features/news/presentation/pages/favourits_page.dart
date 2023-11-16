import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/custom_error_widget.dart';
import '../../../../core/shared/widgets/custom_loading_indicator.dart';
import '../../../../core/utils/enums.dart';
import '../bloc/news_bloc.dart';
import '../widgets/news_horizontal_card.dart';

class FavouritsPage extends StatelessWidget {
  const FavouritsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourits'),
      ),
      body: BlocBuilder<NewsBloc, NewsLoadedState>(
        builder: (context, state) {
          if (state.everythingRequestState == RequestState.loading) {
            return const CustomLoadingIndicator();
          } else if (state.everythingRequestState == RequestState.error) {
            return CustomErrorWidget(
                errorMessage: state.everythingErrorMessage);
          } else {
            var articles = state.everythingArticles
                .where((element) => element.isFavorite)
                .toList();
            articles.addAll(state.topHeadlinesArticles
                .where((element) => element.isFavorite)
                .toList());
            if (articles.isEmpty) {
              return const Center(
                child: Text('No Favourits'),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return NewsHorizontalCard(article: article);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10.0);
              },
            );
          }
        },
      ),
    );
  }
}
