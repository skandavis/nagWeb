import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ProfileImageGallery extends StatefulWidget {
  final List<String> imageUrls;

  const ProfileImageGallery({super.key, required this.imageUrls});

  @override
  State<ProfileImageGallery> createState() => _ProfileImageGalleryState();
}

class _ProfileImageGalleryState extends State<ProfileImageGallery> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _GalleryPageView(
          imageUrls: widget.imageUrls,
          pageController: _pageController,
          onPageChanged: (i) => setState(() => _currentPage = i),
        ),
        const SizedBox(height: 16),
        _GalleryDots(
          count: widget.imageUrls.length,
          currentIndex: _currentPage,
          onDotTapped: (i) => _pageController.animateToPage(
            i,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          ),
        ),
      ],
    );
  }
}

// ─── PageView ─────────────────────────────────────────────────────────────────

class _GalleryPageView extends StatelessWidget {
  final List<String> imageUrls;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const _GalleryPageView({
    required this.imageUrls,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 460,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.borderStrong, width: 1.4),
        boxShadow: [
          BoxShadow(
            color: AppColors.royalPlum.withValues(alpha: 0.12),
            blurRadius: 32,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            PageView.builder(
              controller: pageController,
              onPageChanged: onPageChanged,
              itemCount: imageUrls.length,
              itemBuilder: (context, i) => _GalleryImage(url: imageUrls[i]),
            ),
            _NavArrow(
              alignment: Alignment.centerLeft,
              icon: Icons.arrow_back_ios_new_rounded,
              onTap: () => pageController.previousPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
              ),
            ),
            _NavArrow(
              alignment: Alignment.centerRight,
              icon: Icons.arrow_forward_ios_rounded,
              onTap: () => pageController.nextPage(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Single gallery image ─────────────────────────────────────────────────────

class _GalleryImage extends StatelessWidget {
  final String url;

  const _GalleryImage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.marbleShadow,
            AppColors.marble,
          ],
        ),
      ),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            color: AppColors.marble,
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.gold),
              strokeWidth: 1.5,
            ),
          );
        },
        errorBuilder: (context, _, __) => _ImagePlaceholder(),
      ),
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cream,
      alignment: Alignment.center,
      child: const Text(
        '✦',
        style: TextStyle(color: AppColors.gold, fontSize: 32),
      ),
    );
  }
}

// ─── Arrow overlay button ─────────────────────────────────────────────────────

class _NavArrow extends StatelessWidget {
  final AlignmentGeometry alignment;
  final IconData icon;
  final VoidCallback onTap;

  const _NavArrow({
    required this.alignment,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: AppColors.royalPlum.withValues(alpha: 0.72),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.goldLight.withValues(alpha: 0.45)),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.ivory, size: 16),
        ),
      ),
    );
  }
}

// ─── Dot indicators ───────────────────────────────────────────────────────────

class _GalleryDots extends StatelessWidget {
  final int count;
  final int currentIndex;
  final ValueChanged<int> onDotTapped;

  const _GalleryDots({
    required this.count,
    required this.currentIndex,
    required this.onDotTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == currentIndex;
        return GestureDetector(
          onTap: () => onDotTapped(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 28 : 10,
            height: 6,
            decoration: BoxDecoration(
              color: isActive ? AppColors.gold : AppColors.border,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        );
      }),
    );
  }
}
