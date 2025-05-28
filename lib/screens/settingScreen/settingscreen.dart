import 'package:animeworld/Cubits/anime_title_language.dart';
import 'package:animeworld/Cubits/theme_cubit.dart';
import 'package:animeworld/common/styles/paddings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        title: Text(
          'Setting',
        ),
      ),
      body: const Padding(
        padding: Paddings.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ThemeSwitchWidget(),
            SizedBox(
              height: 20,
            ),
            AnimeTitleLanguageSwitch()
          ],
        ),
      ),
    );
  }
}

class ThemeSwitchWidget extends StatefulWidget {
  const ThemeSwitchWidget({super.key});

  @override
  State<ThemeSwitchWidget> createState() => _ThemeSwitchWidgetState();
}

class _ThemeSwitchWidgetState extends State<ThemeSwitchWidget> {
  bool isDarkMode = false;
  Future<void> toggleDartMode(value) async {
    setState(() {
      isDarkMode = !isDarkMode;
    });
    context.read<ThemeCubit>().changeTheme(isDarkMode: isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Is Dark Mode"),
        BlocBuilder<ThemeCubit, ThemeMode>(builder: (context, state) {
          isDarkMode = state == ThemeMode.dark;
          return CupertinoSwitch(value: isDarkMode, onChanged: toggleDartMode);
        })
      ],
    );
  }
}
class AnimeTitleLanguageSwitch extends StatefulWidget {
  const AnimeTitleLanguageSwitch({super.key});

  @override
  State<AnimeTitleLanguageSwitch> createState() => _AnimeTitleLanguageSwitchState();
}

class _AnimeTitleLanguageSwitchState extends State<AnimeTitleLanguageSwitch> {
  bool isEnglish=false;
  Future<void> toggleAnimeTitleLanguage(_)async{
    setState(() {
      isEnglish=!isEnglish;
      context.read<AnimeTitleLanguageCubit>().changeAnimeTitleLanguage(isEnglish: isEnglish);
    });

  }
 @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      const  Text("Is English"),
        BlocBuilder<AnimeTitleLanguageCubit, bool>(builder: (context, state) {
          isEnglish = state;
          return CupertinoSwitch(value: isEnglish, onChanged: toggleAnimeTitleLanguage);
        })
      ],
    );
  }
}