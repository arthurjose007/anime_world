import 'package:animeworld/core/helpers/api/get_anime_by_ranking_type_api.dart';
import 'package:animeworld/features/screens/animescreen/anime_details_screen.dart';
import 'package:animeworld/features/screens/view_all_anime_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../features/screens/animescreen/rankingtype/home_controller.dart';
import '../common/anime_tile.dart';
import '../error_screen.dart';
import '../loader.dart';


// class FeaturedAnimes extends StatelessWidget {
//   const FeaturedAnimes(
//       {super.key, required this.rankingType, required this.label});
//   final String rankingType;
//   final String label;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return FutureBuilder(
//         future: getAnimeByRankingTypeApi(rankingType: rankingType, limit: 10),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Loader();
//           }
//           if (snapshot.data != null) {
//             final animes = snapshot.data;
//             return Column(
//               children: [
//                 SizedBox(
//                   height: 50,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Text(
//                         label,
//                         style: const TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       TextButton(
//                           onPressed: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (_) => ViewAllAnimeScreen(
//                                     rankingType: rankingType, label: label)));
//                           },
//                           child: Text("View All")),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 350,
//                   child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         final anime = animes.elementAt(index);
//                         return InkWell(
//                           onTap: () {
//                             Navigator.of(context).push(MaterialPageRoute(
//                                 builder: (_) =>
//                                     AnimeDetailsScreen(id: anime.node.id)));
//                           },
//                           child: AnimeTile(
//                             anime: anime.node,
//                           ),
//                         );
//                       },
//                       separatorBuilder: (context, index) {
//                         return const SizedBox(
//                           width: 10,
//                         );
//                       },
//                       itemCount: animes!.length),
//                 )
//               ],
//             );
//           }
//           return ErrorScreen(error: snapshot.error.toString());
//         });
//   }
// }
class FeaturedAnimes extends StatelessWidget {
  const FeaturedAnimes({
    super.key,
    required this.rankingType,
    required this.label
  });

  final String rankingType;
  final String label;

  @override
  Widget build(BuildContext context) {
    //final provider = Provider.of<HomeProvider>(context, listen: false);

    // // Initialize data if not already loaded

    final provider = Provider.of<HomeProvider>(context, listen: false);

    // Schedule the data loading after the build completes
    Future.microtask(() {
      if (provider.getRankingList(rankingType).isEmpty &&
          !provider.isLoading(rankingType)) {
        provider.rankingDetails(limit: 100, rankingType: rankingType);
      }
    });

    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading(rankingType)) {
          return const Loader();
        }

        if (provider.getError(rankingType) != null) {
          return Center(child: Text(provider.getError(rankingType)!));
        }

        final animes = provider.getRankingList(rankingType);

        if (animes.isEmpty) {
          return const Center(child: Text("There is no data to show"));
        }

        return Column(
          children: [
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => ViewAllAnimeScreen(
                                rankingType: rankingType,
                                label: label
                            )
                        ));
                      },
                      child: const Text("View All")
                  ),
                ],
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
                            builder: (_) => AnimeDetailsScreen(id: anime.node.id)
                        ));
                      },
                      child: AnimeTile(anime: anime.node),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 10);
                  },
                  itemCount: animes.length
              ),
            )
          ],
        );
      },
    );
  }
}