import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/common_widgets/custom_button.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/animations/animation_widgets.dart';

class OnboardingOtpScreen extends StatelessWidget {
  const OnboardingOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_bg_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  // Small Jolly Logo
                  ScaleBounceAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: Image.asset(
                      'assets/images/onboarding_illustration.png',
                      height: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                  StaggeredAnimation(
                    index: 1,
                    child: const Text(
                      'Enter the 6 digit code sent to your phone number +234 80...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // OTP Input (CustomTextField)
                  const StaggeredAnimation(
                    index: 2,
                    child: CustomTextField(
                      hintText: 'Enter 6-digit code',
                      keyboardType: TextInputType.number,
                      height: 65,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Continue Button
                  StaggeredAnimation(
                    index: 3,
                    child: CustomButton(
                      text: 'Continue',
                      onPressed: () => context.push('/onboarding/profile'),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
