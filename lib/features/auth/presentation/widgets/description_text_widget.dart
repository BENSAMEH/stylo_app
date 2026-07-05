import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatelessWidget {
   DescriptionTextWidget({super.key,required this.descTextEnjoy,required this.descTextSeam, this.descTextBariq});
 final String descTextEnjoy;
  final String descTextSeam;
 final String? descTextBariq;
  @override
  Widget build(BuildContext context) {
    return  Column(
              children: [
                SizedBox(height: 16,),
                Text('$descTextEnjoy',style: TextStyle(
                  fontSize: 10
                ),),
                  Text('$descTextSeam',style: TextStyle(
                  fontSize: 10
                ),),
                     Text('$descTextBariq',style: TextStyle(
                  fontSize: 10
                ),),
              ],
            );
  }
}