import 'package:animeworld/models/anime_node.dart';
import 'package:animeworld/screens/animescreen/anime_details_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/anime_tile.dart';

class SimilarAnimeView extends StatelessWidget {
  const SimilarAnimeView(
      {super.key, required this.animes, required this.label});
  final List<AnimeNode> animes;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 350,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final anime = animes.elementAt(index);
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AnimeDetailsScreen(id: anime.id)));
                  },
                  child: AnimeTile(
                    anime: anime,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  width: 10,
                );
              },
              itemCount: animes!.length),
        )
      ],
    );
  }
}
