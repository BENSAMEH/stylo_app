import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF5A35F2);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
        ),
        title: const Text(
          "Bariq",
          style: TextStyle(color: primary, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.shopping_bag_outlined, color: primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Concierge & Support",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "Our dedicated team is here to assist you with bespoke requests, order tracking, and high-end jewelry consultations.",
              style: TextStyle(color: Colors.grey.shade600, height: 1.5),
            ),
            const SizedBox(height: 24),

            Row(
              children: const [
                Expanded(
                  child: ContactCard(
                    icon: Icons.email_outlined,
                    title: "Email Us",
                    subtitle: "concierge@bariq.luxury",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ContactCard(
                    icon: Icons.call_outlined,
                    title: "Call Us",
                    subtitle: "+1 (800) BARIQ-LUX",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            const CustomTextField(label: "FULL NAME", hint: "Julian Vane"),

            const SizedBox(height: 18),

            const CustomTextField(
              label: "EMAIL ADDRESS",
              hint: "julian@example.com",
            ),

            const SizedBox(height: 18),

            const DropdownField(),

            const SizedBox(height: 18),

            const CustomTextField(
              label: "MESSAGE",
              hint: "Describe your request in detail...",
              maxLines: 5,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Checkbox(value: false, onChanged: (_) {}),
                const Expanded(
                  child: Text(
                    "I agree to the privacy policy and terms of service.",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Send Message ➤",
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xffF4F2FF),
            child: Icon(icon, color: Color(0xFF5A35F2)),
          ),
          SizedBox(height: 12),
          Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xffFAF8FF),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
      ],
    );
  }
}

class DropdownField extends StatelessWidget {
  const DropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "SUBJECT",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: "Bespoke Design Inquiry",
          items: const [
            DropdownMenuItem(
              value: "Bespoke Design Inquiry",
              child: Text("Bespoke Design Inquiry"),
            ),
            DropdownMenuItem(
              value: "Order Tracking",
              child: Text("Order Tracking"),
            ),
            DropdownMenuItem(value: "Support", child: Text("Support")),
          ],
          onChanged: (v) {},
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xffFAF8FF),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
