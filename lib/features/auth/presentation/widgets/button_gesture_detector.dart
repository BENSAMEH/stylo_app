import 'package:flutter/material.dart';


class GestureDetectorWidget extends StatelessWidget {
  const GestureDetectorWidget({super.key,required this.icons,required this.textButton,required this.onTap});
final String textButton;
final IconData icons;
final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
            onTap: onTap,
             child: Container(
              width: 350,
              height: 56,
              decoration: BoxDecoration(
                 color: Color(0xff542AE6),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$textButton',style: TextStyle(
                    color: Colors.white,
                  ),),
                  Icon(icons,color: Colors.white,size: 16,),
                ],
              ),
             ),
           );
  }
}