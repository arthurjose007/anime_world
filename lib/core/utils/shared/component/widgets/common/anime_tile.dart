import 'package:animeworld/core/helpers/models/anime_node.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../config/style/text_styles.dart';

class AnimeTile extends StatelessWidget {
  const AnimeTile({super.key, required this.anime});
  final AnimeNode anime;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: anime.mainPicture.medium,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: Text(
              anime.title,
              maxLines: 3,
              style: TextStyles.mediumText,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
