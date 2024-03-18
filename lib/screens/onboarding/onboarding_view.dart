import 'package:fifthproject/common_widget/primary_button.dart';
import 'package:fifthproject/common_widget/secondary_button.dart';
import 'package:fifthproject/controller/onboardingcontorller.dart';
import 'package:fifthproject/screens/login/signup_view2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../theme.dart';
// import '../bottom_bar/bottom_bar_view.dart';
import 'onboarding_design.dart';
// import '../homePage.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  OnBoardingController controller = Get.find<OnBoardingController>();
  PageController _controller = PageController();
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OnBoardingController>(
        builder: (controller) {
          return Stack(
            children: [
              PageView.builder(
                itemCount: pages.length,  
                controller: _controller,
                onPageChanged: (index) {
                  controller.indexpage = index;
                  controller.InLastPage();
                },
                itemBuilder: ((context, index) {
                  return Container(
                    color: TColor.gray.withOpacity(0.1),
                    child: Column(children: [
                      const SizedBox(
                        height: 200,
                      ),
                      SizedBox(
                        width: 260,
                        height: 260,
                        child: Center(
                          child: SvgPicture.asset(
                            pages[index].image!,  
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        pages[index].title!,  
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: TColor.white.withOpacity(0.6)),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          pages[index].body!,  
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: TColor.white.withOpacity(0.6),
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ]),
                  );
                }),
              ),
              Container(
                alignment: const Alignment(0, 0.75),
                child: controller.isLastPage
                    ? SecondaryButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Singup2()));
                        },
                        title: "Get Started",
                      )
                    // Container(
                    //     width: 240,
                    //     height: 40,
                    //     child: ElevatedButton(
                    //       style: ButtonStyle(
                    //           backgroundColor: MaterialStatePropertyAll(
                    //               Colors.white.withOpacity(0.6))),
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) => const Singup2()));
                    //       },
                    //       child: const Text(
                    //         "GetStarted",
                    //         style: TextStyle(color: Colors.black, fontSize: 15),
                    //       ),
                    //     ),
                    //   )

                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _controller.jumpToPage(2);
                            },
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                  color: TColor.white.withOpacity(0.6),
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: 3,
                            effect: ExpandingDotsEffect(
                                activeDotColor: TColor.white.withOpacity(0.6)),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            child: Text("Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: TColor.white.withOpacity(0.6))),
                          ),
                        ],
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
