import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/widgets/custom_text.dart';
import '../../domain/entities/article_entity.dart';
import '../bloc/news_bloc.dart';

class NewsHorizontalCard extends StatelessWidget {
  final ArticleEntity article;

  const NewsHorizontalCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.2,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    width: size.width * 0.25,
                    height: constraints.maxHeight * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(article.urlToImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListTile(
                contentPadding: const EdgeInsets.only(right: 0),
                title: CustomText(
                  text: article.title,
                  maxLines: 2,
                  fontSize: 16,
                ),
                subtitle: CustomText(
                  text: article.description,
                  maxLines: 3,
                  fontSize: 12,
                ),
              ),
            ),
            IconButton(
              padding: const EdgeInsets.all(0),
              icon: Icon(
                article.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: article.isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: () => context
                  .read<NewsBloc>()
                  .add(ChangeFavoriteStateEvent(article.url)),
            ),
          ],
        ),
      ),
    );
  }
}
