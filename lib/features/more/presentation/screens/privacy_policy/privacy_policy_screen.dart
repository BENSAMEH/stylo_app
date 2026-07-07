import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: Text(
          'Stylo',
          style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Category label ─────────────────────────────────
            Text(
              'LEGAL DOCUMENTATION',
              style: AppTextStyles.caption.copyWith(
                color:         AppColors.primary,
                fontWeight:    FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
            SizedBox(height: AppSizes.sm),

            // ── Title ──────────────────────────────────────────
            Text('Privacy Policy', style: AppTextStyles.headingLarge),
            SizedBox(height: AppSizes.sm),

            // ── Last updated ───────────────────────────────────
            Row(
              children: [
                const Icon(Icons.access_time,
                    size: 16, color: AppColors.lightTextSecondary),
                SizedBox(width: AppSizes.xs),
                Text(
                  'Last updated: June 18, 2024',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.lg),

            // ── Hero image ─────────────────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSizes.radiusXl),
              child: Image.network(
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAAQkXsdOYXqXX3UNLjGNnJkmNCoovVCBvfWW8j7Mitch_L1HXOY8bevCeQYv8B0UCY6Kd9pWVyKv9_ORVNsAwtdLlUcUn5ZhYm-x9ZVEB8T7o2nQf6EdMJ2a_4pjElhEz0__uyf-q-_9e0-_H3ij-vRY_PXMpJX9c9M2_8CjaSDR-C--_s4kz9JYmN7MvCzUTCcBB1wFzhBWwE4TOrw-pHTy8C1_vZQ-TT4eZ29fE7RIsO9sS9PJdk',
                height:    190,
                width:     double.infinity,
                fit:       BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 190,
                  color:  AppColors.lightDivider,
                  child:  const Icon(Icons.image_not_supported_outlined,
                      color: AppColors.lightTextSecondary),
                ),
              ),
            ),

            SizedBox(height: AppSizes.lg),

            // ── Data Collection ────────────────────────────────
            _PolicySectionCard(
              icon:        Icons.lock_outline,
              iconColor:   AppColors.primary,
              title:       'Data Collection',
              description: "At Stylo, your privacy is the cornerstone of our luxury shopping experience...",
              bullets: const [
                'Personal identifiers including name, email address and shipping details.',
                'Transactional data for secure payment processing.',
                'Preference data to personalize recommendations.',
              ],
            ),

            SizedBox(height: AppSizes.md),

            // ── How We Use Your Data ───────────────────────────
            _PolicySectionCard(
              icon:        Icons.auto_fix_high,
              iconColor:   AppColors.accent,
              title:       'How We Use Your Data',
              description: 'We utilize your information to provide a seamless and secure shopping experience.',
              extra: Container(
                padding: EdgeInsets.all(AppSizes.md),
                decoration: BoxDecoration(
                  color:        AppColors.primary.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SERVICE FULFILLMENT',
                      style: AppTextStyles.caption.copyWith(
                        color:         AppColors.primary,
                        fontWeight:    FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: AppSizes.xs),
                    Text(
                      'Processing purchases, handling logistics and customer support.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightTextSecondary,
                      ),
                    ),
                    SizedBox(height: AppSizes.sm),
                    Text(
                      'PERSONALIZATION',
                      style: AppTextStyles.caption.copyWith(
                        color:         AppColors.primary,
                        fontWeight:    FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: AppSizes.xs),
                    Text(
                      'Tailoring our website and exclusive previews.',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: AppSizes.md),

            // ── Third-Party Sharing ────────────────────────────
            _PolicySectionCard(
              icon:        Icons.share,
              iconColor:   AppColors.warning,
              title:       'Third-Party Sharing',
              description: 'Stylo does not sell your personal data. We only share information with trusted partners required to complete your orders securely.',
            ),

            SizedBox(height: AppSizes.xxl),

            // ── Footer CTA ─────────────────────────────────────
            Center(
              child: Text(
                'Have questions regarding your privacy?',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.lightTextSecondary,
                ),
              ),
            ),

            SizedBox(height: AppSizes.md),

            SizedBox(
              width:  double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                ),
                child: Text(
                  'CONTACT PRIVACY OFFICER',
                  style: AppTextStyles.buttonLarge.copyWith(letterSpacing: 0.5),
                ),
              ),
            ),

            SizedBox(height: AppSizes.xl),
          ],
        ),
      ),
    );
  }
}

// ── Policy section card ───────────────────────────────────────────────────────
class _PolicySectionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;
  final List<String>? bullets;
  final Widget? extra;

  const _PolicySectionCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
    this.bullets,
    this.extra,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color:        AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        boxShadow: [
          BoxShadow(
            color:      AppColors.lightTextSecondary.withOpacity(0.08),
            blurRadius: 12,
            offset:     const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Icon + title row
          Row(
            children: [
              CircleAvatar(
                backgroundColor: iconColor.withOpacity(0.12),
                child: Icon(icon, color: iconColor),
              ),
              SizedBox(width: AppSizes.sm),
              Text(title, style: AppTextStyles.headingSmall),
            ],
          ),

          SizedBox(height: AppSizes.md),

          // Description
          Text(
            description,
            style: AppTextStyles.bodyMedium.copyWith(
              color:  AppColors.lightTextSecondary,
              height: 1.7,
            ),
          ),

          // Bullets
          if (bullets != null) ...[
            SizedBox(height: AppSizes.md),
            ...bullets!.map(
              (e) => Padding(
                padding: EdgeInsets.only(bottom: AppSizes.sm),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.check_circle_outline,
                        color: AppColors.primary, size: 18),
                    SizedBox(width: AppSizes.sm),
                    Expanded(
                      child: Text(
                        e,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Extra widget
          if (extra != null) ...[SizedBox(height: AppSizes.md), extra!],
        ],
      ),
    );
  }
}