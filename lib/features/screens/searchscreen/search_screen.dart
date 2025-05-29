import 'package:animeworld/core/helpers/api/get_anime_by_search_api.dart';
import 'package:animeworld/core/helpers/models/anime.dart';
import 'package:animeworld/core/helpers/models/anime_node.dart';
import 'package:animeworld/features/screens/animescreen/animescreen.dart';
import 'package:animeworld/core/utils/shared/component/widgets/views/ranked%20_anime_list.dart';
import 'package:animeworld/features/screens/HomeScreen/homescreen.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/config/style/paddings.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => HomeScreen(),
                      ),
                      ModalRoute.withName('/'),
                    );
                  },
                ),
                const Text(
                  "Search for animes",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showSearch(context: context, delegate: AnimeSearchDelegate());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 70,
                  color: Colors.grey[300],
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(50, 10, 20, 10),
                      child: Text('Search',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black87,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AnimeSearchDelegate extends SearchDelegate<List<AnimeNode>> {
  // Remove the animes field since we're using FutureBuilder

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, []);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    if (query.isEmpty || query.length < 3) {
      return const Center(
        child: Text("Enter at least 3 characters to search"),
      );
    }

    return FutureBuilder<Iterable<Anime>>(
      future: getAnimeBySearchApi(query: query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final animes = snapshot.data ?? [];
        if (animes.isEmpty) {
          return const Center(child: Text("No results found"));
        }

        return SearchResultsView(animes: animes);
      },
    );
  }
}

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({super.key, required this.animes});
  final Iterable<Anime> animes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Paddings.defaultPadding,
      child: ListView.builder(
        itemCount: animes.length,
        itemBuilder: (context, index) {
          final anime = animes.elementAt(index); //[index];
          return AnimeListTaile(anime: anime);
        },
      ),
    );
  }
}
