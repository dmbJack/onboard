import 'package:flutter/material.dart';

enum ONBOARDTYPE { circleDote, simple }

class Onboard {

  


  ///List of screen, no need to set scaffold before using
  List<Widget> listScreen;

  ///Style of Button for change the page to next page
  ButtonStyle? nextButtonStyle;

  ///Here add the Text widget for the nexButton
  Text nextButtonText;

  ///Style of Button for jump to last page of the onboard
  ButtonStyle? skipButtonStyle;

  ///Here add the Text widget for SkipButton
  Text skipButtonText;

  ///Style of button to quit the onboard
  ButtonStyle? beginButtonStyle;

  ///Here add the Text widget for beginButton
  Text beginButtonText;

  ///Function for the beginButton
  void Function()? funcBeginButton;

  ///Color of current step
  Color currentStepColor;

  ///Color of the stepper
  Color stepperColor;

  ///The type of stepper
  /// - ONBOARDTYPE.simple for the stepper style in dot
  /// - ONBOARDTYPE.circleDote for the stepper style with animation
  ONBOARDTYPE? type;

  /// The curve of the animation
  Curve curve;
  Onboard({
    required this.listScreen,
    this.nextButtonStyle,
    required this.nextButtonText,
    this.skipButtonStyle,
    required this.skipButtonText,
    this.beginButtonStyle,
    required this.beginButtonText,
    this.currentStepColor = Colors.blue,
    this.stepperColor = Colors.grey,
    this.type = ONBOARDTYPE.simple,
    this.curve = Curves.bounceOut,
    required this.funcBeginButton,
  });
}

class OnboardingPage extends StatefulWidget {
  final Onboard onboard;
  const OnboardingPage({
    Key? key,
    required this.onboard,
  }) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _page = 0;
  List<bool> isPage = [];

  List<bool> generateIsPage(int screenLength) {
    List<bool> result = [];
    for (var i = 0; i < screenLength; i++) {
      if (i == 0) {
        result.insert(i, true);
        continue;
      }
      result.insert(i, false);
    }
    return result;
  }

  List<Widget> generateStepper(Onboard onboard) {
    List<Widget> result = [];
    final screenLength = onboard.listScreen.length;
    for (var i = 0; i < screenLength; i++) {
      if (i == 0) {
        switch (onboard.type) {
          case ONBOARDTYPE.simple:
            result.insert(
              i,
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(i);
                },
                child: AnimatedContainer(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  curve: onboard.curve,
                  duration: const Duration(seconds: 1),
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: (isPage[i])
                        ? onboard.currentStepColor
                        : onboard.stepperColor,
                  ),
                ),
              ),
            );

            break;
          case ONBOARDTYPE.circleDote:
            result.insert(
              i,
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(i);
                },
                child: AnimatedContainer(
                  curve: onboard.curve,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  duration: const Duration(seconds: 1),
                  width: (isPage[i]) ? 25 : 10,
                  height: 10,
                  decoration: BoxDecoration(
                      color: (isPage[i])
                          ? onboard.currentStepColor
                          : onboard.stepperColor,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            );

            break;
          default:
        }

        continue;
      }

      switch (onboard.type) {
        case ONBOARDTYPE.simple:
          result.insert(
            i,
            GestureDetector(
              onTap: () {
                _pageController.jumpToPage(i);
              },
              child: AnimatedContainer(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                curve: onboard.curve,
                duration: const Duration(seconds: 1),
                width: 10,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (isPage[i])
                      ? onboard.currentStepColor
                      : onboard.stepperColor,
                ),
              ),
            ),
          );

          break;
        case ONBOARDTYPE.circleDote:
          result.insert(
            i,
            GestureDetector(
              onTap: () {
                _pageController.jumpToPage(i);
              },
              child: AnimatedContainer(
                curve: onboard.curve,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                duration: const Duration(seconds: 1),
                width: (isPage[i]) ? 25 : 10,
                height: 10,
                decoration: BoxDecoration(
                    color: (isPage[i])
                        ? onboard.currentStepColor
                        : onboard.stepperColor,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          );

          break;
        default:
      }
    }
    return result;
  }

  @override
  void initState() {
    isPage = generateIsPage(widget.onboard.listScreen.length);
    generateStepper(widget.onboard);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final onboard = widget.onboard;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
              style: onboard.skipButtonStyle,
              onPressed: () {
                _pageController.jumpToPage(isPage.length - 1);
              },
              child: (!isPage.last) ? onboard.skipButtonText : Container()),
        ],
      ),
      body: PageView(
          onPageChanged: (pageIndex) {
            setState(() {
              final index = isPage.length;
              isPage = [];
              //Set all index in false before set the current position at true
              for (var i = 0; i < index; i++) {
                isPage.add(false);
              }
              _page = pageIndex;
              isPage[pageIndex] = true;
            });
          },
          controller: _pageController,
          children: onboard.listScreen),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              height: 10,
              child: Row(children: generateStepper(onboard)),
            ),
            const Spacer(),
            AnimatedCrossFade(
                firstChild: OutlinedButton(
                    onPressed: () {
                      _pageController.jumpToPage(_page + 1);
                    },
                    style: onboard.nextButtonStyle,
                    child: onboard.nextButtonText),
                secondChild: ElevatedButton(
                    style: onboard.beginButtonStyle,
                    onPressed: () {},
                    child: onboard.beginButtonText),
                crossFadeState: (isPage.last)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 800)),
          ],
        ),
      ),
    );
  }
}
