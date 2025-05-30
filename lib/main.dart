import 'dart:io';
import 'package:animeworld/core/helpers/config/theme/app_theme.dart';
import 'package:animeworld/core/helpers/myhttpoverrides/myhttpoverride.dart';
import 'package:animeworld/features/screens/HomeScreen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/helpers/English&japname/anime_title_language.dart';
import 'core/helpers/English&japname/theme_cubit.dart';
import 'features/screens/animescreen/detailedController/detailedresponseController.dart';
import 'features/screens/animescreen/rankingtype/home_controller.dart';
import 'features/screens/searchscreen/searchController/searchController.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => AnimeTitleLanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => DetailedProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}