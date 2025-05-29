
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/helpers/api/get_anime_by_ranking_type_api.dart';
import '../../../../core/helpers/models/anime.dart';
import '../../../../core/utils/shared/component/widgets/custom_tost.dart';
// class HomeProvider extends ChangeNotifier {
//
//   Iterable<Anime> testList = [];
//   String? error=null;
// bool isLoading=false;
//   Future<void> employeeDetails({required int limit,required String rankingType}) async {
//     isLoading=true;
//     notifyListeners();
//     try {
//       final response = await getAnimeByRankingTypeApi(rankingType: rankingType, limit: limit);
//
//       if (response != null && response.statusCode == 200) {
//         final Map<String, dynamic> data = jsonDecode(response.body);
//
//           final List<dynamic> animeNodeList = data['data'];
//         testList = animeNodeList
//               .where((animeNode) => animeNode['node']['main_picture'] != null)
//               .map((node) => Anime.fromJson(node));
//         //notifyListeners();
//           if (kDebugMode) {
//             print(response.body);
//             print("this is debug");
//           }
//           print(response.body);
//
//           if (kDebugMode) {
//             print(animeNodeList);
//           }
//         isLoading=false;
//           notifyListeners();
//           // return animes;
//       } else {
//         error="Unexpected error occurred";
//         CustomToast.showCustomToast(message: "Unexpected error occurred");
//         isLoading=false;
//        // notifyListeners();
//       }
//     } catch (e) {
//       if (kDebugMode) {
//         print("Error: $e");
//       }
//       CustomToast.showCustomToast(
//           message: "An error occurred while checking payment status");
//       isLoading=false;
//       //notifyListeners();
//     }
//   }}


class HomeProvider extends ChangeNotifier {
  final Map<String, Iterable<Anime>> _rankingLists = {};
  final Map<String, String?> _errors = {};
  final Map<String, bool> _loadingStates = {};

  Iterable<Anime> getRankingList(String rankingType) => _rankingLists[rankingType] ?? [];
  String? getError(String rankingType) => _errors[rankingType];
  bool isLoading(String rankingType) => _loadingStates[rankingType] ?? false;

  Future<void> rankingDetails({required int limit, required String rankingType}) async {
    // Skip if already loading this ranking type
    if (_loadingStates[rankingType] == true) return;

    // Skip if data already exists (unless you want to force refresh)
    if (_rankingLists.containsKey(rankingType)) return;

    _loadingStates[rankingType] = true;
    _errors.remove(rankingType);
    // Don't notify here - wait until we have results

    try {
      final response = await getAnimeByRankingTypeApi(
          rankingType: rankingType,
          limit: limit
      );

      if (response?.statusCode == 200) {
        final data = jsonDecode(response!.body);
        final animeNodeList = data['data'] as List;

        _rankingLists[rankingType] = animeNodeList
            .where((animeNode) => animeNode['node']['main_picture'] != null)
            .map((node) => Anime.fromJson(node));
      } else {
        _errors[rankingType] = "Unexpected error occurred";
        CustomToast.showCustomToast(message: "Unexpected error occurred");
      }
    } catch (e) {
      _errors[rankingType] = "An error occurred while loading data";
      if (kDebugMode) {
        print("Error for $rankingType: $e");
      }
      CustomToast.showCustomToast(
          message: "An error occurred while checking payment status");
    } finally {
      _loadingStates[rankingType] = false;
      notifyListeners(); // Single notification when complete
    }
  }
}






