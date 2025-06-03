import 'package:flutter/material.dart';

import '../../../../../../features/screens/animescreen/anime_details_screen.dart';
import '../../../../../helpers/models/anime.dart';

class TopAnimePicture extends StatelessWidget {
  const TopAnimePicture({super.key, required this.anime});
  final Anime anime;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AnimeDetailsScreen(id:anime.node.id)));
      },
      splashColor: Colors.white,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: AspectRatio(
          aspectRatio: 10 / 9,
          child: Image.network(
            anime.node.mainPicture.medium,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
