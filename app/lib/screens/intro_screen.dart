import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'entry_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String? _language;
  final introKey = GlobalKey<IntroductionScreenState>();
  PageViewModel buildFirstScreen(BuildContext context) {
    return PageViewModel(
      image: SvgPicture.asset(
        'assets/images/undraw_around_the_world.svg',
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
      ),
      title: 'Izaberite jezik:',
      bodyWidget: StatefulBuilder(
        builder: (context, _setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RadioListTile<String>(
                title: const Text('English'),
                value: 'en',
                groupValue: _language,
                onChanged: (String? value) {
                  _setState(() {
                    _language = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('srpski'),
                value: 'sr-Latn',
                groupValue: _language,
                onChanged: (String? value) {
                  _setState(() {
                    _language = value;
                  });
                },
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _language = context.locale.toString();
    return IntroductionScreen(
      key: introKey,
      showNextButton: true,
      overrideNext: IconButton(
        onPressed: () {
          if (_language != null) {
            introKey.currentState?.next();
            context.setLocale(Locale.fromSubtags(languageCode: _language!));
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
