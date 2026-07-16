import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routing/navigation_cubit.dart';
import '../../../../shared/widgets/app_bottom_nav_widget.dart';
import '../../../cart/presentation/screens/cart/cart_screen.dart';
import '../../../categories/presentation/screens/categories/categories_screen.dart';
import '../../../profile/presentation/screens/profile/profile_screen.dart';
import 'home/home_screen.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(
            index: currentIndex,
            children: const [
              HomeScreen(),
              CategoriesScreen(),
              CartScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: AppBottomNavWidget(
            currentIndex: currentIndex,
            onTap: (index) {
              context.read<NavigationCubit>().setTab(index);
            },
          ),
        );
      },
    );
  }
}
