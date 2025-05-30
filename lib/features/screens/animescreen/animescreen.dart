import 'package:animeworld/core/utils/config/style/paddings.dart';
import 'package:animeworld/core/utils/shared/component/widgets/common/top_anime_widget.dart';
import 'package:animeworld/features/screens/searchscreen/search_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/helpers/api/get_seasonal_anime_api.dart';
import '../../../core/utils/shared/component/widgets/views/featured_anime.dart';

class AnimeScreen extends StatelessWidget {
  const AnimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Anime World'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchScreen()));
              },
              icon: Icon(Icons.search))
        ],
      ),
      body:  SingleChildScrollView(
          child: Column(
        children: [
          //featcured Animes(4)
          SizedBox(
            height: 320,
            child: TopAnimesWidget(),
          ),
          //Top Animes
          Padding(
            padding: Paddings.noBottomPadding,
            child: Column(
              children: [
                FeaturedAnimes(
                  label: 'Top Ranked',
                  rankingType: 'all',
                ),
              ],
            ),
          ),
          //Top movie
          Padding(
            padding: Paddings.noBottomPadding,
            child: Column(
              children: [
                FeaturedAnimes(
                  label: 'Top Movie',
                  rankingType: 'movie',
                ),
              ],
            ),
          ),
          // //Top Popularity
          Padding(
            padding: Paddings.noBottomPadding,
            child: Column(
              children: [
                FeaturedAnimes(
                  label: 'By Popularity',
                  rankingType: 'bypopularity',
                ),
              ],
            ),
          ),
          // Upcoming
          Padding(
            padding: Paddings.noBottomPadding,
            child: Column(
              children: [
                FeaturedAnimes(
                  label: 'Upcoming',
                  rankingType: 'upcoming',
                ),
              ],
            ),
          ),
          //Top Animes
          Padding(
            padding: Paddings.noBottomPadding,
            child: Column(
              children: [
                FeaturedAnimes(
                  label: 'Favorite',
                  rankingType: 'favorite',
                ),
             ],
            ),
         ),
        ],
      )),
    );
  }
}
