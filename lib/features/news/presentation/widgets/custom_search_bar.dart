import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/news_bloc.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkModeEnabled =
        Theme.of(context).brightness == Brightness.dark;
    final newsBloc = context.read<NewsBloc>();
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: newsBloc.searchController,
        cursorColor: isDarkModeEnabled
            ? Theme.of(context).colorScheme.onSurface
            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
              onPressed: () {
                newsBloc.searchController.clear();
                newsBloc.add(
                  GetEveryThingEvent(),
                );
              }),
        ),
        onSubmitted: (value) => newsBloc.add(
          GetEveryThingEvent(),
        ),
      ),
    );
  }
}
