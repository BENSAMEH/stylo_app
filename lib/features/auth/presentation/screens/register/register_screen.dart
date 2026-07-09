import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';
import 'package:stylo_app/core/constants/app_text_styles.dart';
import 'package:stylo_app/core/utils/app_validators.dart';

import 'package:stylo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:stylo_app/features/auth/presentation/screens/otp/otp_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _agree = false;
  bool _hidePass = true;
  bool _hideConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onRegister() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    if (!_agree) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('Please agree to the Terms & Conditions'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final names = _nameController.text.trim().split(' ');

    final firstName = names.first;

    final lastName =
        names.length > 1 ? names.sublist(1).join(' ') : '';

    context.read<AuthCubit>().register(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          firstName: firstName,
          lastName: lastName,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(
                email: _emailController.text.trim(),
              ),
            ),
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        return Scaffold(
          backgroundColor: AppColors.lightBackground,
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizes.screenPadding,
                ),
                child: Column(
                  children: [
                    SizedBox(height: AppSizes.xl),

                    Text(
                      'Stylo',
                      style:
                          AppTextStyles.displayMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),

                    SizedBox(height: AppSizes.xl),

                    Text(
                      'Create Account',
                      style: AppTextStyles.headingLarge,
                    ),

                    SizedBox(height: AppSizes.sm),

                    Text(
                      'Create your stylo account and start\n'
                      'your luxury shopping experience.',
                      textAlign: TextAlign.center,
                      style:
                          AppTextStyles.bodyMedium.copyWith(
                        color:
                            AppColors.lightTextSecondary,
                      ),
                    ),

                    SizedBox(height: AppSizes.lg),

                    _AuthTextField(
                      controller: _nameController,
                      hint: 'Full Name',
                      icon: Icons.person_outline,
                      validator: AppValidators.name,
                    ),

                    SizedBox(height: AppSizes.sm),

                    _AuthTextField(
                      controller: _emailController,
                      hint: 'Email Address',
                      icon: Icons.mail_outline,
                      keyboardType:
                          TextInputType.emailAddress,
                      validator: AppValidators.email,
                    ),

                    SizedBox(height: AppSizes.sm),

                    _AuthTextField(
                      controller: _passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline,
                      obscure: _hidePass,
                      validator: AppValidators.password,
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePass = !_hidePass;
                          });
                        },
                        icon: Icon(
                          _hidePass
                              ? Icons.visibility_outlined
                              : Icons
                                  .visibility_off_outlined,
                          color:
                              AppColors.lightTextSecondary,
                        ),
                      ),
                    ),

                    SizedBox(height: AppSizes.sm),

                    _AuthTextField(
                      controller: _confirmController,
                      hint: 'Confirm Password',
                      icon: Icons.lock_outline,
                      obscure: _hideConfirm,
                      validator:
                          AppValidators.confirmPassword(
                        _passwordController.text,
                      ),
                      suffix: IconButton(
                        onPressed: () {
                          setState(() {
                            _hideConfirm =
                                !_hideConfirm;
                          });
                        },
                        icon: Icon(
                          _hideConfirm
                              ? Icons.visibility_outlined
                              : Icons
                                  .visibility_off_outlined,
                          color:
                              AppColors.lightTextSecondary,
                        ),
                      ),
                    ),

                    SizedBox(height: AppSizes.sm),

                    Row(
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: Checkbox(
                            value: _agree,
                            activeColor:
                                AppColors.primary,
                            shape: const CircleBorder(),
                            onChanged: (value) {
                              setState(() {
                                _agree =
                                    value ?? false;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: AppSizes.sm),
                        Text(
                          'I agree to the ',
                          style:
                              AppTextStyles.bodySmall,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Terms & Conditions',
                            style: AppTextStyles
                                .bodySmall
                                .copyWith(
                              color:
                                  AppColors.primary,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSizes.md),

                    SizedBox(
                      width: double.infinity,
                      height: AppSizes.buttonHeight,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : _onRegister,
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              AppColors.primary,
                          disabledBackgroundColor:
                              AppColors.primary
                                  .withOpacity(0.6),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              AppSizes.radiusLg,
                            ),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child:
                                    CircularProgressIndicator(
                                  color:
                                      AppColors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Create Account',
                                style: AppTextStyles
                                    .buttonLarge,
                              ),
                      ),
                    ),

                    SizedBox(height: AppSizes.lg),

                // ── OR divider ────────────────────────────────────
                                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.sm,
                          ),
                          child: Text(
                            'OR CONTINUE WITH',
                            style:
                                AppTextStyles.caption.copyWith(
                              color:
                                  AppColors.lightTextSecondary,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),

                    SizedBox(height: AppSizes.md),

                    Row(
                      children: [
                        _SocialButton(
                          child: const Icon(
                            Icons.g_mobiledata,
                            size: 40,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(width: AppSizes.sm),
                        _SocialButton(
                          child: const Icon(
                            Icons.apple,
                            size: 30,
                            color: AppColors.black,
                          ),
                        ),
                        SizedBox(width: AppSizes.sm),
                        _SocialButton(
                          child: const Icon(
                            Icons.facebook,
                            size: 30,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSizes.xl),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style:
                              AppTextStyles.bodySmall.copyWith(
                            color:
                                AppColors.lightTextSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Text(
                            'Login',
                            style: AppTextStyles.bodySmall
                                .copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: AppSizes.lg),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final bool obscure;
  final Widget? suffix;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _AuthTextField({
    required this.controller,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.suffix,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      autovalidateMode:
          AutovalidateMode.onUserInteraction,
      style: AppTextStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightTextSecondary,
        ),
        prefixIcon: Icon(
          icon,
          color: AppColors.lightTextSecondary,
        ),
        suffixIcon: suffix,
        filled: true,
        fillColor: AppColors.lightSurface,
        contentPadding:
            EdgeInsets.symmetric(vertical: AppSizes.md),
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSizes.radiusLg),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSizes.radiusLg),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSizes.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSizes.radiusLg),
          borderSide:
              const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppSizes.radiusLg),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Widget child;

  const _SocialButton({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: AppSizes.buttonHeight,
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius:
              BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.07),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}