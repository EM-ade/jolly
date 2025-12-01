import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/common_widgets/custom_button.dart';
import '../../../core/animations/animation_widgets.dart';

class OnboardingAvatarScreen extends StatefulWidget {
  const OnboardingAvatarScreen({super.key});

  @override
  State<OnboardingAvatarScreen> createState() => _OnboardingAvatarScreenState();
}

class _OnboardingAvatarScreenState extends State<OnboardingAvatarScreen> {
  int selectedIndex = -1;

  // List of avatar SVG file names
  final List<String> avatarFiles = [
    'avatar.svg',
    'avatar-svgrepo-com.svg',
    'avatar-svgrepo-com (2).svg',
    'avatar-svgrepo-com (3).svg',
    'avatar-svgrepo-com (4).svg',
    'avatar-svgrepo-com (6).svg',
    'avatar-svgrepo-com (7).svg',
    'avatar-svgrepo-com (9).svg',
    'avatar-svgrepo-com (10).svg',
  ];

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // Headphones Icon (Top Left)
                  ScaleBounceAnimation(
                    delay: const Duration(milliseconds: 100),
                    child: SvgPicture.asset(
                      'assets/images/headphones.svg',
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 30),
                  StaggeredAnimation(
                    index: 1,
                    child: const Text(
                      'Select an avatar to represent your funk',
                      style: TextStyle(
                        fontFamily: 'Futura PT',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                      itemCount: avatarFiles.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedIndex == index;
                        return StaggeredAnimation(
                          index: 2 + index,
                          delay: const Duration(milliseconds: 40),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.2),
                                border: isSelected
                                    ? Border.all(
                                        color: const Color(0xFFA3CB43),
                                        width: 4,
                                      )
                                    : Border.all(
                                        color: Colors.white.withOpacity(0.3),
                                        width: 2,
                                      ),
                              ),
                              padding: const EdgeInsets.all(12),
                              child: SvgPicture.asset(
                                'assets/images/${avatarFiles[index]}',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Continue Button
                  StaggeredAnimation(
                    index: 2 + avatarFiles.length,
                    delay: const Duration(milliseconds: 40),
                    child: CustomButton(
                      text: 'Continue',
                      onPressed: () => context.push('/onboarding/subscription'),
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
