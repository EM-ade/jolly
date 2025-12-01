import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String icon;
  final String title;

  const SectionHeader({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          if (icon.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: icon.startsWith('assets/')
                  ? Image.asset(icon, height: 24)
                  : Text(icon, style: const TextStyle(fontSize: 24)),
            ),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Futura PT',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
