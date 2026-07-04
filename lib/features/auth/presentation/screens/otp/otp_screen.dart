






import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';



class OtpVerification extends StatefulWidget {
   OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  late TextEditingController pinCodeController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pinCodeController = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      
      body:
      
      Stack(
        children: [
          Container(
              width: double.infinity,
              height: double.infinity,
              decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Image.svg'),
            fit: BoxFit.cover,
          ),
              ), 
           child:Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22,),
            child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text('Stylo',style: AppTextStyles.price.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff542AE6),
                ),
                ),
                SizedBox(height: 40,),
               Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Verification Code',style: AppTextStyles.displayMedium.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff1C1A24),
                  )),
                   SizedBox(height: 10,),
                     Text(' Enter the code sent to your email.',style: AppTextStyles.headingLarge.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff484556),
                     )),
                  SizedBox(height: 10,),
                ],
               ),
                SizedBox(height: 10,),
                PinCodeTextField(
                 appContext: context,
                      length: 4,
                      controller: pinCodeController,
                      obscureText: false,
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      textStyle:
                          AppTextStyles.price.copyWith(fontSize: 22,color: Color(0xff617AFD),),
                      pinTheme: PinTheme(
                        borderRadius: BorderRadius.circular(50), 
                        fieldWidth: 70,
                        fieldHeight: 60,
                        shape: PinCodeFieldShape.box,
                      //  borderRadius: BorderRadius.circular(8),
                        selectedColor: AppColors.primary,
                        selectedFillColor: AppColors.lightSurface,
                        activeColor: AppColors.primary,
                        activeFillColor: AppColors.lightSurface,
                        inactiveColor: AppColors.lightSurface,
                        inactiveFillColor: AppColors.lightTextSecondary,
                        borderWidth: 1,
                      ),
                   ),
          //AppStyles.black15BoldStyle
                   SizedBox(height: 30,),
                    Center(
                      child: RichText(
                          text: TextSpan(
                            text: "Didn’t received code? ",
                            style: AppTextStyles.headingLarge.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff484556),
                     ),
                                
                            children: [
                              TextSpan(
                                  text: "Resend Code", style:AppTextStyles.price.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff542AE6),
                     )),
                            ],
                          ),
                        ),
                    ),
                    SizedBox(height: 80,),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        child: Container(
                          width: 350,
                          height: 56,
                         decoration: BoxDecoration(
                           color: Color(0xff542AE6),
                           borderRadius: BorderRadius.circular(50),
                         ),
                         child: Center(child: Text('Verify',style: AppTextStyles.buttonLarge.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xffFFFFFF),
                         ),)),
                        ),
                      ),
                    ),
              ],
            ),
          ),
              ),
        ],
      ),
    );
  }
}