import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/utils/app_validators.dart';
import 'package:stylo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:stylo_app/shared/widgets/custom_profile_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().changePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
          confirmNewPassword: _confirmPasswordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary),
        ),
        title: Text(
          'Change Password',
          style: AppTextStyles.headingSmall.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),

      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Password updated successfully'),
                backgroundColor: AppColors.success,
              ),
            );
            _currentPasswordController.clear();
            _newPasswordController.clear();
            _confirmPasswordController.clear();
            Navigator.pop(context);
          } else if (state is AuthError) {
            final message = state.message.replaceFirst('Exception: ', '');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return SingleChildScrollView(
            padding: EdgeInsets.all(AppSizes.screenPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSizes.md),

                  // ── Title ──────────────────────────────────────────
                  Text(
                    'Security Update',
                    style: AppTextStyles.headingLarge.copyWith(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),

                  SizedBox(height: AppSizes.sm),

                  // ── Subtitle ───────────────────────────────────────
                  Text(
                    'Ensure your account stays secure by choosing a strong, unique password.',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.color?.withOpacity(.7),
                    ),
                  ),

                  SizedBox(height: AppSizes.xl),

                  // ── Current password ───────────────────────────────
                  CustomProfileTextField(
                    label: 'CURRENT PASSWORD',
                    hint: '••••••••',
                    icon: Icons.lock_outline,
                    controller: _currentPasswordController,
                    obscureText: _obscureCurrent,
                    validator: (value) =>
                        AppValidators.required(value, fieldName: 'Current password'),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureCurrent
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => setState(
                        () => _obscureCurrent = !_obscureCurrent,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSizes.md),

                  // ── New password ───────────────────────────────────
                  CustomProfileTextField(
                    label: 'NEW PASSWORD',
                    hint: '••••••••',
                    icon: Icons.lock_outline,
                    controller: _newPasswordController,
                    obscureText: _obscureNew,
                    validator: AppValidators.password,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNew
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () =>
                          setState(() => _obscureNew = !_obscureNew),
                    ),
                  ),

                  SizedBox(height: AppSizes.md),

                  // ── Confirm new password ───────────────────────────
                  CustomProfileTextField(
                    label: 'CONFIRM NEW PASSWORD',
                    hint: '••••••••',
                    icon: Icons.lock_outline,
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirm,
                    validator: (value) => AppValidators.confirmPassword(
                      _newPasswordController.text,
                    )(value),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () => setState(
                        () => _obscureConfirm = !_obscureConfirm,
                      ),
                    ),
                  ),

                  SizedBox(height: AppSizes.xl),

                  // ── Update button ──────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: AppSizes.buttonHeight,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        disabledBackgroundColor:
                            AppColors.primary.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusLg),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.white,
                              ),
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Update Password',
                                  style: AppTextStyles.buttonLarge,
                                ),
                                SizedBox(width: AppSizes.sm),
                                const Icon(
                                  Icons.check_circle_outline,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                    ),
                  ),

                  SizedBox(height: AppSizes.xxl),

                  // ── Encrypted badge ────────────────────────────────
                  Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: AppSizes.iconXl,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(height: AppSizes.sm),
                        Text(
                          'YOUR PROFILE IS ENCRYPTED AND PROTECTED',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.caption.copyWith(
                            color: Theme.of(
                              context,
                            ).textTheme.bodySmall?.color?.withOpacity(.7),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: AppSizes.md),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
