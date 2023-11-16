import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/features/theme/presentation/theme_bloc/theme_bloc.dart';
import '../bloc/news_bloc.dart';
import '../widgets/news_page_body.dart';
import 'favourits_page.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<NewsBloc>(),
                  child: const FavouritsPage(),
                ),
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
