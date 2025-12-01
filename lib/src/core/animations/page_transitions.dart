import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Custom page with slide transition
class SlideTransitionPage<T> extends CustomTransitionPage<T> {
  SlideTransitionPage({
    required super.child,
    super.key,
    AxisDirection direction = AxisDirection.right,
    super.transitionDuration = const Duration(milliseconds: 350),
    super.reverseTransitionDuration = const Duration(milliseconds: 300),
  }) : super(
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           Offset begin;
           switch (direction) {
             case AxisDirection.right:
               begin = const Offset(1.0, 0.0);
               break;
             case AxisDirection.left:
               begin = const Offset(-1.0, 0.0);
               break;
             case AxisDirection.up:
               begin = const Offset(0.0, -1.0);
               break;
             case AxisDirection.down:
               begin = const Offset(0.0, 1.0);
               break;
           }

           const end = Offset.zero;
           const curve = Curves.easeInOutCubic;

           var tween = Tween(
             begin: begin,
             end: end,
           ).chain(CurveTween(curve: curve));

           var offsetAnimation = animation.drive(tween);

           // Fade transition for the entering page
           var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
             CurvedAnimation(
               parent: animation,
               curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
             ),
           );

           return SlideTransition(
             position: offsetAnimation,
             child: FadeTransition(opacity: fadeAnimation, child: child),
           );
         },
       );
}

/// Modal page that slides up from bottom
class ModalTransitionPage<T> extends CustomTransitionPage<T> {
  ModalTransitionPage({
    required super.child,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 400),
    super.reverseTransitionDuration = const Duration(milliseconds: 350),
    super.barrierDismissible = true,
    super.barrierColor = Colors.black54,
    super.opaque = false,
  }) : super(
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           const begin = Offset(0.0, 1.0);
           const end = Offset.zero;
           const curve = Curves.easeOutCubic;

           var tween = Tween(
             begin: begin,
             end: end,
           ).chain(CurveTween(curve: curve));

           var offsetAnimation = animation.drive(tween);

           // Background fade
           var fadeAnimation = Tween<double>(
             begin: 0.0,
             end: 1.0,
           ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

           return SlideTransition(
             position: offsetAnimation,
             child: FadeTransition(opacity: fadeAnimation, child: child),
           );
         },
       );
}

/// Fade page transition
class FadeTransitionPage<T> extends CustomTransitionPage<T> {
  FadeTransitionPage({
    required super.child,
    super.key,
    super.transitionDuration = const Duration(milliseconds: 300),
  }) : super(
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           return FadeTransition(opacity: animation, child: child);
         },
       );
}
