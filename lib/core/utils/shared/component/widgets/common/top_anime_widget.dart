import 'package:animeworld/core/helpers/api/get_anime_by_ranking_type_api.dart';
import 'package:animeworld/core/utils/shared/component/widgets/common/top_animes_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../features/screens/animescreen/rankingtype/home_controller.dart';
import '../../../../../helpers/models/anime.dart';
import '../error_screen.dart';
import '../loader.dart';

// class TopAnimesWidget extends StatelessWidget {
//   const TopAnimesWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getAnimeByRankingTypeApi(rankingType: 'all', limit: 8),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Loader();
//           }
//
//           if (snapshot.data != null) {
//             print("data");
//             final animes = snapshot.data!.toList();
//             return TopAnimeImageSlider(
//               animes: animes,
//             );
//           }
//           return ErrorScreen(error: snapshot.error.toString());
//         });
//   }
// }

class TopAnimesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Initiate the API call once
    final future =
        Provider.of<HomeProvider>(context, listen: false).rankingDetails(rankingType: 'all', limit: 4);

    return Scaffold(
      body:
      FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error occurred'));
          } else {
            // Data loaded
            return Consumer<HomeProvider>(
              builder: (context, provider, child) {
                final animeList = provider.getRankingList('all').toList();
                if (provider.getRankingList('all').isEmpty) {
                  return Center(child: Text('No data available'));
                }
                return TopAnimeImageSlider(
                  animes: animeList,
                );
              },
            );
          }
        },
      ),
    );
  }
}
