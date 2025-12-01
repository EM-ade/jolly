import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SubscriptionPlansScreen extends StatelessWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final plans = [
      _PlanData(
        title: 'Daily Jolly Plan',
        price: '₦ 100',
        description:
            'Enjoy unlimited podcast for 24 hours. You can cancel at anytime.',
      ),
      _PlanData(
        title: 'Weekly Jolly Plan',
        price: '₦ 350',
        description:
            'Enjoy unlimited podcast for 7 days. You can cancel at anytime.',
      ),
      _PlanData(
        title: 'Monthly Jolly Plan',
        price: '₦ 500',
        description:
            'Enjoy unlimited podcast for 30 days. You can cancel at anytime.',
      ),
    ];

    return Scaffold(
      body: Container(
        color: const Color(0xFF001010),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Header
              Image.asset(
                'assets/images/onboarding_illustration.png',
                height: 40,
              ),
              const SizedBox(height: 20),
              const Text(
                'Enjoy unlimited podcasts',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              // Plans List
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 20,
                    bottom: 40,
                  ),
                  itemCount: plans.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return SubscriptionPlanCard(data: plans[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanData {
  final String title;
  final String price;
  final String description;

  _PlanData({
    required this.title,
    required this.price,
    required this.description,
  });
}

class SubscriptionPlanCard extends StatelessWidget {
  final _PlanData data;

  const SubscriptionPlanCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/images/onboarding_bg.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Image.asset(
            'assets/images/music.png',
            width: 60,
            height: 60,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 16),
          // Title
          Text(
            data.title,
            style: const TextStyle(
              fontFamily: 'Futura PT',
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          // Price
          Text(
            data.price,
            style: const TextStyle(
              fontFamily: 'Futura PT',
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF003334), // Dark green/black
            ),
          ),
          const SizedBox(height: 12),
          // Description
          Text(
            data.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          // Buttons
          Row(
            children: [
              Expanded(
                child: _PlanButton(
                  text: 'One-time',
                  onPressed: () {
                    // Handle one-time payment
                    context.go('/home');
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _PlanButton(
                  text: 'Auto-renewal',
                  onPressed: () {
                    // Handle auto-renewal
                    context.go('/home');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PlanButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _PlanButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF282828),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
