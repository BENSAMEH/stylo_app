import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class AboutNewsletterWidget extends StatefulWidget {
  const AboutNewsletterWidget({super.key});

  @override
  State<AboutNewsletterWidget> createState() =>
      _AboutNewsletterWidgetState();
}

class _AboutNewsletterWidgetState extends State<AboutNewsletterWidget> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.lg),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.06),
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// Title
          Text(
            'Experience the\nBrilliance',
            textAlign: TextAlign.center,
            style: AppTextStyles.headingLarge.copyWith(
              color: AppColors.primary,
            ),
          ),
          SizedBox(height: AppSizes.sm),

          /// Subtitle
          Text(
            'Subscribe to receive exclusive invitations to private viewings and seasonal collection previews.',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodySmall.copyWith(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              height: 1.6,
            ),
          ),
          SizedBox(height: AppSizes.lg),

          /// Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyles.bodyMedium.copyWith(
              color: Theme.of(context).textTheme.bodyLarge!.color,
            ),
            decoration: InputDecoration(
              hintText: 'Your boutique email',
              hintStyle: AppTextStyles.bodyMedium.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .color!
                    .withOpacity(.6),
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.md,
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.radiusMd),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.radiusMd),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.radiusMd),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 1.5,
                ),
              ),
            ),
          ),
          SizedBox(height: AppSizes.md),

          /// Button
          SizedBox(
            width: double.infinity,
            height: AppSizes.buttonHeight,
            child: ElevatedButton(
              onPressed: () {
                if (_emailController.text.isEmpty) return;

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text("Subscribed successfully!"),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.radiusMd),
                    ),
                  ),
                );

                _emailController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppSizes.radiusFull),
                ),
                textStyle: AppTextStyles.buttonLarge,
              ),
              child: const Text("Inquire"),
            ),
          ),
        ],
      ),
    );
  }
}