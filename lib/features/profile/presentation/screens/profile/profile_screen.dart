import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/features/home/presentation/screens/home/home_screen.dart';
import 'package:stylo_app/shared/widgets/app_bottom_nav_widget.dart';
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
    return Scaffold(bottomNavigationBar: AppBottomNavWidget(
  currentIndex: 3,
  onTap: (index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
        );
        break;

      case 3:
        break;
    }
  },
),
      backgroundColor: Color(0xffFDF8FF),
      appBar: AppBar(
        backgroundColor: Color(0xffFDF8FF),

        title: Row(
          children: [
             CircleAvatar(radius: 20, child: Icon(Icons.person, size: 25)),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child:  Text(
                "Stylo",
                style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
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
              onTap: () {},
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.lock_outline,
              title: "Change Password",
              subtitle: "Secure your account",
              onTap: () {},
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

            ProfileItem(
              icon: Icons.dark_mode_outlined,
              title: "Dark Mode",
              subtitle: "Switch to dark theme",
              trailing: Switch(
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });
                },
              ),
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
              onTap: () {},
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.info_outline,
              title: "About Us",
              subtitle: "The Bariq story",
              onTap: () {},
            ),

            const SizedBox(height: 12),

            ProfileItem(
              icon: Icons.headset_mic_outlined,
              title: "Contact Us",
              subtitle: "Get premium support",
              onTap: () {},
            ),

            /// Admin Panel
            const SectionTitle(title: "Admin Panel"),

            ProfileItem(
              icon: Icons.add_box_outlined,
              title: "Add Product",
              subtitle: "Create new jewelry items",
              onTap: () {},
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2, // سمك البوردر
                  ),
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
