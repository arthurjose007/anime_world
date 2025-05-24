import 'package:animeworld/common/styles/paddings.dart';
import 'package:animeworld/widgets/top_anime_widget.dart';
import 'package:flutter/material.dart';

import '../../views/featured_anime.dart';

class AnimeScreen extends StatefulWidget {
  const AnimeScreen({super.key});

  @override
  State<AnimeScreen> createState() => _AnimeScreenState();
}

class _AnimeScreenState extends State<AnimeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime World'),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: const SingleChildScrollView(
          child: Column(
        children: [
          //featcured Animes(4)
          SizedBox(
            height: 300,
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
          //Top Popularity
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
