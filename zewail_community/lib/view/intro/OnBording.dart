import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../Core/Constant/constants.dart';
import '../../data/models/OnBordingModel.dart';
import '../auth/homelogine.dart';
import 'component/animated_widget.dart';
import 'component/custom_buttons.dart';

class OnBording extends StatefulWidget {
  const OnBording({super.key});

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          flex: 3,
          child: PageView.builder(
            controller: pageController,
            itemCount: listOfItems.length,
            onPageChanged: (newIndex) {
              setState(() {
                currentIndex = newIndex;
              });
            },
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                    width: 500,
                    height: 150,
                    child: CustomAnimatedWidget(
                      index: index,
                      delay: 100,
                      child: Image.asset(
                        listOfItems[index].img,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomAnimatedWidget(
                        index: index,
                        delay: 300,
                        child: Text(
                            textDirection: TextDirection.rtl,
                            listOfItems[index].title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      )),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: CustomAnimatedWidget(
                      index: index,
                      delay: 500,
                      child: Text(listOfItems[index].subTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SmoothPageIndicator(
                controller: pageController,
                count: listOfItems.length,
                effect: const ExpandingDotsEffect(
                  spacing: 6.0,
                  radius: 10.0,
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  expansionFactor: 3.8,
                  dotColor: Colors.grey,
                  activeDotColor: MyColors.kPrimaryColor,
                ),
                onDotClicked: (newIndex) {
                  setState(() {
                    currentIndex = newIndex;
                    pageController.animateToPage(newIndex,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease);
                  });
                },
              ),
              const Spacer(),
              currentIndex == 2
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: PrimaryButton(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => loginhome()),
                            (route) => false,
                          );
                        },
                        text: 'ابدأ',
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: PrimaryButton(
                        onTap: () {
                          setState(() {
                            pageController.animateToPage(2,
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.fastOutSlowIn);
                          });
                        },
                        text: 'تخط',
                      ),
                    ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    ));
  }
}
