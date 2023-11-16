import 'package:flutter/material.dart';

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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: const TopHeadlinesNews(),
          ),
          const SizedBox(height: 10.0),
          const Expanded(child: EverythingNews()),
        ],
      ),
    );
  }
}
