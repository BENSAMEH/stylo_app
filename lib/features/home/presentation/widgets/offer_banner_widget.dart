import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';


class OfferBannerWidget extends StatefulWidget {
  final List<Map<String, String>> offers; // [{title, subtitle, image, buttonText}]
  const OfferBannerWidget({super.key, required this.offers});

  @override
  State<OfferBannerWidget> createState() => _OfferBannerWidgetState();
}

class _OfferBannerWidgetState extends State<OfferBannerWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppSizes.offerBannerHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemCount: widget.offers.length,
            itemBuilder: (context, index) {
              final offer = widget.offers[index];
              return _BannerCard(
                title: offer['title'] ?? '',
                subtitle: offer['subtitle'] ?? '',
                image: offer['image'] ?? '',
                buttonText: offer['buttonText'] ?? 'Shop Now',
              );
            },
          ),
        ),
        SizedBox(height: AppSizes.sm),
        // Dots indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.offers.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3),
              width: _currentPage == index ? 20 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentPage == index ? AppColors.primary : AppColors.lightDivider,
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String buttonText;

  const _BannerCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        color: const Color(0xFF1C1C2E),
        image: image.isNotEmpty
            ? DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.45),
                  BlendMode.darken,
                ),
              )
            : null,
      ),
      padding: EdgeInsets.all(AppSizes.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.headingLarge.copyWith(color: AppColors.white),
          ),
          SizedBox(height: AppSizes.xs),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.white.withOpacity(0.85)),
          ),
          SizedBox(height: AppSizes.md),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: AppSizes.lg, vertical: AppSizes.sm),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusFull),
              ),
            ),
            child: Text(buttonText, style: AppTextStyles.buttonSmall),
          ),
        ],
      ),
    );
  }
}