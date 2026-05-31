import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

class ModernNavBar extends StatelessWidget {
  final String activeSection;
  final Map<String, GlobalKey> sectionKeys;
  final bool isMobile;

  const ModernNavBar({
    super.key,
    required this.activeSection,
    required this.sectionKeys,
    this.isMobile = false,
  });

  void _scrollToSection(String section) {
    final key = sectionKeys[section];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: (isDark ? WebColors.backgroundDark : WebColors.backgroundLight)
            .withValues(alpha: 0.85),
        border: Border(
          bottom: BorderSide(
            color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.06),
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 80,
            ),
            child: Row(
              children: [
                Text(
                  "PS",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: WebColors.accent,
                  ),
                ),
                const SizedBox(width: 6),
                Container(
                  width: 1,
                  height: 20,
                  color: WebColors.glassBorder,
                ),
                const SizedBox(width: 6),
                Text(
                  "Piyush Singh",
                  style: TextStyle(
                    color: isDark
                        ? WebColors.textSecondary
                        : WebColors.textDarkSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                if (!isMobile)
                  ...sectionKeys.keys.map(
                    (section) => _NavButton(
                      label: _fmt(section),
                      isActive: activeSection == section,
                      onTap: () => _scrollToSection(section),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _fmt(String key) {
    if (key == "home") return "Home";
    return key[0].toUpperCase() + key.substring(1);
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavButton({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isActive
              ? WebColors.accent.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? WebColors.accent : WebColors.textSecondary,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}