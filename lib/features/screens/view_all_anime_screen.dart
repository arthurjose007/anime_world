import 'package:animeworld/core/helpers/api/get_anime_by_ranking_type_api.dart';
import 'package:animeworld/core/utils/shared/component/widgets/views/ranked%20_anime_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utils/shared/component/widgets/error_screen.dart';
import '../../core/utils/shared/component/widgets/loader.dart';
import 'animescreen/rankingtype/home_controller.dart';

// class ViewAllAnimeScreen extends StatelessWidget {
//   const ViewAllAnimeScreen({
//     super.key,
//     required this.rankingType,
//     required this.label,
//   });
//   final String rankingType;
//   final String label;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(label),
//       ),
//       body: FutureBuilder(
//           future:
//               getAnimeByRankingTypeApi(rankingType: rankingType, limit: 500),
//           builder: (context, snapshort) {
//             if (snapshort.connectionState == ConnectionState.waiting) {
//               return const Loader();
//             }
//             if (snapshort.data != null) {
//               return RankingAnimeListView(
//                 animes: snapshort.data!,
//               );
//             }
//             return ErrorScreen(error: "Error Occuren");
//           }),
//     );
//   }
// }
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
    final future =
    Provider.of<HomeProvider>(context, listen: false).rankingDetails(rankingType: rankingType,limit: 500);

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: FutureBuilder(
          future:future,

          builder: (context, snapshort) {
            if (snapshort.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (snapshort.hasError) {
              return Center(child: Text('Error occurred'));
            } else {
              return Consumer<HomeProvider>(
                  builder:(context,provider,child){
                    // if(provider.testList.isEmpty){
                    //   return Center(child: Text('No data available'));
                    //
                    // }
                    return  RankingAnimeListView(
                      animes: provider.getRankingList(rankingType)!,
                    );
                  }
              );
            }

          }),
    );
  }
}