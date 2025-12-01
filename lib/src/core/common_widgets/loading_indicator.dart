import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class LoadingIndicator extends StatefulWidget {
  final Color? color;
  final double size;

  const LoadingIndicator({super.key, this.color, this.size = 40.0});

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.color ?? AppColors.limeGreen,
        ),
        strokeWidth: 3,
      ),
    );
  }
}
