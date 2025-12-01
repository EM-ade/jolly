import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HotPodcastCard extends StatelessWidget {
  final String imageUrl;
  final String category;
  final String title;
  final String description;
  final VoidCallback? onPlay;
  final VoidCallback? onLike;
  final VoidCallback? onAdd;
  final VoidCallback? onShare;

  const HotPodcastCard({
    super.key,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.description,
    this.onPlay,
    this.onLike,
    this.onAdd,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final bool isNetworkImage = imageUrl.startsWith('http');

    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1F1F),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Podcast cover image with play button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: isNetworkImage
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        width: 280,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: 280,
                          height: 200,
                          color: const Color(0xFF1A2A2A),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          width: 280,
                          height: 200,
                          color: const Color(0xFF1A2A2A),
                          child: const Icon(Icons.error, color: Colors.white),
                        ),
                      )
                    : Image.asset(
                        imageUrl,
                        width: 280,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
              Positioned.fill(
                child: Center(
                  child: GestureDetector(
                    onTap: onPlay,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category
                Text(
                  category,
                  style: const TextStyle(
                    color: Color(0xFFA3CB43),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                // Description
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF8A9A9A),
                    fontSize: 12,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _ActionButton(
                      iconPath: 'assets/images/heart.svg',
                      onTap: onLike,
                    ),
                    _ActionButton(
                      iconPath: 'assets/images/library.svg',
                      onTap: onAdd,
                    ),
                    _ActionButton(
                      iconPath: 'assets/images/share.svg',
                      onTap: onShare,
                    ),
                    _ActionButton(
                      iconPath: 'assets/images/add.svg',
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onTap;

  const _ActionButton({required this.iconPath, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1A2A2A),
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
