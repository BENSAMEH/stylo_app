

import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/auth/presentation/screens/otp/otp_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 6), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  OtpVerification(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
backgroundColor: const Color(0xFFF5ECFF),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Spacer(),
          Text(
            
            'STYLO',style: AppTextStyles.price.copyWith(
              fontSize: 69,
              fontWeight: FontWeight.w700,
              color: Color(0xff542AE6),
            )),
     Spacer(),
          Column(
            children: [
               Center(
             child: Text(
             
              'WHERE  ELEGANCE  MEETS',
              
              style: AppTextStyles.price.copyWith(
                fontSize: 13,
                color: Color(0xff542AE6),
                fontWeight: FontWeight.w700,
              )),
           ),
           Text(
             
              ' ELEGANCE ',
              
              style: AppTextStyles.price.copyWith(
                fontSize: 13,
                color: Color(0xff542AE6),
                fontWeight: FontWeight.w700,
              )),
            ],
          ),
         Spacer()
        ],
      ),
    );
  }
}

