import 'dart:convert';

import 'package:animeworld/models/anime.dart';
import 'package:animeworld/models/anime_details.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:animeworld/models/anime.dart';
import 'package:animeworld/models/anime_info.dart';

Future<AnimeDetails> getAnimeDetailsApi({
  required int id,
}) async {
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/$id?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics';

  final response = await http.get(Uri.parse(baseUrl), headers: {
    'X-MAL-CLIENT-ID': 'c8cc84472c49c56626771bfdffc1554f',
  });
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final animeDetails = AnimeDetails.fromJson(data);
    if (kDebugMode) {
      print(response.body);
    }
    if (kDebugMode) {
      print("This is animeDetails");
      print(animeDetails);
    }
    return animeDetails;
  } else {
    debugPrint("Error:${response.statusCode}");
    debugPrint('Body: ${response.body}');
    throw Exception("Failed to get data!");
  }
}
