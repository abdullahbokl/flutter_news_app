import 'package:flutter/material.dart';
import 'package:new_app/core/shared/widgets/custom_text.dart';

import '../../domain/entities/article_entity.dart';

class NewsVerticalCard extends StatelessWidget {
  final ArticleEntity article;

  const NewsVerticalCard({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDarkModeEnabled = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 12, right: 4, bottom: 8),
      width: size.width * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(article.urlToImage),
          fit: BoxFit.cover,
          opacity: 1,
          colorFilter: isDarkModeEnabled
              ? ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                )
              : ColorFilter.mode(
                  Colors.white.withOpacity(0.5),
                  BlendMode.lighten,
                ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  child: CustomText(
                text: article.title,
                maxLines: 2,
                fontSize: 16,
                isBold: true,
              )),
              IconButton(
                padding: const EdgeInsets.all(0),
                icon: Icon(
                  article.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: article.isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          CustomText(
            text: article.description,
            maxLines: 4,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
