import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:stylo_app/features/auth/presentation/screens/onboarding/discover_time_less_screen.dart';
import 'package:stylo_app/features/auth/presentation/widgets/button_gesture_detector.dart';
import 'package:stylo_app/features/auth/presentation/widgets/custom_image_widget.dart';
import 'package:stylo_app/features/auth/presentation/widgets/description_text_widget.dart';
import 'package:stylo_app/features/auth/presentation/widgets/dot_ondicator.dart';
import 'package:stylo_app/features/auth/presentation/widgets/header_text_widget.dart';



class PremiumQualityScreen extends StatefulWidget {
  PremiumQualityScreen({super.key});

  @override
  State<PremiumQualityScreen> createState() => _PremiumQualityScreenState();
}

class _PremiumQualityScreenState extends State<PremiumQualityScreen> {
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
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: Row(
          children: [
            const Icon(
              Icons.diamond_outlined,
              size: 24,
              color: Color(0xff542AE6),
            ),
            const SizedBox(width: 8),
            Text(
              'Stylo',
              style: AppTextStyles.price.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));},
              child: const Center(child: Text('Skip')),
            ),
          ),
        ],
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
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuCfxW14bqVAf7zDQt6cJ_uMz-scacctQIjNgZC3UfbomxHIJrUZm0EGKz3HF5KIDyzcJE9FBU3tF6kpn1nHpqWRxmaHVshlUzZNT6SeSnBYBWLuydT2zC6crUxuRqBhYdbRzeiV094NkfWe31JfICzfuQF3rlT5GE70rEvJOuzUcUelnEXogmTepKUDs46WdGEWswvMfb_caR0zwiBo2FHJy0TU0bDkIRw5Nqp54xuHiumjcGV1wjtWD8CvV-QHKyRMGHdfP55s06U',
                    ),
                    const SizedBox(height: 30),
                    HeaderTextWidget(headText: 'Premium Quality'),
                    DescriptionTextWidget(
                      descTextEnjoy: 'Every piece is carefully selected with',
                      descTextSeam: 'exceptional craftsmanship and',
                      descTextBariq: 'luxurious materials.',
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
                  CustomPageIndicator(currentIndex: 1, count: 3),
                  const SizedBox(height: 30),
                  GestureDetectorWidget(
                    textButton: 'Next',
                    icons: Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DiscoverTimeLessScreen();
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