import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAF8FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.deepPurple),
        ),
        centerTitle: true,
        title: Text(
          "Bariq",
          style: GoogleFonts.poppins(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "LEGAL DOCUMENTATION",
              style: GoogleFonts.poppins(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Privacy Policy",
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  "Last updated: June 18, 2024",
                  style: GoogleFonts.poppins(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 25),

            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.network(
                "https://lh3.googleusercontent.com/aida-public/AB6AXuAAQkXsdOYXqXX3UNLjGNnJkmNCoovVCBvfWW8j7Mitch_L1HXOY8bevCeQYv8B0UCY6Kd9pWVyKv9_ORVNsAwtdLlUcUn5ZhYm-x9ZVEB8T7o2nQf6EdMJ2a_4pjElhEz0__uyf-q-_9e0-_H3ij-vRY_PXMpJX9c9M2_8CjaSDR-C--_s4kz9JYmN7MvCzUTCcBB1wFzhBWwE4TOrw-pHTy8C1_vZQ-TT4eZ29fE7RIsO9sS9PJdk",
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 24),

            _sectionCard(
              icon: Icons.lock_outline,
              color: const Color(0xff7B61FF),
              title: "Data Collection",
              description:
                  "At Bariq, your privacy is the cornerstone of our luxury shopping experience...",
              bullets: const [
                "Personal identifiers including name, email address and shipping details.",
                "Transactional data for secure payment processing.",
                "Preference data to personalize recommendations.",
              ],
            ),

            const SizedBox(height: 18),

            _sectionCard(
              icon: Icons.auto_fix_high,
              color: Colors.amber,
              title: "How We Use Your Data",
              description:
                  "We utilize your information to provide a seamless and secure shopping experience.",
              extra: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffF5F1FF),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SERVICE FULFILLMENT",
                      style: GoogleFonts.poppins(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "Processing purchases, handling logistics and customer support.",
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "PERSONALIZATION",
                      style: GoogleFonts.poppins(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text("Tailoring our website and exclusive previews."),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            _sectionCard(
              icon: Icons.share,
              color: Colors.orange,
              title: "Third-Party Sharing",
              description:
                  "Bariq does not sell your personal data. We only share information with trusted partners required to complete your orders securely.",
            ),

            const SizedBox(height: 40),

            Center(
              child: Text(
                "Have questions regarding your privacy?",
                style: GoogleFonts.poppins(color: Colors.grey),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "CONTACT PRIVACY OFFICER",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
    List<String>? bullets,
    Widget? extra,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.08),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(.15),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(description, style: GoogleFonts.poppins(height: 1.7)),

          if (bullets != null) ...[
            const SizedBox(height: 18),
            ...bullets.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Colors.deepPurple,
                      size: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: Text(e)),
                  ],
                ),
              ),
            ),
          ],

          if (extra != null) ...[const SizedBox(height: 18), extra],
        ],
      ),
    );
  }
}
