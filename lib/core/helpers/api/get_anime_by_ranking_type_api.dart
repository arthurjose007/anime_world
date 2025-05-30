import 'dart:convert';
import 'dart:io';
import 'package:animeworld/core/helpers/models/anime.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';


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
