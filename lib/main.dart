import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:stylo_app/core/di/injection_container.dart';
import 'package:stylo_app/core/services/shared_pref_service.dart';
import 'package:stylo_app/core/theme/app_theme.dart';
import 'package:stylo_app/core/theme/theme_cubit.dart';
import 'package:stylo_app/core/routing/navigation_cubit.dart';

import 'package:stylo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylo_app/features/auth/presentation/screens/splash/splash_screen.dart';

import 'package:stylo_app/features/cart/data/repositories/cart_repository.dart';
import 'package:stylo_app/features/cart/data/repositories/checkout_repository.dart';
import 'package:stylo_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:stylo_app/features/cart/presentation/cubit/checkout_cubit.dart';

import 'package:stylo_app/features/home/presentation/cubit/home_cubit.dart';

import 'package:stylo_app/features/more/presentation/cubit/add_product_cubit.dart';
import 'package:stylo_app/features/more/repositories/add_product_repository.dart';

import 'package:stylo_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:stylo_app/features/profile/presentation/cubit/profile_cubit.dart';

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
      builder: (_, __) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => ThemeCubit()),
            BlocProvider(create: (_) => NavigationCubit()),

            BlocProvider(create: (_) => AuthCubit()),

            BlocProvider(
              create: (_) => ProfileCubit(
                sl<ProfileRepositoryImpl>(),
              ),
            ),

            BlocProvider(
              create: (_) => sl<HomeCubit>()..loadHome(),
            ),

            BlocProvider(
              create: (_) => AddProductCubit(
                AddProductRepository(),
              ),
            ),

            BlocProvider(
              create: (_) => CartCubit(
                CartRepository(),
              ),
            ),

            BlocProvider(
              create: (_) => CheckoutCubit(
                CheckoutRepository(),
              ),
            ),
          ],
          child: BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Stylo App',

                theme: AppTheme.lightTheme,

                darkTheme: AppTheme.darkTheme,

                themeMode: themeMode,

                home: const SplashScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
