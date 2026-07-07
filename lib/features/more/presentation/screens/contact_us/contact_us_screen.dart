import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  bool _agreePolicy = false;
  String _selectedSubject = 'Bespoke Design Inquiry';

  final List<String> _subjects = [
    'Bespoke Design Inquiry',
    'Order Tracking',
    'Support',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      appBar: AppBar(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: Text(
          'Stylo',
          style: AppTextStyles.headingMedium.copyWith(color: AppColors.primary),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.md),
            child: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Title ──────────────────────────────────────────
            Text('Concierge & Support', style: AppTextStyles.headingLarge),
            SizedBox(height: AppSizes.sm),
            Text(
              'Our dedicated team is here to assist you with bespoke requests, order tracking, and high-end jewelry consultations.',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightTextSecondary,
                height: 1.5,
              ),
            ),

            SizedBox(height: AppSizes.lg),

            // ── Contact cards ──────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _ContactCard(
                    icon:     Icons.email_outlined,
                    title:    'Email Us',
                    subtitle: 'concierge@stylo.luxury',
                  ),
                ),
                SizedBox(width: AppSizes.md),
                Expanded(
                  child: _ContactCard(
                    icon:     Icons.call_outlined,
                    title:    'Call Us',
                    subtitle: '+1 (800) STYLO-LUX',
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.xl),

            // ── Full name ──────────────────────────────────────
            _ContactTextField(label: 'FULL NAME', hint: 'Julian Vane'),
            SizedBox(height: AppSizes.md),

            // ── Email ──────────────────────────────────────────
            _ContactTextField(label: 'EMAIL ADDRESS', hint: 'julian@example.com'),
            SizedBox(height: AppSizes.md),

            // ── Subject dropdown ───────────────────────────────
            _ContactDropdown(
              value:     _selectedSubject,
              items:     _subjects,
              onChanged: (v) => setState(() => _selectedSubject = v ?? _selectedSubject),
            ),
            SizedBox(height: AppSizes.md),

            // ── Message ────────────────────────────────────────
            _ContactTextField(
              label:    'MESSAGE',
              hint:     'Describe your request in detail...',
              maxLines: 5,
            ),

            SizedBox(height: AppSizes.sm),

            // ── Privacy checkbox ───────────────────────────────
            Row(
              children: [
                Checkbox(
                  value:       _agreePolicy,
                  activeColor: AppColors.primary,
                  onChanged:   (v) => setState(() => _agreePolicy = v ?? false),
                ),
                Expanded(
                  child: Text(
                    'I agree to the privacy policy and terms of service.',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: AppSizes.lg),

            // ── Send button ────────────────────────────────────
            SizedBox(
              width:  double.infinity,
              height: AppSizes.buttonHeight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusFull),
                  ),
                ),
                child: Text('Send Message ➤', style: AppTextStyles.buttonLarge),
              ),
            ),

            SizedBox(height: AppSizes.lg),
          ],
        ),
      ),
    );
  }
}

// ── Contact card ─────────────────────────────────────────────────────────────
class _ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        boxShadow: [
          BoxShadow(
            color:      AppColors.black.withOpacity(0.07),
            blurRadius: 10,
            offset:     const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius:          24,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(icon, color: AppColors.primary),
          ),
          SizedBox(height: AppSizes.sm),
          Text(title, style: AppTextStyles.labelMedium.copyWith(
            color: AppColors.lightTextPrimary,
            fontWeight: FontWeight.w700,
          )),
          SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Contact text field ────────────────────────────────────────────────────────
class _ContactTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;

  const _ContactTextField({
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
          style: AppTextStyles.caption.copyWith(
            color:         AppColors.lightTextSecondary,
            fontWeight:    FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: AppSizes.xs),
        TextField(
          maxLines: maxLines,
          style:    AppTextStyles.bodyMedium,
          decoration: InputDecoration(
            hintText:  hint,
            hintStyle: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightTextSecondary.withOpacity(0.6),
            ),
            filled:    true,
            fillColor: AppColors.primary.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide:   BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide:   BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
              borderSide:   const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Contact dropdown ──────────────────────────────────────────────────────────
class _ContactDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final void Function(String?) onChanged;

  const _ContactDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SUBJECT',
          style: AppTextStyles.caption.copyWith(
            color:         AppColors.lightTextSecondary,
            fontWeight:    FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: AppSizes.xs),
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
          decoration: BoxDecoration(
            color:        AppColors.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value:         value,
              isExpanded:    true,
              style:         AppTextStyles.bodyMedium,
              dropdownColor: AppColors.lightSurface,
              borderRadius:  BorderRadius.circular(AppSizes.radiusMd),
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.lightTextSecondary),
              items: items
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item, style: AppTextStyles.bodyMedium),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}