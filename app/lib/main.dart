// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

// Project imports:
import 'package:app/screens/entry_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale.fromSubtags(languageCode: 'sr', scriptCode: 'Latn'),
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
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: FlexThemeData.light(scheme: FlexScheme.mallardGreen),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mallardGreen),
      themeMode: ThemeMode.system,
      home: const EntryScreen(),
    );
  }
}
