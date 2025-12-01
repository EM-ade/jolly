import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF001010), Color(0xFF001010), Color(0xFF19AF48)],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Jolly Logo
                Image.asset(
                  'assets/images/onboarding_illustration.png',
                  height: 40,
                ),
                const SizedBox(height: 60),
                // Avatar (placeholder - you can customize this)
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 45,
                    color: Color(0xFF19AF48),
                  ),
                ),
                const SizedBox(height: 20),
                // Title
                const Text(
                  "You're all set Devon!",
                  style: TextStyle(
                    fontFamily: 'Futura PT',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                // Description
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Center(
                      child: Text(
                        'Subscribe to a plan to enjoy Jolly Premium. Get access to all audio contents, personalize your library to your style and do more cool jolly stuff.',
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.white,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                // See plans button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => context.go('/onboarding/plans'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF003334),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'See plans',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Terms text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white70,
                        height: 1.4,
                      ),
                      children: [
                        TextSpan(
                          text:
                              'By continuing, you verify that you are at least 18 years old, and you agree with our ',
                        ),
                        TextSpan(
                          text: 'Terms',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF003334),
                            decorationColor: Color(0xFF003334),
                          ),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Refund policy',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xFF003334),
                            decorationColor: Color(0xFF003334),
                          ),
                        ),
                        TextSpan(text: '.'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
