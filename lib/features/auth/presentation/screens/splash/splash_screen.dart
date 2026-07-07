import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/auth/presentation/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => OnBoardingScreenNext()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Spacer(),

          // ── App name ─────────────────────────────────────────
          Center(
            child: Text(
              'STYLO',
              style: AppTextStyles.displayLarge.copyWith(
                fontSize:   69,
                fontWeight: FontWeight.w700,
                color:      AppColors.primary,
              ),
            ),
          ),

          const Spacer(),

          // ── Tagline ───────────────────────────────────────────
          Padding(
            padding: EdgeInsets.only(bottom: AppSizes.xl),
            child: Column(
              children: [
                Text(
                  'WHERE  ELEGANCE  MEETS',
                  style: AppTextStyles.caption.copyWith(
                    color:      AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: AppSizes.xs),
                Text(
                  'EXCELLENCE',
                  style: AppTextStyles.caption.copyWith(
                    color:      AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}