import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/features/more/presentation/widgets/about_app_bar_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/about_divider_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/about_feature_item_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/about_heritage_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/about_newsletter_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/about_quote_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/about_section_title_widget.dart';
import 'package:stylo_app/features/more/presentation/widgets/about_stat_badge_widget.dart';


class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AboutAppBarWidget(onBack: () => Navigator.pop(context)),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Heritage section ────────────────────────────────
            const AboutHeritageWidget(),
            SizedBox(height: AppSizes.lg),

            // ── Stat badge: 40+ years ───────────────────────────
            const AboutStatBadgeWidget(
              stat:  '40+',
              label: 'Years of Mastery',
            ),
            SizedBox(height: AppSizes.lg),

            // ── Founder quote ───────────────────────────────────
            const AboutQuoteWidget(
              quote:  'Beauty is found in the precision of the unseen detail.',
              author: '— The Founder',
            ),

            const AboutDividerWidget(),

            // ── Craftsmanship section title ─────────────────────
            const AboutSectionTitleWidget(title: 'Craftsmanship\nRedefined'),
            SizedBox(height: AppSizes.xl),

            // ── Feature 1: Conflict-Free Sourcing ───────────────
            const AboutFeatureItemWidget(
              icon:        Icons.diamond_outlined,
              title:       'Conflict-Free Sourcing',
              description: 'Every gemstone is ethically sourced from certified mines that practice environmental stewardship and fair labor.',
            ),

            const AboutDividerWidget(),

            // ── Feature 2: Bespoke Artistry ─────────────────────
            const AboutFeatureItemWidget(
              icon:        Icons.edit_outlined,
              title:       'Bespoke Artistry',
              description: 'Our design process is a collaborative journey, turning your personal narrative into a wearable work of art.',
            ),

            const AboutDividerWidget(),

            // ── Feature 3: Lifetime Guarantee ───────────────────
            const AboutFeatureItemWidget(
              icon:        Icons.shield_outlined,
              title:       'Lifetime Guarantee',
              description: 'We stand behind every well-set setting with a comprehensive warranty that ensures your piece remains perfect forever.',
            ),

            const AboutDividerWidget(),

            // ── Newsletter / CTA ────────────────────────────────
            const AboutNewsletterWidget(),

            SizedBox(height: AppSizes.xl),
          ],
        ),
      ),
    );
  }
}