import 'package:animeworld/api/get_anime_by_ranking_type_api.dart';
import 'package:animeworld/core/screens/error_screen.dart';
import 'package:animeworld/core/widgets/loader.dart';
import 'package:animeworld/models/anime_category.dart';
import 'package:animeworld/views/animes_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:http/retry.dart';

class AnimeGridView extends StatelessWidget {
  const AnimeGridView({super.key, required this.category});
  final AnimeCategory category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAnimeByRankingTypeApi(
            rankingType: category.rankingType, limit: 100),
        builder: (context, snapshort) {
          if (snapshort.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshort.data != null) {
            final animes = snapshort.data;
            return AnimeGrindList(
              title: category.title,
              animes: animes!,
            );
          }
          return ErrorScreen(error: snapshort.error.toString());
        });
  }
}
