import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:stylo_app/features/auth/presentation/widgets/button_gesture_detector.dart';
import 'package:stylo_app/features/auth/presentation/widgets/custom_image_widget.dart';
import 'package:stylo_app/features/auth/presentation/widgets/description_text_widget.dart';
import 'package:stylo_app/features/auth/presentation/widgets/dot_ondicator.dart';
import 'package:stylo_app/features/auth/presentation/widgets/header_text_widget.dart';


class DiscoverTimeLessScreen extends StatefulWidget {
  DiscoverTimeLessScreen({super.key});

  @override
  State<DiscoverTimeLessScreen> createState() => _DiscoverTimeLessScreenState();
}

class _DiscoverTimeLessScreenState extends State<DiscoverTimeLessScreen> {
  final PageController controller = PageController();
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFE8ECF4);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: true,
        backgroundColor: backgroundColor,
        leading: const Icon(
          Icons.diamond_outlined,
          size: 24,
          color: Color(0xff542AE6),
        ),
        title: Text(
          'Stylo',
          style: AppTextStyles.price.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: const Center(
                child: Text('Skip', style: TextStyle(color: Colors.grey)),
              ),
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
                          'https://lh3.googleusercontent.com/aida-public/AB6AXuAyfwHB8iNVfp3lkMC-y3s5vk9l64_QGZJ6UoXmMyA9XzPWpjFILMzmYFsnw58drjAh3AsudcBTNCP6bwwVnNRGqZkDGQ6qMku-QE3A6O8m3Up-f0ptic7j-z5ZkXjC05UJ9APzLgRh3-hiZ3BN955GdayyquEYbPvZ_gFx0sWtB2XImYc4ieq4bxaNlG_mQ7OonYePgQie4axeI4I54YHjPBGjQyn0Pw1hkXrazDeEssGARDR8PvYo8WNXXO0W4iRgaznf0FyGu90',
                    ),
                    const SizedBox(height: 30),
                    HeaderTextWidget(headText: 'Discover Timeless Elegance'),
                    DescriptionTextWidget(
                      descTextEnjoy:
                          'Explore our exclusive collection of luxury jewelry',
                      descTextSeam:
                          'crafted to celebrate every special moment.',
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
                  CustomPageIndicator(currentIndex: 2, count: 3),
                  const SizedBox(height: 30),
                  GestureDetectorWidget(
                    textButton: 'Next',
                    icons: Icons.arrow_forward_ios,
                    onTap: () {Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen(),));},
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