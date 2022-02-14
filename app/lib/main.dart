// Flutter imports:
import 'package:app/providers/theme_provider.dart';
import 'package:app/screens/intro_screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

// Project imports:
import 'package:app/screens/entry_screen.dart';
import 'package:provider/provider.dart';
import 'package:is_first_run/is_first_run.dart';

bool? firstRun;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await IsFirstRun.reset();
  firstRun = await IsFirstRun.isFirstRun();
  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn'),
          Locale.fromSubtags(languageCode: 'en'),
        ],
        path: 'assets/translations',
        fallbackLocale:
            const Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (_, provider, __) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: FlexThemeData.light(scheme: FlexScheme.mallardGreen),
            darkTheme: FlexThemeData.dark(scheme: FlexScheme.mallardGreen),
            themeMode: provider.mode,
            home: firstRun! ? const IntroScreen() : const EntryScreen(),
          );
        },
      ),
    );
  }
}
