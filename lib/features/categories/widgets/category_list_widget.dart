import 'package:flutter/material.dart';
import 'package:stylo_app/features/categories/widgets/category_card_widget.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      childAspectRatio: 1.1,
      children: [
        CategoryCard(
          title: "Rings",
          image: "assets/images/ring.png",
          icon: "assets/icons/diamond icon.svg",
        ),
        CategoryCard(
          title: "Necklaces",
          image: "assets/images/necklaces.png",
          icon: "assets/icons/ice.svg",
        ),
        CategoryCard(
          title: "Earrings",
          image: "assets/images/earrings.png",
          icon: "assets/icons/star.svg",
        ),
        CategoryCard(
          title: "Bracelets",
          image: "assets/images/bracelets.png",
          icon: "assets/icons/link.svg",
        ),
        CategoryCard(
          title: "Bags",
          image: "assets/images/bags.png",
          icon: "assets/icons/bag.svg",
        ),
        CategoryCard(
          title: "Sunglasses",
          image: "assets/images/sunglasses.png",
          icon: "assets/icons/sun.svg",
        ),
      ],
    );
  }
}
