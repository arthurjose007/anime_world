import 'dart:io';

import 'package:animeworld/Cubits/anime_title_language.dart';
import 'package:animeworld/Cubits/theme_cubit.dart';
import 'package:animeworld/config/theme/app_theme.dart';
import 'package:animeworld/myhttpoverrides/myhttpoverride.dart';
import 'package:animeworld/screens/homescreen.dart';
import 'package:animeworld/screens/test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AnimeTitleLanguageCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
        final themeMode = state;
        return MaterialApp(
          themeMode: themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
        );
      }),
    );
  }
}
