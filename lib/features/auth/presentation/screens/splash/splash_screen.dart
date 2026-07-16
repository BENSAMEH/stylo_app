import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:stylo_app/features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:stylo_app/features/home/presentation/screens/main_layout_screen.dart';
 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    // Check token status after the UI finishes mounting
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthentication();
    });
  }

  void _checkAuthentication() async {
    // 1. Give the splash screen branding 2-3 seconds to show off your beautiful UI
    await Future.delayed(const Duration(seconds: 3));
    
    if (!mounted) return;

    // 2. Check if the token is valid using your cubit/repo logic
    final bool loggedIn = context.read<AuthCubit>().isLoggedIn();

    if (loggedIn) {
      // Token exists -> Jump right over onboarding and login straight into the App Home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainLayoutScreen()), // Replace with your real core app layout widget
      );
    } else {
      // No token found -> New user or logged out -> Show onboarding
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) =>  OnBoardingScreenNext()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),

          // ── App name ─────────────────────────────────────────
          Center(
            child: Text(
              'STYLO',
              style: AppTextStyles.displayLarge.copyWith(
                fontSize: 69,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
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
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: AppSizes.xs),
                Text(
                  'EXCELLENCE',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
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