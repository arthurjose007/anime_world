

import 'dart:convert';

import 'package:animeworld/models/anime.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;
import 'package:animeworld/models/anime.dart';
import 'package:animeworld/models/anime_info.dart';


Future<Iterable<Anime>> getAnimeBySearchApi({required String query,})async{
  final baseUrl='https://api.myanimelist.net/v2/anime?q=$query&limit=10';

  final response=await http.get(Uri.parse(baseUrl),headers: {
    'X-MAL-CLIENT-ID':'c8cc84472c49c56626771bfdffc1554f',
  });
  if(response.statusCode==200){
    final Map<String, dynamic> data=json.decode(response.body);
AnimeInfo animeInfo=AnimeInfo.fromJson(data);
Iterable<Anime> animes=animeInfo.animes;

    if(kDebugMode) {
      print(response.body);
    }
    if(kDebugMode) {
      print("This is animes");
      print(animes);
    }
    return animes;

  }else{
    debugPrint("Error:${response.statusCode}");
    debugPrint('Body: ${response.body}');
    throw Exception("Failed to get data!");
  }


}