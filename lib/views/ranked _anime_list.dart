import 'package:animeworld/common/styles/paddings.dart';
import 'package:animeworld/models/anime.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RankingAnimeListView extends StatelessWidget {
  const RankingAnimeListView({super.key, required this.animes});

  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.defaultPadding,
      child: ListView.builder(itemBuilder: (context, index) {
        final anime = animes.elementAt(index);
        return AnimeListTaile(anime: anime,rank: anime.node.id,);
      }),
    );
  }
}

class AnimeListTaile extends StatelessWidget {
  const AnimeListTaile({super.key, required this.anime, this.rank});
  final Anime anime;
  final int? rank;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //image
                SizedBox(
                  height: 100,
                  width: 150,
                  child: CachedNetworkImage(
                    imageUrl: anime.node.mainPicture.medium,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                //Anime Info
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    rank != null
                        ? AnimeRankBadge(
                            rank: rank!,
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      anime.node.title,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimeRankBadge extends StatelessWidget {
  const AnimeRankBadge({super.key, required this.rank});
  final int rank;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(12),
      color: Colors.amberAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: Text(
          'Rank $rank',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
