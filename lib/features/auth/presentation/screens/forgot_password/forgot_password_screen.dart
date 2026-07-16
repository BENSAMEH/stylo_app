import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:stylo_app/core/constants/app_colors.dart';
import 'package:stylo_app/core/utils/app_validators.dart';

import 'package:stylo_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:stylo_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:stylo_app/features/auth/presentation/screens/otp/otp_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const purple = Color(0xFF6C35F5);

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void back(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  void _sendOtp() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthCubit>().forgotPassword(
          email: _emailController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(
                email: _emailController.text.trim(),
                isForPasswordReset: true,
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
        final isDark = AppColors.isDark(context);

        return Scaffold(
          backgroundColor: AppColors.background(context),
          appBar: AppBar(
            backgroundColor: AppColors.background(context),
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => back(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: ForgotPasswordScreen.purple,
                size: 20,
              ),
            ),
            title: Text(
              'Forgot Password',
              style: TextStyle(
                color: AppColors.textPrimary(context),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 26),
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                        color: isDark
                            ? ForgotPasswordScreen.purple
                                .withOpacity(0.18)
                            : const Color(0xFFEDEAF1),
                        borderRadius:
                            BorderRadius.circular(28),
                      ),
                      child: const Icon(
                        Icons.lock_reset,
                        size: 42,
                        color: ForgotPasswordScreen.purple,
                      ),
                    ),

                    const SizedBox(height: 30),

                    Text(
                      'Reset Access',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary(context),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Enter your registered email below\n'
                      'to receive a secure password reset\n'
                      'link.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary(context),
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 38),

                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surface(context),
                        borderRadius:
                            BorderRadius.circular(26),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple
                                .withOpacity(isDark ? 0.15 : 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email Address',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary(context),
                            ),
                          ),

                          const SizedBox(height: 10),

                          TextFormField(
                            controller:
                                _emailController,
                            validator:
                                AppValidators.email,
                            keyboardType:
                                TextInputType
                                    .emailAddress,
                            autovalidateMode:
                                AutovalidateMode
                                    .onUserInteraction,
                            style: TextStyle(
                              color: AppColors.textPrimary(context),
                            ),
                            decoration:
                                InputDecoration(
                              hintText:
                                  'name@example.com',
                              hintStyle: TextStyle(
                                color: AppColors.textSecondary(context),
                              ),
                              prefixIcon: Icon(
                                Icons.mail_outline,
                                color: AppColors.textSecondary(context),
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? AppColors.background(context)
                                  : const Color(0xFFF8F0FF),
                              border:
                                  OutlineInputBorder(
                                borderRadius:
                                    BorderRadius
                                        .circular(6),
                                borderSide:
                                    BorderSide.none,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),

                                              SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed:
                                  isLoading ? null : _sendOtp,
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    ForgotPasswordScreen
                                        .purple,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(18),
                                ),
                              ),
                              child: isLoading
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child:
                                          CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Text(
                                      'Send OTP  →',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight:
                                            FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    GestureDetector(
                      onTap: () => back(context),
                      child: const Text(
                        '‹ Back to Login',
                        style: TextStyle(
                          color:
                              ForgotPasswordScreen.purple,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    Divider(color: AppColors.divider(context)),

                    const SizedBox(height: 14),

                    Text(
                      'PREMIUM SECURITY GUARANTEED',
                      style: TextStyle(
                        fontSize: 10,
                        letterSpacing: 1.5,
                        color: AppColors.textSecondary(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 28),
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
