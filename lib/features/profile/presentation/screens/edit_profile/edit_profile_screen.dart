import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/services/shared_pref_service.dart';
import 'package:stylo_app/shared/widgets/custom_profile_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/di/injection_container.dart';
import 'package:stylo_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:stylo_app/features/profile/presentation/cubit/address/address_cubit.dart';
import 'package:stylo_app/features/profile/presentation/cubit/address/address_state.dart';
import 'package:stylo_app/features/profile/presentation/screens/add_address/add_address_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
final isDark = theme.brightness == Brightness.dark;
final imagePath = SharedPrefService.getProfileImage();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final cubit = sl<ProfileCubit>();
            cubit.getCurrentUser();
            return cubit;
          },
        ),
        BlocProvider(
          create: (context) {
            final cubit = sl<AddressCubit>();
            cubit.getAddresses();
            return cubit;
          },
        ),
      ],
      child: Scaffold(
        backgroundColor:  theme.scaffoldBackgroundColor,

        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.primary,
            ),
          ),
          title: Text(
  'Edit Profile',
  style: AppTextStyles.headingSmall.copyWith(
    color: Theme.of(context).textTheme.titleLarge?.color,
  ),
),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.screenPadding),
            child: Column(
              children: [
                // ── Profile avatar ─────────────────────────────────
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
  radius: AppSizes.avatarLg / 2,
  backgroundColor: theme.colorScheme.primary.withOpacity(.12),
  backgroundImage: imagePath != null && File(imagePath).existsSync()
      ? FileImage(File(imagePath))
      : null,
  child: imagePath == null || !File(imagePath).existsSync()
      ? Icon(
          Icons.person,
          size: AppSizes.iconXl,
          color: AppColors.primary,
        )
      : null,
),
                    Container(
                      height: 28,
                      width: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: AppColors.white,
                        size: 16,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: AppSizes.sm),

                // ── Change photo button ────────────────────────────
                TextButton(
  onPressed: () async {
    final picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    await SharedPrefService.saveProfileImage(image.path);
    setState(() {
      
    });
    
    
    
  },
  child: Text(
    'CHANGE PHOTO',
    style: AppTextStyles.labelMedium.copyWith(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.w700,
      letterSpacing: 1,
    ),
  ),
),

                SizedBox(height: AppSizes.md),

                // ── Full name ──────────────────────────────────────
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileSuccess) {
                      return CustomProfileTextField(
                        label: 'FULL NAME',
                        hint: state.user.fullName,
                        icon: Icons.person_outline,
                      );
                    }

                    return const CustomProfileTextField(
                      label: 'FULL NAME',
                      hint: 'Loading...',
                      icon: Icons.person_outline,
                    );
                  },
                ),

                SizedBox(height: AppSizes.md),

                // ── Email ──────────────────────────────────────────
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileSuccess) {
                      return CustomProfileTextField(
                        label: 'EMAIL ADDRESS',
                        hint: state.user.email,
                        icon: Icons.email_outlined,
                      );
                    }

                    return const CustomProfileTextField(
                      label: 'EMAIL ADDRESS',
                      hint: 'Loading...',
                      icon: Icons.email_outlined,
                    );
                  },
                ),

                SizedBox(height: AppSizes.md),

                // ── Phone ──────────────────────────────────────────
                const CustomProfileTextField(
                  label: 'PHONE NUMBER',
                  hint: '+1 (234) 567-8901',
                  icon: Icons.phone_outlined,
                ),

                SizedBox(height: AppSizes.md),

                // ── Address ────────────────────────────────────────
                BlocBuilder<AddressCubit, AddressState>(
                  builder: (context, state) {
                    if (state is AddressSuccess && state.addresses.isNotEmpty) {
                      final address = state.addresses.first;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddAddressScreen(),
                            ),
                          );
                        },
                        child: CustomProfileTextField(
                          label: 'PRIMARY ADDRESS',
                          hint: '${address.city}, ${address.state}',
                          icon: Icons.location_on_outlined,
                          suffixIcon: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                        ),
                      );
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AddAddressScreen()),
                        );
                      },
                      child: const CustomProfileTextField(
                        label: 'PRIMARY ADDRESS',
                        hint: 'Add Address',
                        icon: Icons.location_on_outlined,
                        suffixIcon: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    );
                  },
                ),

                SizedBox(height: AppSizes.xl),

                // ── Save button ────────────────────────────────────
                SizedBox(
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: wire to ProfileCubit.updateProfile()
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.white,
                          size: 20,
                        ),
                        SizedBox(width: AppSizes.sm),
                        Text('Save Changes', style: AppTextStyles.buttonLarge),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: AppSizes.md),

                // SizedBox
                SizedBox(height: AppSizes.md),

                // ── Last updated ───────────────────────────────────
                Text(
                  'Last updated: Today, 10:45 AM',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary(context),
                  ),
                ),

                SizedBox(height: AppSizes.md),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
