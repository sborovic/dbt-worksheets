import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart' as Constants;
import 'entry_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen(this.locale, {Key? key}) : super(key: key);
  final Locale locale;
  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final Map<String, String> titles = const {
    'en': 'Select Your Language:',
    'sr-Latn': 'Izaberite jezik:'
  };
  String? _language;
  late String _firstPageTitle;

  @override
  initState() {
    super.initState();
    _language = widget.locale.toLanguageTag();
    _firstPageTitle = titles[_language]!;
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
          _firstPageTitle = titles[value]!;
          _language = value;
        });
      },
    );
  }

  PageViewModel buildFirstScreen(BuildContext context) {
    return PageViewModel(
        image: SvgPicture.asset(
          'assets/images/undraw_around_the_world.svg',
        ),
        title: _firstPageTitle,
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
      overrideNext: IconButton(
        onPressed: () async {
          if (_language != null) {
            introKey.currentState?.next();
            context.setLocale(Constants.locales[_language]!);
            (await SharedPreferences.getInstance())
                .setString('language', _language!);
          }
        },
        icon: const Icon(Icons.arrow_forward),
      ),
      pages: [
        buildFirstScreen(context),
        PageViewModel(
          title: 'Veštine',
          body: "Zabeležite svoje vežbanje veština...",
          image: SvgPicture.asset('assets/images/undraw_to_do.svg'),
        ),
        PageViewModel(
          title: 'Izveštaj',
          body:
              "...i kreirajte izveštaj za vremenski period koji sami odabete. ",
          image: SvgPicture.asset('assets/images/undraw_metrics.svg'),
        ),
      ],
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const EntryScreen(),
          ),
        );
      },
    ); //Material App
  }
}
