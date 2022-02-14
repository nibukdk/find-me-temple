import 'package:church/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  late final SharedPreferences prefs;
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    Future.delayed(Duration.zero,
        () async => prefs = await SharedPreferences.getInstance());

    super.initState();
  }

  void _onIntroEnd(context) {
    prefs.setInt('onBoardKey', 0);
    GoRouter.of(context).go("/");
  }

  Widget _fullPageImage(String imgPath) {
    final img = Image.asset(
      imgPath,
      // fit: BoxFit.cover,
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
    );

    return SafeArea(child: img);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 19.0,
      color: Colors.black,
    );

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      // pageColor: Color.fromARGB(100, 255, 209, 166),
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Color.fromARGB(255, 255, 209, 166),

        pages: [
          PageViewModel(
            body: "",
            image: _fullPageImage("assets/onboard/FindTemples.png"),
            title: "",
            footer: ElevatedButton(
              child: const Text(
                "Lets Get Started",
              ),
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
              ),
            ),
            decoration: pageDecoration.copyWith(
              contentMargin: const EdgeInsets.symmetric(horizontal: 16),
              fullScreen: true,
              bodyFlex: 1,
              imageFlex: 2,
            ),
          ),
          PageViewModel(
            body: "",
            image: _fullPageImage("assets/onboard/FindVenues.png"),
            title: "",
            footer: ElevatedButton(
              child: const Text(
                "Lets Get Started",
              ),
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.redAccent),
              ),
            ),
            decoration: pageDecoration.copyWith(
              contentMargin: const EdgeInsets.symmetric(horizontal: 16),
              fullScreen: true,
              bodyFlex: 1,
              imageFlex: 2,
            ),
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text(
          'Skip',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        next: const Icon(Icons.arrow_forward),

        done: const Text(
          'Done',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        dotsDecorator: const DotsDecorator(
          activeColor: Colors.red,
          size: Size(10.0, 10.0),
          color: Colors.blue,
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
