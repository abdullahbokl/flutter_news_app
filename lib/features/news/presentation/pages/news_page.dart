import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/features/theme/presentation/theme_bloc/theme_bloc.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/news_page_body.dart';
import 'favourits_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        title: const CustomSearchBar(),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const FavouritsPage(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.brightness_4),
            onPressed: () => context.read<ThemeBloc>().add(ChangeTheme()),
          ),
        ],
      ),
      body: const NewsPageBody(),
    );
  }
}
