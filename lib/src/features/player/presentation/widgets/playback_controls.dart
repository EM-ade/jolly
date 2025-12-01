import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback? onPlay;
  final VoidCallback? onPause;
  final VoidCallback? onNext;
  final VoidCallback? onPrevious;
  final VoidCallback? onRewind;
  final VoidCallback? onForward;

  const PlaybackControls({
    super.key,
    required this.isPlaying,
    this.onPlay,
    this.onPause,
    this.onNext,
    this.onPrevious,
    this.onRewind,
    this.onForward,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Previous button
        _ControlButton(
          iconPath: 'assets/images/backward.svg',
          size: 40,
          onTap: onPrevious,
        ),
        const SizedBox(width: 16),
        // Rewind 10s button
        _ControlButton(
          iconPath: 'assets/images/rotate_left.svg',
          size: 40,
          onTap: onRewind,
        ),
        const SizedBox(width: 16),
        // Play/Pause button (larger)
        GestureDetector(
          onTap: isPlaying ? onPause : onPlay,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xA7269C20),
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 36,
            ),
          ),
        ),
        const SizedBox(width: 16),
        // Forward 10s button
        _ControlButton(
          iconPath: 'assets/images/rotate_right.svg',
          size: 40,
          onTap: onForward,
        ),
        const SizedBox(width: 16),
        // Next button (backward icon rotated 180)
        _ControlButton(
          iconPath: 'assets/images/backward.svg',
          size: 40,
          rotation: 180,
          onTap: onNext,
        ),
      ],
    );
  }
}

class _ControlButton extends StatelessWidget {
  final String iconPath;
  final double size;
  final double rotation;
  final VoidCallback? onTap;

  const _ControlButton({
    required this.iconPath,
    required this.size,
    this.rotation = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Transform.rotate(
          angle: rotation * 3.14159 / 180,
          child: SvgPicture.asset(
            iconPath,
            width: size,
            height: size,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
