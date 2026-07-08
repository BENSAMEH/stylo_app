import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final String icon;

  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radiusXl),
        image: DecorationImage(
          image: AssetImage(image),
          fit:   BoxFit.cover,
          colorFilter: ColorFilter.mode(
            AppColors.black.withOpacity(0.25),
            BlendMode.darken,
          ),
        ),
      ),
      padding: EdgeInsets.all(AppSizes.md),
      child: Stack(
        children: [
          // Icon badge
          Align(
            alignment: Alignment.topLeft,
            child: CircleAvatar(
              backgroundColor: AppColors.white,
              radius: 20,
              child: SvgPicture.asset(
                icon,
                width:  20,
                height: 20,
                fit:    BoxFit.scaleDown,
              ),
            ),
          ),

          // Title
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: AppTextStyles.headingSmall.copyWith(
                color:      AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}