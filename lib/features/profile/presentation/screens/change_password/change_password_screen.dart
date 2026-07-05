import 'package:flutter/material.dart';
import 'package:stylo_app/shared/widgets/custom_profile_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color(0xffF8F6FC),

      appBar: AppBar(
        backgroundColor: const Color(0xffF8F6FC),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xff7C4DFF)),
        ),
        title: const Text(
          "Change Password",
          style: TextStyle(
            color: Color(0xff7C4DFF),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Security Update",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text(
              "Ensure your account stays secure by choosing a strong, unique password.",
              style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
            ),

            const SizedBox(height: 35),

            const CustomProfileTextField(
              label: "CURRENT PASSWORD",
              hint: "••••••••",
              icon: Icons.lock_outline,
              obscureText: true,
              suffixIcon: Icon(Icons.visibility_outlined),
            ),

            const SizedBox(height: 20),

            const CustomProfileTextField(
              label: "NEW PASSWORD",
              hint: "••••••••",
              icon: Icons.lock_outline,
              obscureText: true,
              suffixIcon: Icon(Icons.visibility_outlined),
            ),

            const SizedBox(height: 20),

            const CustomProfileTextField(
              label: "CONFIRM NEW PASSWORD",
              hint: "••••••••",
              icon: Icons.lock_outline,
              obscureText: true,
              suffixIcon: Icon(Icons.visibility_outlined),
            ),

            const SizedBox(height: 35),

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
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update Password",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.check_circle_outline, color: Colors.white),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuBvgU0wqIfrP22MP2WgGBUGFVY3CBAbjagcEK8YMSmrF0Exq0A0WMyWrUHcCU1FuakQliFgPJ5CdLF4xcNK1qauno8FfGmbZMa1fIggyPSR93RG9RhgSaapU7Sk5pKQ0KJNS_z1j7LYJYBv4AmBu5Kevtbo5ehBbxGGSNhnbypW41S7flLFTH9RLyx87I5EKWPNZ0MQa07YqD8nVP4RAYxWbwnyzrU-Het6rqeEpUJEj4QBmYQtuCUM",
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "YOUR BARIQ PROFILE IS ENCRYPTED AND PROTECTED",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
