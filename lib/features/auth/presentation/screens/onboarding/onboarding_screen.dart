import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/auth/presentation/screens/onboarding/premium%20_qualit_screen.dart';
import 'package:stylo_app/features/auth/presentation/widgets/button_gesture_detector.dart';
import 'package:stylo_app/features/auth/presentation/widgets/custom_image_widget.dart';
import 'package:stylo_app/features/auth/presentation/widgets/description_text_widget.dart';
import 'package:stylo_app/features/auth/presentation/widgets/dot_ondicator.dart';
import 'package:stylo_app/features/auth/presentation/widgets/header_text_widget.dart';


class OnBoardingScreenNext extends StatefulWidget {
  OnBoardingScreenNext({super.key});

  @override
  State<OnBoardingScreenNext> createState() => _OnBoardingScreenNextState();
}

class _OnBoardingScreenNextState extends State<OnBoardingScreenNext> {
  final PageController controller = PageController();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE8ECF4);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: Text(
          'stylo',
          style: AppTextStyles.price.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    CustomImageWidget(
                      image:
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuBAhIcuqLNc2lQUvU-WK1pQjL4kdNkB2lLncQddtWjl9N4Xgc_6-ZQzYVfri2bHFbTV722y67oMzI9KhUYBCBAgkxoxo9RjQ2WZ2gppmvc7I0mdAgKhUx0BTbOXm7PNH7MNFmk9jE9BspFtBxNDyY5EgrljQ4gTaAAIbSLb_PaetWyQKYbkfM0eZQCwoIPWmERqt0-CifHDXR_kTyWbjOt-YwBpmlQKj3ZD0P89eG5qalSHdKLOEQEcL445WnGSdMWH-Ev_j7yzkwU',
                    ),
                    const SizedBox(height: 30),
                    HeaderTextWidget(headText: 'Fast & Secure Shopping'),
                    DescriptionTextWidget(
                      descTextEnjoy:
                          'Enjoy secure payments, fast delivery, and',
                      descTextSeam: 'a seamless shopping experience with',
                      descTextBariq: 'Stylo',
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 50,
                right: 50,
                bottom: 40,
                top: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPageIndicator(currentIndex: 0, count: 3),
                  const SizedBox(height: 30),
                  GestureDetectorWidget(
                    textButton: 'Get Started',
                    icons: Icons.arrow_forward,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return PremiumQualityScreen();
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}