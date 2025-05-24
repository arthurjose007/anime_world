import 'package:animeworld/api/get_anime_by_ranking_type_api.dart';
import 'package:animeworld/core/screens/error_screen.dart';
import 'package:animeworld/core/widgets/loader.dart';
import 'package:animeworld/views/ranked%20_anime_list.dart';
import 'package:flutter/material.dart';

class ViewAllAnimeScreen extends StatelessWidget {
  const ViewAllAnimeScreen({
    super.key,
    required this.rankingType,
    required this.label,
  });
  final String rankingType;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: FutureBuilder(
          future:
              getAnimeByRankingTypeApi(rankingType: rankingType, limit: 500),
          builder: (context, snapshort) {
            if (snapshort.connectionState == ConnectionState.waiting) {
              return const Loader();
            }
            if (snapshort.data != null) {
              return RankingAnimeListView(
                animes: snapshort.data!,
              );
            }
            return ErrorScreen(error: "Error Occuren");
          }),
    );
  }
}
