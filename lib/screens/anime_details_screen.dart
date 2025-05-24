import 'package:animeworld/api/get_anime_details_api.dart';
import 'package:animeworld/core/screens/error_screen.dart';
import 'package:animeworld/core/widgets/loader.dart';
import 'package:animeworld/widgets/ios_back_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AnimeDetailsScreen extends StatelessWidget {
  const AnimeDetailsScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getAnimeDetailsApi(id: id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.data != null) {
            final anime = snapshot.data;
            print(anime);
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(children: [
                  _buildAnimeImageWidget(imageUrl: anime!.mainPicture.large),
                  Text(id.toString())
                ]),
              ),
            );
          }

          return ErrorScreen(error: snapshot.error.toString());
        });
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
}
