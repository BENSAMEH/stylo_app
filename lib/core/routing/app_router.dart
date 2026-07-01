import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Auth
import '../../features/auth/presentation/screens/splash/splash_screen.dart';
import '../../features/auth/presentation/screens/onboarding/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login/login_screen.dart';
import '../../features/auth/presentation/screens/register/register_screen.dart';
import '../../features/auth/presentation/screens/otp/otp_screen.dart';
import '../../features/auth/presentation/screens/forgot_password/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/reset_password/reset_password_screen.dart';

// Home
import '../../features/home/presentation/screens/home/home_screen.dart';
import '../../features/home/presentation/screens/product_details/product_details_screen.dart';
import '../../features/home/presentation/screens/search/search_screen.dart';

// Categories
import '../../features/categories/presentation/screens/categories/categories_screen.dart';
import '../../features/categories/presentation/screens/products_by_category/products_by_category_screen.dart';

// Cart
import '../../features/cart/presentation/screens/cart/cart_screen.dart';
import '../../features/cart/presentation/screens/checkout/checkout_screen.dart';
import '../../features/cart/presentation/screens/order_success/order_success_screen.dart';
import '../../features/cart/presentation/screens/empty_cart/empty_cart_screen.dart';

// Profile
import '../../features/profile/presentation/screens/profile/profile_screen.dart';
import '../../features/profile/presentation/screens/edit_profile/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/change_password/change_password_screen.dart';
import '../../features/profile/presentation/screens/settings/settings_screen.dart';

// More
import '../../features/more/presentation/screens/about_us/about_us_screen.dart';
import '../../features/more/presentation/screens/contact_us/contact_us_screen.dart';
import '../../features/more/presentation/screens/privacy_policy/privacy_policy_screen.dart';
import '../../features/more/presentation/screens/add_product/add_product_screen.dart';
import '../../features/more/presentation/screens/empty_favorites/empty_favorites_screen.dart';
import '../../features/more/presentation/screens/no_search_results/no_search_results_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),

      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),

      GoRoute(
        path: '/otp',
        builder: (context, state) => const OtpScreen(),
      ),

      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      GoRoute(
        path: '/reset-password',
        builder: (context, state) => const ResetPasswordScreen(),
      ),

      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),

      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),

      GoRoute(
        path: '/product-details',
        builder: (context, state) => const ProductDetailsScreen(),
      ),

      GoRoute(
        path: '/categories',
        builder: (context, state) => const CategoriesScreen(),
      ),

      GoRoute(
        path: '/products-by-category',
        builder: (context, state) => const ProductsByCategoryScreen(),
      ),

      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),

      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),

      GoRoute(
        path: '/order-success',
        builder: (context, state) => const OrderSuccessScreen(),
      ),

      GoRoute(
        path: '/empty-cart',
        builder: (context, state) => const EmptyCartScreen(),
      ),

      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),

      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),

      GoRoute(
        path: '/change-password',
        builder: (context, state) => const ChangePasswordScreen(),
      ),

      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),

      GoRoute(
        path: '/about-us',
        builder: (context, state) => const AboutUsScreen(),
      ),

      GoRoute(
        path: '/contact-us',
        builder: (context, state) => const ContactUsScreen(),
      ),

      GoRoute(
        path: '/privacy-policy',
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),

      GoRoute(
        path: '/add-product',
        builder: (context, state) => const AddProductScreen(),
      ),

      GoRoute(
        path: '/empty-favorites',
        builder: (context, state) => const EmptyFavoritesScreen(),
      ),

      GoRoute(
        path: '/no-search-results',
        builder: (context, state) => const NoSearchResultsScreen(),
      ),
    ],
  );
}