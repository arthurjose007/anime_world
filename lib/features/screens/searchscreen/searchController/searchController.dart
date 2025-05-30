import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/helpers/api/get_anime_by_search_api.dart';
import '../../../../core/helpers/models/anime.dart';
import '../../../../core/helpers/models/anime_info.dart';
import '../../../../core/utils/shared/component/widgets/custom_tost.dart';
class SearchProvider extends ChangeNotifier {
  Iterable<Anime> searchlist = [];
  String? error;
  bool isLoading = false;

  Future<void> searchapi({required String query}) async {
    if (query.isEmpty || query.length < 3) return; // Early exit

    isLoading = true;
    notifyListeners();

    try {
      final response = await getAnimeBySearchApi(query: query);

      if (response?.statusCode == 200) {
        final data = json.decode(response!.body);
        searchlist = AnimeInfo.fromJson(data).animes;
      } else {
        error = "Unexpected error occurred";
        CustomToast.showCustomToast(message: "Unexpected error occurred");
      }
    } catch (e) {
      error = "An error occurred while searching";
      if (kDebugMode) print("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}