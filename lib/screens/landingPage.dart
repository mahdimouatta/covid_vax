import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:covidvax/theme/style.dart';
import 'package:covidvax/screens/homePage.dart';
import 'package:covidvax/languages/language_ar.dart';
import 'package:covidvax/languages/language_fr.dart';
import 'package:covidvax/languages/language_en.dart';

class LandingPage2 extends StatefulWidget {
  static final String path = "lib/src/pages/onboarding/intro6.dart";
  @override
  _IntroSixPageState createState() => _IntroSixPageState();
}

class _IntroSixPageState extends State<LandingPage2> {
  SwiperController _controller = SwiperController();
  int _currentIndex = 0;
  List<String> titles = [
    LanguageEn().applicationName,
    LanguageAR().applicationName,
    LanguageFR().applicationName,
  ];
  final List<String> subtitles = [
    LanguageEn().landingText + " " + LanguageEn().landingText2,
    LanguageAR().landingText + " " + LanguageAR().landingText2,
    LanguageFR().landingText + " " + LanguageFR().landingText2,
  ];
  final List<Color> colors = [
    appTheme4().primaryColor,
    appTheme4().hintColor,
    appTheme4().dividerColor,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            loop: false,
            index: _currentIndex,
            onIndexChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            controller: _controller,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                activeColor: Colors.red,
                activeSize: 20.0,
              ),
            ),
            itemCount: 3,
            itemBuilder: (context, index) {
              return IntroItem(
                title: titles[index],
                subtitle: subtitles[index],
                bg: colors[index],
                imageUrl: "assets/images/3515462.jpg",
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FlatButton(
              child: Text("Skip"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: IconButton(
              icon:
                  Icon(_currentIndex == 2 ? Icons.check : Icons.arrow_forward),
              onPressed: () {
                if (_currentIndex != 2)
                  _controller.next();
                else
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
              },
            ),
          )
        ],
      ),
    );
  }
}

class IntroItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color bg;
  final String imageUrl;

  const IntroItem(
      {Key key, @required this.title, this.subtitle, this.bg, this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bg ?? Theme.of(context).primaryColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 35.0,
                    color: Colors.white),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 10.0),
                Text(
                  subtitle,
                  style: TextStyle(color: Colors.white, fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 20.0),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35.0),
                    child: Material(
                      elevation: 4.0,
                      child: Image.asset(
                        imageUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
