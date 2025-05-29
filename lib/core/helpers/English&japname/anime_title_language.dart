import 'package:animeworld/core/helpers/database_data/database_data.dart';
import 'package:flutter/foundation.dart';

class AnimeTitleLanguageProvider extends ChangeNotifier {
  bool _isEnglish = false;

  AnimeTitleLanguageProvider() {
    _fetchAnimeTitleLanguage();
  }

  bool get isEnglish => _isEnglish;

  Future<void> _fetchAnimeTitleLanguage() async {
    _isEnglish = await DatabaseHelper.instance.isEnglish;
    notifyListeners();
  }

  Future<void> changeAnimeTitleLanguage({required bool isEnglish}) async {
    await DatabaseHelper.instance.setIsEnglish(isEnglish);
    _isEnglish = isEnglish;
    notifyListeners();
  }
}