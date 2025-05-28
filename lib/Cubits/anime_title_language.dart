import 'package:animeworld/database_data/database_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
typedef IsEnglish=bool;
class AnimeTitleLanguageCubit extends Cubit<IsEnglish> {
 AnimeTitleLanguageCubit() : super(false) {
    _fetchAnimeTitleLanguage();
  }
  bool get isEnglish => state ;
  Future<void> _fetchAnimeTitleLanguage() async {
    final isEnglish = await DatabaseHelper.instance.isEnglish;
    emit(isEnglish);
  }

  Future<void> changeAnimeTitleLanguage({required bool isEnglish}) async {
    await DatabaseHelper.instance.setIsEnglish(isEnglish);
    emit(isEnglish );
  }

}
