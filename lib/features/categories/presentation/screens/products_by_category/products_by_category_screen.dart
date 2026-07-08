import 'package:flutter/material.dart';
import 'package:stylo_app/features/categories/widgets/category_card_widget.dart';
import 'package:stylo_app/features/categories/widgets/category_header_widget.dart';
import 'package:stylo_app/features/categories/widgets/category_list_widget.dart';
import 'package:stylo_app/features/categories/widgets/collections_item_widget.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F7FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CategoryHeaderWidget(),
              SizedBox(height: 20),
              Text(
                "CURATION",
                style: TextStyle(
                  color: Color(0xFF6C4FD6),
                  fontSize: 12,
                  letterSpacing: 1,
                ),
              ),

              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF6C4FD6), width: 3),
                  ),
                ),
                child: Text(
                  "Browse Categories",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20),
              CategoryListWidget(),
              SizedBox(height: 15),
              SizedBox(
                height: 150,
                width: double.infinity,
                child: CategoryCard(
                  title: "Watches",
                  image: "assets/images/watches.png",
                  icon: "assets/icons/watch.svg",
                ),
              ),
              SizedBox(height: 25),
              CollectionsItemWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
