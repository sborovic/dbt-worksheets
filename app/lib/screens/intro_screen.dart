// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import '../constants.dart' as constants;
import 'entry_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen(this.locale, {Key? key}) : super(key: key);
  final Locale locale;
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String? _language;

  @override
  initState() {
    super.initState();
    _language = widget.locale.toLanguageTag();
    debugPrint("U INIT STATE SAM SETOVAO> " + _language!);
  }

  final introKey = GlobalKey<IntroductionScreenState>();

  RadioListTile<String> buildLanguageTile(String title, String value) {
    return RadioListTile<String>(
      title: Text(title),
      value: value,
      groupValue: _language,
      onChanged: (String? value) {
        setState(() {
          _language = value;
          context.setLocale(constants.locales[value]!);
        });
      },
    );
  }

  PageViewModel buildFirstScreen(BuildContext context) {
    return PageViewModel(
        image: SvgPicture.asset(
          'assets/images/undraw_around_the_world.svg',
        ),
        title: 'introPageOneTitle'.tr(),
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            buildLanguageTile('srpski', 'sr-Latn'),
            buildLanguageTile('English', 'en'),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    // _language = context.locale.toString();
    // _firstPageTitle = titles['en'];
    return IntroductionScreen(
      key: introKey,
      showNextButton: true,
      next: const Icon(Icons.arrow_forward),
      pages: [
        buildFirstScreen(context),
        PageViewModel(
          title: 'introPageTwoTitle'.tr(),
          body: "introPageTwoBody".tr(),
          image: SvgPicture.asset('assets/images/undraw_to_do.svg'),
        ),
        PageViewModel(
          title: 'introPageThreeTitle'.tr(),
          body: "introPageThreeBody".tr(),
          image: SvgPicture.asset('assets/images/undraw_metrics.svg'),
        ),
      ],
      done: const Text("introButtonDone",
              style: TextStyle(fontWeight: FontWeight.w600))
          .tr(),
      onDone: () async {
        (await SharedPreferences.getInstance())
            .setString('language', _language!);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const EntryScreen(),
          ),
        );
      },
    ); //Material App
  }
}
