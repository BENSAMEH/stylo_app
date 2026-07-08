import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stylo_app/features/auth/presentation/screens/splash/splash_screen.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Wrap your MaterialApp with ScreenUtilInit
    return ScreenUtilInit(
      // Set the design size according to your UI/Figma design framework (e.g., 360x690, 375x812, etc.)
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode:
          true, // 2. Pass your MaterialApp structure inside the builder method
      builder: (context, child) {
        return MaterialApp(
          title: 'Stylo App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor:
                Colors.white, // Adjust template rules as needed
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
