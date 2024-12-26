import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvvm/core/utils/constant/app_assets.dart';
import 'package:mvvm/features/auth/presentaion/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_font_size.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static const String routeName = "/OnBoardingScreen";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int selectedPage = 0;
  // CarouselController buttonCarouselController = CarouselController();
  List<Map> items = [
    {
      "image": AppAssets.onboarding1,
      "title": "Safe Hire",
      "description": const Column(
        children: [
          Text(
            "Hire Emebet-Verified Candidates",
            style: TextStyle(
                color: AppColors.grey600,
                fontWeight: FontWeight.normal,
                fontSize: AppFontSize.small),
          ),
          Text(
            "for Safety.",
            style: TextStyle(
                color: AppColors.grey600,
                fontWeight: FontWeight.normal,
                fontSize: AppFontSize.small),
          ),
        ],
      )
    },
    {
      "image": AppAssets.onboarding2,
      "title": "Instant Hiring",
      "description": const Column(
        children: [
          Text(
            "We know you're busy, Hire from",
            style: TextStyle(
                color: AppColors.grey600,
                fontWeight: FontWeight.normal,
                fontSize: AppFontSize.small),
          ),
          Text(
            "your smart phone.",
            style: TextStyle(
                color: AppColors.grey600,
                fontWeight: FontWeight.normal,
                fontSize: AppFontSize.small),
          ),
        ],
      )
    },
    {
      "image": AppAssets.onboarding3,
      "title": "Transparent Pricing",
      "description": const Column(
        children: [
          Text(
            "No hidden fees. What you see is",
            style: TextStyle(
                color: AppColors.grey600,
                fontWeight: FontWeight.normal,
                fontSize: AppFontSize.small),
          ),
          Text(
            "what you pay.",
            style: TextStyle(
                color: AppColors.grey600,
                fontWeight: FontWeight.normal,
                fontSize: AppFontSize.small),
          ),
        ],
      )
    },
  ];
  Column caroselWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(items[selectedPage]["image"]),
        Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 12),
          child: Text(
            items[selectedPage]["title"],
            style: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
                fontSize: AppFontSize.medium),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: items[selectedPage]["description"],
        ),
      ],
    );
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.backgroundColor,
      statusBarIconBrightness: Brightness.light,
    ));
    setKey();
    super.initState();
  }

  void setKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFirstLaunch', false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: 300,
                  width: 340,
                  // decoration:   BoxDecoration(
                  //     image: DecorationImage(
                  //         image: AssetImage(AppAssets.vector),
                  //         fit: BoxFit.cover)),
                ),
              ),
              CarouselSlider(
                items: List.generate(3, (index) => caroselWidget()),
                // carouselController: buttonCarouselController,
                options: CarouselOptions(
                  height: 600,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      selectedPage = index;
                    });
                  },
                  initialPage: items.length,
                ),
              ),
              // Positioned(
              //   top: 0,
              //   right: 0,
              //   child: TextButton(
              //       onPressed: () => Navigator.pushAndRemoveUntil(
              //           context,
              //           customPageRoute(const LanguageSelectionScreen()),
              //           (route) => false),
              //       child: const Text(
              //         "Skip",
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: AppFontSize.medium,
              //             color: AppColors.black),
              //       )),
              // ),
              Positioned(
                bottom: 40,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DotsIndicator(
                      dotsCount: 3,
                      position: selectedPage,
                      decorator: const DotsDecorator(
                        size: Size.fromRadius(8),
                        activeSize: Size.fromRadius(8),
                        color: AppColors.grey400,
                        activeColor: AppColors.primaryColor,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                              color: AppColors.grey600,
                              fontWeight: FontWeight.normal,
                              fontSize: AppFontSize.small),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                LoginScreen.routeName, (route) => false);
                          },
                          child: const Text(
                            "Sign in",
                            style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: AppFontSize.small),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
