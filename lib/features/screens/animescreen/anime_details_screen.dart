
import 'package:animeworld/core/helpers/api/get_anime_details_api.dart';
import 'package:animeworld/core/utils/config/style/paddings.dart';
import 'package:animeworld/core/utils/shared/component/widgets/common/readmore_text.dart';
import 'package:animeworld/core/helpers/models/anime_details.dart';
import 'package:animeworld/core/helpers/models/picture.dart';
import 'package:animeworld/core/utils/shared/component/widgets/views/similar_anime_view.dart';
import 'package:animeworld/core/utils/shared/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/English&japname/anime_title_language.dart';
import '../../../core/utils/shared/component/widgets/common/info_text.dart';
import '../../../core/utils/shared/component/widgets/common/ios_back_button.dart';
import '../../../core/utils/shared/component/widgets/common/networkimageview.dart';
import '../../../core/utils/shared/component/widgets/error_screen.dart';
import '../../../core/utils/shared/component/widgets/loader.dart';

// class AnimeDetailsScreen extends StatelessWidget {
//   const AnimeDetailsScreen({super.key, required this.id});
//
//   final int id;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: getAnimeDetailsApi(id: id),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Loader();
//           }
//           if (snapshot.data != null) {
//             final anime = snapshot.data;
//             print(anime);
//             return Scaffold(
//               body: SingleChildScrollView(
//                 child: Column(children: [
//                   //Top Image
//                   _buildAnimeImageWidget(imageUrl: anime!.mainPicture.large),
//                   Padding(
//                     padding: Paddings.defaultPadding,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         _buildAnimeTitle(
//                             name: anime.title,
//                             englishName: anime.alternativeTitles.en),
//                         SizedBox(
//                           height: 20,
//                         ),
//                         //Description
//                         ReadMoreText(longText: anime.synopsis),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         //Anime Info
//                         _buildAnimeInfo(anime: anime),
//                         //Anime Background
//                         anime.background.isNotEmpty
//                             ? _buildAnimeBackground(
//                                 background: anime.background)
//                             : const SizedBox.shrink(),
//                         //Image Gallery
//                         _buildImageGallery(image: anime.pictures),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         SimilarAnimeView(
//                             animes: anime.relatedAnime
//                                 .map((relatedanime) => relatedanime.node)
//                                 .toList(),
//                             label: "Releated Anime"),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         SimilarAnimeView(
//                             animes: anime.recommendations
//                                 .map((animerec) => animerec.node)
//                                 .toList(),
//                             label: "Recommendations"),
//                       ],
//                     ),
//                   ),
//                 ]),
//               ),
//             );
//           }
//
//           return ErrorScreen(error: snapshot.error.toString());
//         });
//   }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detailedController/detailedresponseController.dart';

class AnimeDetailsScreen extends StatelessWidget {
  const AnimeDetailsScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    if(id!=null) {
      final provider = Provider.of<DetailedProvider>(context, listen: false).getAnimeDetailsApidata(id:id);
    }
    return Scaffold(
      body: Consumer<DetailedProvider>(
        builder: (context, provider, child) {
          // Handle loading state
          if (provider.isLoading) {
            return const Loader();
          }

          // Handle error state
          if (provider.error != null) {
            return ErrorScreen(error: provider.error!);
          }

          // Handle no data state
          if (provider.animeDetails == null) {
            return const ErrorScreen(error: 'No anime details available');
          }

          final anime = provider.animeDetails!;

          return SingleChildScrollView(
            child: Column(children: [
              _buildAnimeImageWidget(imageUrl: anime.mainPicture.large),
              Padding(
                padding: Paddings.defaultPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAnimeTitle(
                        name: anime.title,
                        englishName: anime.alternativeTitles.en),
                    const SizedBox(height: 20),
                    ReadMoreText(longText: anime.synopsis),
                    const SizedBox(height: 10),
                    _buildAnimeInfo(anime: anime),
                    anime.background.isNotEmpty
                        ? _buildAnimeBackground(background: anime.background)
                        : const SizedBox.shrink(),
                    _buildImageGallery(image: anime.pictures),
                    const SizedBox(height: 20),
                    SimilarAnimeView(
                        animes: anime.relatedAnime
                            .map((relatedanime) => relatedanime.node)
                            .toList(),
                        label: "Related Anime"),
                    const SizedBox(height: 20),
                    SimilarAnimeView(
                        animes: anime.recommendations
                            .map((animerec) => animerec.node)
                            .toList(),
                        label: "Recommendations"),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }


  _buildAnimeImageWidget({required String imageUrl}) => Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            height: 400,
            width: double.infinity,
          ),
          Positioned(
              top: 30,
              left: 20,
              child: Builder(
                builder: (context) {
                  return IosBackButton(
                    onPressed: Navigator.of(context).pop,
                  );
                },
              ))
        ],
      );
  Widget _buildAnimeTitle({
    required String name,
    required String englishName,
  }) =>

  Consumer<AnimeTitleLanguageProvider>(

  builder: (context,english ,child){
         return Text(
             english.isEnglish ? englishName :
             name,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ));
      });
  Widget _buildAnimeInfo({required AnimeDetails anime}) {
    String studios = anime.studios.map((studio) => studio.name).join(',');
    String genres = anime.genres.map((genre) => genre.name).join(',');
    String otherName =
        anime.alternativeTitles.synonyms.map((title) => title).join(',');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoText(label: 'Genres:', info: genres),
        InfoText(label: 'Start date:', info: anime.startDate),
        InfoText(label: 'End date:', info: anime.endDate),
        InfoText(label: 'Episodes:', info: anime.numEpisodes.toString()),
        InfoText(
            label: 'Average Episode Duration:',
            info: anime.averageEpisodeDuration.toMinute()),
        InfoText(label: 'Status:', info: anime.status),
        InfoText(label: 'Rating:', info: anime.rating),
        InfoText(label: 'Studios:', info: studios),
        InfoText(label: 'Other Names:', info: otherName),
        InfoText(label: 'Other Names:', info: otherName),
        InfoText(label: 'English Names:', info: anime.alternativeTitles.en),
        InfoText(label: 'japanies Name:', info: anime.alternativeTitles.ja),
      ],
    );
  }

  Widget _buildAnimeBackground({
    required String background,
  }) {
    return WhieContainer(
      child: Text(
        background,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black),
      ),
    );
  }

  Widget _buildImageGallery({
    required List<Picture> image,
  }) {
    return Column(
      children: [
        const Text(
          "Image Gallery",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        GridView.builder(
            shrinkWrap: true,
            itemCount: image.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 9 / 16,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              final images = image[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => NetworkImageView(
                              imageUrl: images.large,
                            )));
                  },
                  child: Image.network(
                    images.medium,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            })
      ],
    );
  }
}
