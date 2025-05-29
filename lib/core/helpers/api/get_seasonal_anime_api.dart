

import 'dart:convert';

import 'package:animeworld/core/helpers/models/anime.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:animeworld/core/helpers/models/anime.dart';
import 'package:animeworld/core/helpers/models/anime_info.dart';

import '../../utils/shared/utils.dart';


Future<Iterable<Anime>> getSeasonalAnimeApi({required int limit,})async{
  final year=DateTime.now().year;
  final season= getCurrentSeason();
  final baseUrl='https://api.myanimelist.net/v2/anime/season/$year/$season?limit=$limit';

  final response=await http.get(Uri.parse(baseUrl),headers: {
    'X-MAL-CLIENT-ID':'c8cc84472c49c56626771bfdffc1554f',
  });
  if(response.statusCode==200){
    final Map<String, dynamic> data=json.decode(response.body);
final seasonalAnime=AnimeInfo.fromJson(data);

    if(kDebugMode) {
      print(response.body);
    }
    if(kDebugMode) {
      print("This is animes");
      print(seasonalAnime);
    }
    return seasonalAnime.animes;

  }else{
    debugPrint("Error:${response.statusCode}");
    debugPrint('Body: ${response.body}');
    throw Exception("Failed to get data!");
  }


}