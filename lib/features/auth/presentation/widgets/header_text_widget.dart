import 'package:flutter/material.dart';

class HeaderTextWidget extends StatelessWidget {
  const HeaderTextWidget({super.key,required this.headText});
final String headText;
  @override
  Widget build(BuildContext context) {
    return  Text('$headText',style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),);
  }
}