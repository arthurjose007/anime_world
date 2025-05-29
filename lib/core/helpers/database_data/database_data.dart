import 'package:animeworld/core/utils/shared/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseHelper {
  DatabaseHelper._priveteConstructor();
  static final DatabaseHelper instance = DatabaseHelper._priveteConstructor();
  static SharedPreferences? _database;
  Future<SharedPreferences> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

//Initialize database
  Future<SharedPreferences> _initDatabase() async {
    _database = await SharedPreferences.getInstance();
    return _database!;
  }

//Theme mode setters and getters
  Future<bool> get isDarkMode async {
    final db = await instance.database;
    return db.getBool(Constants.isDarkMode) ?? false;
  }

  Future<bool> setDarkMode(bool isDark) async {
    final db = await instance.database;
    return await db.setBool(Constants.isDarkMode, isDark);
  }
//Anime title language setters and getters
  Future<bool> get isEnglish async {
    final db = await instance.database;
    return db.getBool(Constants.isEnglish) ?? false;
  }

  Future<bool> setIsEnglish(bool isEnglish) async {
    final db = await instance.database;
    return await db.setBool(Constants.isDarkMode, isEnglish);
  }
}
