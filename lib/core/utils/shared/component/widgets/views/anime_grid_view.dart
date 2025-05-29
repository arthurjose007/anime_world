import 'package:animeworld/core/helpers/api/get_anime_by_ranking_type_api.dart';
import 'package:animeworld/core/helpers/models/anime_category.dart';
import 'package:animeworld/core/utils/shared/component/widgets/views/animes_grid_list.dart';
import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:provider/provider.dart';
import '../../../../../../features/screens/animescreen/rankingtype/home_controller.dart';
import '../error_screen.dart';
import '../loader.dart';

// class AnimeGridView extends StatelessWidget {
//   const AnimeGridView({super.key, required this.category});
//   final AnimeCategory category;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getAnimeByRankingTypeApi(
//             rankingType: category.rankingType, limit: 100),
//         builder: (context, snapshort) {
//           if (snapshort.connectionState == ConnectionState.waiting) {
//             return const Loader();
//           }
//           if (snapshort.data != null) {
//             final animes = snapshort.data;
//             return AnimeGrindList(
//               title: category.title,
//               animes: animes!,
//             );
//           }
//           return ErrorScreen(error: snapshort.error.toString());
//         });
//   }
// }
class AnimeGridView extends StatelessWidget {
  const AnimeGridView({super.key, required this.category});
  final AnimeCategory category;

  @override
  Widget build(BuildContext context) {
    // Trigger data fetch when widget builds
    final provider = Provider.of<HomeProvider>(context, listen: false);
    // Call fetch only once, or you can do this in initState if it's Stateful
    provider.rankingDetails(rankingType: category.rankingType,limit: 500);

    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading(category.rankingType)) {
          return const Loader();
        }
        if (provider.getError(category.rankingType) != null) {
          return ErrorScreen(error: provider.getError(category.rankingType)!);
        }
        if (provider.getRankingList(category.rankingType).isNotEmpty) {
          final animes = provider.getRankingList(category.rankingType);
          return AnimeGrindList(
            title: category.title,
            animes: animes!,
          );
        }
        return const SizedBox(); // or some fallback
      },
    );
  }
}

