// import 'dart:convert';
//
// import 'package:animeworld/core/helpers/models/anime.dart';
// import 'package:animeworld/core/helpers/models/anime_details.dart';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:animeworld/core/helpers/models/anime.dart';
// import 'package:animeworld/core/helpers/models/anime_info.dart';
// //AnimeDetails
// Future<http.Response> getAnimeDetailsApi({
//   required int id,
// }) async {
//   final baseUrl =
//       'https://api.myanimelist.net/v2/anime/$id?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics';
// try{
//   final response = await http.get(Uri.parse(baseUrl), headers: {
//     'X-MAL-CLIENT-ID': 'c8cc84472c49c56626771bfdffc1554f',
//   });
//   // if (response.statusCode == 200) {
//   //   final Map<String, dynamic> data = jsonDecode(response.body);
//   //   final animeDetails = AnimeDetails.fromJson(data);
//   //   if (kDebugMode) {
//   //     print(response.body);
//   //   }
//   //   if (kDebugMode) {
//   //     print("This is animeDetails");
//   //     print(animeDetails);
//   //   }
//   //   return animeDetails;
//   return response;
// } catch (e) {
// throw Exception("Failed to get data!");
// }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future<http.Response> getAnimeDetailsApi({required int id}) async {
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/$id?fields=id,title,main_picture,alternative_titles,start_date,end_date,synopsis,mean,rank,popularity,num_list_users,num_scoring_users,nsfw,created_at,updated_at,media_type,status,genres,my_list_status,num_episodes,start_season,broadcast,source,average_episode_duration,rating,pictures,background,related_anime,related_manga,recommendations,studios,statistics';

  try {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'X-MAL-CLIENT-ID': 'c8cc84472c49c56626771bfdffc1554f',
      },
    );

    if (kDebugMode) {
      print("API Response Status: ${response.statusCode}");
      print("API Response Body: ${response.body}");
    }
    print(response.body);

    return response;
  } catch (e) {
    if (kDebugMode) print("API Call Error: $e");
    rethrow;
  }
}