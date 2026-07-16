import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/theme/theme_cubit.dart';
import 'package:stylo_app/features/auth/presentation/screens/login/login_screen.dart';

import 'package:stylo_app/features/more/presentation/screens/about_us/about_us_screen.dart';
import 'package:stylo_app/features/more/presentation/screens/add_product/add_product_screen.dart';
import 'package:stylo_app/features/more/presentation/screens/contact_us/contact_us_screen.dart';
import 'package:stylo_app/features/more/presentation/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:stylo_app/features/profile/presentation/screens/change_password/change_password_screen.dart';
import 'package:stylo_app/features/profile/presentation/screens/edit_profile/edit_profile_screen.dart';

import 'package:stylo_app/shared/widgets/profile_item.dart';
import 'package:stylo_app/shared/widgets/section_title.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool darkMode = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,

        title: Row(
          children: [
            CircleAvatar(radius: 20, child: Icon(Icons.person, size: 25)),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "Stylo",
                style: AppTextStyles.headingMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile
            const SectionTitle(title: "Profile"),

            ProfileItem(
              icon: Icons.person_outline,
              title: "Edit Profile",
              subtitle: "Update your personal details",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.lock_outline,
              title: "Change Password",
              subtitle: "Secure your account",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(),
                  ),
                );
              },
            ),

            /// App Settings
            const SectionTitle(title: "App Settings"),

            ProfileItem(
              icon: Icons.language,
              title: "Language",
              subtitle: "English (US)",
              onTap: () {},
            ),

            const SizedBox(height: 12),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return ProfileItem(
                  icon: Icons.dark_mode_outlined,
                  title: "Dark Mode",
                  subtitle: "Switch to dark theme",

                  trailing: Switch(
                    value: themeMode == ThemeMode.dark,

                    onChanged: (value) {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.notifications_none,
              title: "Notifications",
              subtitle: "Enabled",
              trailing: Switch(
                value: notifications,
                onChanged: (value) {
                  setState(() {
                    notifications = value;
                  });
                },
              ),
            ),

            /// Support
            const SectionTitle(title: "Support"),

            ProfileItem(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy Policy",
              subtitle: "Data and usage terms",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivacyPolicyScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.info_outline,
              title: "About Us",
              subtitle: "The Stylo story",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsScreen()),
                );
              },
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.headset_mic_outlined,
              title: "Contact Us",
              subtitle: "Get premium support",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsScreen()),
                );
              },
            ),

            /// Admin Panel
            const SectionTitle(title: "Admin Panel"),

            ProfileItem(
              icon: Icons.add_box_outlined,
              title: "Add Product",
              subtitle: "Create new jewelry items",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductScreen()),
                );
              },
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.deepPurple, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text("Sign Out", style: TextStyle(fontSize: 20)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
