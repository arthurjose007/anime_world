// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
//
// import '../../../../core/helpers/api/get_anime_by_search_api.dart';
// import '../../../../core/helpers/api/get_anime_details_api.dart';
// import '../../../../core/helpers/models/anime.dart';
// import '../../../../core/helpers/models/anime_details.dart';
// import '../../../../core/helpers/models/anime_info.dart';
// import '../../../../core/utils/shared/component/widgets/custom_tost.dart';
// class DetailedProvider extends ChangeNotifier {
//   Iterable<AnimeDetails> detailedlist = [];
//   String? error;
//   bool isLoading = false;
//
//   Future<void> getAnimeDetailsApidata({required int id}) async {
//
//     isLoading = true;
//     notifyListeners();
//
//     try {
//       final response = await getAnimeDetailsApi(id: id);
//
//       if (response?.statusCode == 200) {
//         // final data = json.decode(response!.body);
//           final Map<String, dynamic> data = jsonDecode(response.body);
//
//          final anime = AnimeDetails.fromJson(data);
//          print(anime);
//       } else {
//         error = "Unexpected error occurred";
//         CustomToast.showCustomToast(message: "Unexpected error occurred");
//       }
//     } catch (e) {
//       error = "An error occurred while searching";
//       if (kDebugMode) print("Error: $e");
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/helpers/api/get_anime_details_api.dart';
import '../../../../core/helpers/models/anime_details.dart';
import '../../../../core/utils/shared/component/widgets/custom_tost.dart';

class DetailedProvider with ChangeNotifier {
  AnimeDetails? _animeDetails;
  String? _error;
  bool _isLoading = false;

  AnimeDetails? get animeDetails => _animeDetails;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> getAnimeDetailsApidata({required int id}) async {
    if (_isLoading) return;

    _isLoading = true;
    _error = null;
    // Don't notify here to prevent build phase issues
    // notifyListeners();

    try {
      final response = await getAnimeDetailsApi(id: id);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _animeDetails = AnimeDetails.fromJson(data);
        if (kDebugMode) {
             print("Successfully fetched anime details:");
             print(_animeDetails);
         }
      } else {
        _error = "Failed to load (Status: ${response.statusCode})";
        CustomToast.showCustomToast(
             message: "Failed to load anime details. Please try again later."
        );

      }
    } catch (e) {
      _error = "Network error occurred";
      CustomToast.showCustomToast(message: "Failed to parse anime details");
      if (kDebugMode) print("Parsing error: $e");
    } finally {
      _isLoading = false;
      // Safe to notify after async operations complete
      notifyListeners();
    }
  }
}