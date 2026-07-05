import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const purple = Color(0xFF6C35F5);

  bool agree = false;
  bool hidePass = true;
  bool hideConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF5FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: [
              const SizedBox(height: 35),

              const Text(
                'Staylo',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: purple,
                ),
              ),

              const SizedBox(height: 35),

              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Create your stylo account and start\nyour luxury shopping experience.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 28),

              textField(
                hint: 'Full Name',
                icon: Icons.person_outline,
              ),

              const SizedBox(height: 14),

              textField(
                hint: 'Email Address',
                icon: Icons.mail_outline,
              ),

              const SizedBox(height: 14),

              textField(
                hint: 'Password',
                icon: Icons.lock_outline,
                obscure: hidePass,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePass = !hidePass;
                    });
                  },
                  icon: const Icon(Icons.visibility_outlined),
                ),
              ),

              const SizedBox(height: 14),

              textField(
                hint: 'Confirm Password',
                icon: Icons.lock_outline,
                obscure: hideConfirm,
                suffix: IconButton(
                  onPressed: () {
                    setState(() {
                      hideConfirm = !hideConfirm;
                    });
                  },
                  icon: const Icon(Icons.visibility_outlined),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: Checkbox(
                      value: agree,
                      activeColor: purple,
                      shape: const CircleBorder(),
                      onChanged: (value) {
                        setState(() {
                          agree = value ?? false;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'I agree to the ',
                    style: TextStyle(fontSize: 13),
                  ),
                  const Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: 13,
                      color: purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR CONTINUE WITH',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  socialButton(
                    const Icon(
                      Icons.g_mobiledata,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 14),
                  socialButton(
                    const Icon(
                      Icons.apple,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 14),
                  socialButton(
                    const Icon(
                      Icons.facebook,
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 13),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 13,
                        color: purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  static Widget textField({
    required String hint,
    required IconData icon,
    bool obscure = false,
    Widget? suffix,
  }) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        suffixIcon: suffix,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 17),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static Widget socialButton(Widget child) {
    return Expanded(
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: child),
      ),
    );
  }
}