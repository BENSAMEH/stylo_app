import 'package:flutter/material.dart';
import 'package:stylo_app/shared/widgets/custom_profile_text_field.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC9C4D9),

      appBar: AppBar(
        backgroundColor: const Color(0xffC9C4D9),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff7C4DFF)),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// Profile Image
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.person, size: 50),
                  ),

                  Container(
                    height: 28,
                    width: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xff7C4DFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "CHANGE PHOTO",
                  style: TextStyle(
                    color: Color(0xff7C4DFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const CustomProfileTextField(
                label: "FULL NAME",
                hint: "Julian Alexander",
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 18),

              const CustomProfileTextField(
                label: "EMAIL ADDRESS",
                hint: "julian.alex@bariq.luxury",
                icon: Icons.email_outlined,
              ),

              const SizedBox(height: 18),

              const CustomProfileTextField(
                label: "PHONE NUMBER",
                hint: "+1 (234) 567-8901",
                icon: Icons.phone_outlined,
              ),

              const SizedBox(height: 18),

              const CustomProfileTextField(
                label: "PRIMARY ADDRESS",
                hint: "Penthouse 4B, Sky Towers",
                icon: Icons.location_on_outlined,
                suffixIcon: Icon(Icons.arrow_forward_ios, size: 16),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff7C4DFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "Save Changes",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Text(
                "Last updated: Today, 10:45 AM",
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
