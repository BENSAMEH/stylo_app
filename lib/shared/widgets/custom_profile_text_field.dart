import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  const CustomProfileTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.controller,
    this.readOnly = false,
    this.suffixIcon,
    this.obscureText = false,
  });

  final String label;
  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool readOnly;
  final Widget? suffixIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: const BorderSide(color: Color(0xff7C4DFF)),
            ),
          ),
        ),
      ],
    );
  }
}
