import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  const CustomImageWidget({super.key,required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return   SizedBox(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                
                    '$image',),
                ),
              );
  }
}