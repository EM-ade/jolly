import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/common_widgets/custom_button.dart';
import '../../../core/common_widgets/custom_text_field.dart';
import '../../../core/animations/animation_widgets.dart';

class OnboardingProfileScreen extends StatelessWidget {
  const OnboardingProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/onboarding_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight:
                        MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        // Illustration
                        ScaleBounceAnimation(
                          delay: const Duration(milliseconds: 100),
                          child: Image.asset(
                            'assets/images/onboarding_illustration.png',
                            height: 60,
                          ),
                        ),
                        const SizedBox(height: 20),
                        StaggeredAnimation(
                          index: 1,
                          child: const Text(
                            'Complete account setup',
                            style: TextStyle(
                              fontFamily: 'Futura PT',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // First Name & Last Name
                        StaggeredAnimation(
                          index: 2,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: 'First Name',
                                  backgroundColor: const Color(0xFF383838),
                                  borderColor: Colors.white,
                                  textColor: Colors.white,
                                  height: 60,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: 'Last Name',
                                  backgroundColor: const Color(0xFF383838),
                                  borderColor: Colors.white,
                                  textColor: Colors.white,
                                  height: 60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Phone Number & Email
                        StaggeredAnimation(
                          index: 3,
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  label: 'Phone Number',
                                  keyboardType: TextInputType.phone,
                                  backgroundColor: const Color(0xFF383838),
                                  borderColor: Colors.white,
                                  textColor: Colors.white,
                                  height: 60,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomTextField(
                                  label: 'Email Address',
                                  keyboardType: TextInputType.emailAddress,
                                  backgroundColor: const Color(0xFF383838),
                                  borderColor: Colors.white,
                                  textColor: Colors.white,
                                  height: 60,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Password
                        const StaggeredAnimation(
                          index: 4,
                          child: CustomTextField(
                            label: 'Create Password',
                            obscureText: true,
                            showPasswordToggle: true,
                            backgroundColor: const Color(0xFF383838),
                            borderColor: Colors.white,
                            textColor: Colors.white,
                            height: 60,
                          ),
                        ),
                        const Spacer(),
                        // Continue Button
                        StaggeredAnimation(
                          index: 5,
                          child: CustomButton(
                            text: 'Continue',
                            onPressed: () =>
                                context.push('/onboarding/personalization'),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
