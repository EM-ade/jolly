import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../core/common_widgets/custom_button.dart';
import 'widgets/category_chip.dart';
import '../../../core/animations/animation_widgets.dart';

class OnboardingPersonalizationScreen extends StatefulWidget {
  const OnboardingPersonalizationScreen({super.key});

  @override
  State<OnboardingPersonalizationScreen> createState() =>
      _OnboardingPersonalizationScreenState();
}

class _OnboardingPersonalizationScreenState
    extends State<OnboardingPersonalizationScreen> {
  final List<String> categories = [
    'Business & Career',
    'Movies & Cinema',
    'Tech events',
    'Mountain climbing',
    'Educational',
    'Religious & Spiritual',
    'Sip & Paint',
    'Fitness',
    'Sports',
    'Kayaking',
    'Clubs & Party',
    'Games',
    'Concerts',
    'Art & Culture',
    'Karaoke',
    'Adventure',
    'Health & Lifestyle',
    'Food & Drinks',
  ];
  final Set<String> selectedCategories = {};

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
                      'What are you interested in?',
                      style: TextStyle(
                        fontFamily: 'Futura PT',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  StaggeredAnimation(
                    index: 2,
                    child: const Text(
                      'Select a few categories to get started.',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 6,
                        runSpacing: 8,
                        children: categories.asMap().entries.map((entry) {
                          final index = entry.key;
                          final category = entry.value;
                          final isSelected = selectedCategories.contains(
                            category,
                          );
                          return StaggeredAnimation(
                            index: 3 + index,
                            delay: const Duration(milliseconds: 30),
                            child: CategoryChip(
                              label: category,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedCategories.remove(category);
                                  } else {
                                    selectedCategories.add(category);
                                  }
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StaggeredAnimation(
                    index: 3 + categories.length,
                    delay: const Duration(milliseconds: 30),
                    child: CustomButton(
                      text: 'Continue',
                      onPressed: () => context.push('/onboarding/avatar'),
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
