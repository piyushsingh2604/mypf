import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'dart:ui';

class Navbar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;
  final List<String> sectionLabels;

  const Navbar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.sectionLabels,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _activeIndex = 0;
  bool _mobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  int _lastCheckTime = 0;

  void _onScroll() {
    final int now = DateTime.now().millisecondsSinceEpoch;
    if (now - _lastCheckTime < 100) {
      return;
    }
    _lastCheckTime = now;

    const double threshold = 150.0;
    int newActive = 0;

    for (int i = widget.sectionKeys.length - 1; i >= 0; i--) {
      final key = widget.sectionKeys[i];
      if (key.currentContext != null) {
        final RenderBox box =
            key.currentContext!.findRenderObject() as RenderBox;
        final Offset position = box.localToGlobal(Offset.zero);
        if (position.dy <= threshold) {
          newActive = i;
          break;
        }
      }
    }

    if (newActive != _activeIndex) {
      setState(() {
        _activeIndex = newActive;
      });
    }
  }

  void _scrollToSection(int index) {
    final key = widget.sectionKeys[index];
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _openMobileMenu() {
    setState(() {
      _mobileMenuOpen = true;
    });
  }

  void _closeMobileMenu() {
    setState(() {
      _mobileMenuOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildNavbar(context),
        if (_mobileMenuOpen) _buildMobileOverlay(context),
      ],
    );
  }

  Widget _buildNavbar(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth > 768;
    final double horizontalPadding = isDesktop ? 24.0 : 16.0;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            border: Border(
              bottom: BorderSide(
                color: AppColors.borderLight,
                width: 1,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Row(
            children: [
              // Logo
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  'PS',
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              const Spacer(),
              if (isDesktop)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(widget.sectionLabels.length, (index) {
                    final bool isActive = _activeIndex == index;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: GestureDetector(
                        onTap: () => _scrollToSection(index),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Text(
                            widget.sectionLabels[index],
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isActive
                                  ? AppColors.accent
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )
              else
                IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: _openMobileMenu,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileOverlay(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SafeArea(
        child: Stack(
          children: [
            // Close button
            Positioned(
              top: 12,
              right: 16,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.textPrimary,
                  size: 28,
                ),
                onPressed: _closeMobileMenu,
              ),
            ),
            // Centered links
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    List.generate(widget.sectionLabels.length, (index) {
                  final bool isActive = _activeIndex == index;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: GestureDetector(
                      onTap: () {
                        _closeMobileMenu();
                        _scrollToSection(index);
                      },
                      child: Text(
                        widget.sectionLabels[index],
                        style: GoogleFonts.dmSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: isActive
                              ? AppColors.accent
                              : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
