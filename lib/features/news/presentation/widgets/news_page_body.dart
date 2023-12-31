import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/features/news/presentation/bloc/news_bloc.dart';

import 'everything_news.dart';
import 'top_headlines_news.dart';

class NewsPageBody extends StatelessWidget {
  const NewsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (context.watch<NewsBloc>().searchController.text.isEmpty) ...[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: const TopHeadlinesNews(),
            ),
            const SizedBox(height: 10.0),
          ],
          const Expanded(child: EverythingNews()),
        ],
      ),
    );
  }
}
