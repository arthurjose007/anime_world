import 'package:animeworld/core/utils/config/style/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/helpers/English&japname/anime_title_language.dart';
import '../../../core/helpers/English&japname/theme_cubit.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: const Padding(
        padding: Paddings.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSwitchWidget(),
            SizedBox(height: 20),
            AnimeTitleLanguageSwitch(),
          ],
        ),
      ),
    );
  }
}

class ThemeSwitchWidget extends StatelessWidget {
  const ThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Dark Mode"),
        CupertinoSwitch(
          value: isDarkMode,
          onChanged: (value) async {
            await themeProvider.setThemeMode(isDarkMode: value);
          },
        ),
      ],
    );
  }
}

class AnimeTitleLanguageSwitch extends StatelessWidget {
  const AnimeTitleLanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<AnimeTitleLanguageProvider>(context);
    final isEnglish = languageProvider.isEnglish;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("English Titles"),
        CupertinoSwitch(
          value: isEnglish,
          onChanged: (value) {
            languageProvider.changeAnimeTitleLanguage(isEnglish: value);
          },
        ),
      ],
    );
  }
}