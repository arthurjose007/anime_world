import 'dart:convert';
import 'dart:io';
import 'package:animeworld/core/helpers/models/anime.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

// var testList = <Anime>[];
// Future<Iterable<Anime>> getAnimeByRankingTypeApi({
//   required String rankingType,
//   required int limit,
// }) async {
//   final ioc = HttpClient();
//   ioc.badCertificateCallback =
//       (X509Certificate cert, String host, int port) => true;
//   final http = IOClient(ioc);
//   final baseUrl =
//       'https://api.myanimelist.net/v2/anime/ranking?ranking_type=$rankingType&limit=$limit';
//
//   final response = await http.get(Uri.parse(baseUrl), headers: {
//     'X-MAL-CLIENT-ID': 'c8cc84472c49c56626771bfdffc1554f',
//   });
//   if (response.statusCode == 200) {
//     final Map<String, dynamic> data = jsonDecode(response.body);
//
//     final List<dynamic> animeNodeList = data['data'];
//     final animes = animeNodeList
//         .where((animeNode) => animeNode['node']['main_picture'] != null)
//         .map((node) => Anime.fromJson(node));
//     if (kDebugMode) {
//       print(response.body);
//       print("this is debug");
//     }
//     print(response.body);
//
//     if (kDebugMode) {
//       print(animeNodeList);
//     }
//     return animes;
//   } else {
//     debugPrint("Error:${response.statusCode}");
//     debugPrint('Body: ${response.body}');
//     throw Exception("Failed to get data!");
//   }
// }
Future<http.Response> getAnimeByRankingTypeApi({
  required String rankingType,
  required int limit,
}) async {
  final ioc = HttpClient();
  ioc.badCertificateCallback =
      (X509Certificate cert, String host, int port) => true;
  final http = IOClient(ioc);
  final baseUrl =
      'https://api.myanimelist.net/v2/anime/ranking?ranking_type=$rankingType&limit=$limit';
  try {
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'X-MAL-CLIENT-ID': 'c8cc84472c49c56626771bfdffc1554f',
    });

    return response;
  }catch(e){
    throw Exception("Failed to get data!");
  }

}
