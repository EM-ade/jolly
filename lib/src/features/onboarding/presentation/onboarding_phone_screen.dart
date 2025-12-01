import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../core/common_widgets/custom_button.dart';
import '../../../core/animations/animation_widgets.dart';

class OnboardingPhoneScreen extends StatelessWidget {
  const OnboardingPhoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_bg_1.png'),
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
                  // Logo with Bounce Animation
                  Center(
                    child: ScaleBounceAnimation(
                      delay: const Duration(milliseconds: 200),
                      child: Image.asset(
                        'assets/images/onboarding_illustration.png',
                        height: 80,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Text with Staggered Animation
                  Center(
                    child: StaggeredAnimation(
                      index: 1,
                      child: const Text(
                        'PODCASTS FOR',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Futura PT', // Or fallback
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: StaggeredAnimation(
                      index: 2,
                      child: const Text(
                        'AFRICA, BY AFRICANS',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Futura PT', // Or fallback
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Phone Input
                  StaggeredAnimation(
                    index: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: const Color(0xFFA3CB43),
                          width: 2,
                        ),
                      ),
                      child: IntlPhoneField(
                        decoration: const InputDecoration(
                          hintText: 'Enter phone number',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 24),
                          counterText: '',
                        ),
                        initialCountryCode: 'NG',
                        onChanged: (phone) {
                          // Handle phone number change
                        },
                        disableLengthCheck: true,
                        dropdownIconPosition: IconPosition.trailing,
                        flagsButtonPadding: const EdgeInsets.only(left: 16),
                        showCountryFlag: true,
                        dropdownTextStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Continue Button
                  StaggeredAnimation(
                    index: 4,
                    child: CustomButton(
                      text: 'Continue',
                      onPressed: () => context.push('/onboarding/otp'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // T&C Text
                  StaggeredAnimation(
                    index: 5,
                    child: const Center(
                      child: Text(
                        'By proceeding, you agree and accept our T&C',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login Link
                  StaggeredAnimation(
                    index: 6,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => context.go('/login'),
                        child: const Text(
                          'Already have an account? Login',
                          style: TextStyle(
                            color: Color(0xFFA3CB43),
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Become a Creator
                  StaggeredAnimation(
                    index: 7,
                    child: const Center(
                      child: Text(
                        'BECOME A PODCAST CREATOR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
