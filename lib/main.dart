import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stylo_app/core/services/shared_pref_service.dart';
import 'package:stylo_app/core/di/injection_container.dart';

import 'package:stylo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylo_app/features/auth/presentation/screens/splash/splash_screen.dart';
import 'package:stylo_app/core/di/injection_container.dart';
import 'package:stylo_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:stylo_app/features/profile/data/repositories/profile_repository_impl.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPrefService.init();
  setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => AuthCubit()),
            BlocProvider(
              create: (_) => ProfileCubit(sl<ProfileRepositoryImpl>()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Stylo App',
            theme: ThemeData(scaffoldBackgroundColor: Colors.white),
            home: const SplashScreen(),
          ),
        );
      },
    );
  }
}
