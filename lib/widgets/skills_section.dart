import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class SkillsSection extends StatefulWidget {
  final bool isMobile;

  const SkillsSection({super.key, this.isMobile = false});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _barController;

  @override
  void initState() {
    super.initState();
    _barController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _barController.dispose();
    super.dispose();
  }

  final List<String> _skills = const [
    "Flutter", "Dart", "Firebase", "Git", "GitHub",
    "REST API", "SQLite", "Provider", "GetX", "Figma",
    "UI/UX", "Riverpod", "Bloc", "Hive",
  ];

  final List<Map<String, dynamic>> _skillDetails = const [
    {"name": "Flutter", "level": 0.95},
    {"name": "Dart", "level": 0.9},
    {"name": "Firebase", "level": 0.85},
    {"name": "REST API", "level": 0.85},
    {"name": "Git/GitHub", "level": 0.8},
    {"name": "Provider/GetX", "level": 0.88},
    {"name": "Figma", "level": 0.7},
    {"name": "SQLite/Hive", "level": 0.78},
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(isDark),
        const SizedBox(height: 24),
        _buildAutoScrollStrip(isDark),
        const SizedBox(height: 48),
        if (!widget.isMobile) _buildSkillBars(isDark),
      ],
    );
  }

  Widget _buildSectionHeader(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _hp()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 3, height: 24, color: WebColors.accent),
              const SizedBox(width: 10),
              Text(
                "my toolbox",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: WebColors.accent,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Technologies & Skills",
            style: TextStyle(
              fontSize: widget.isMobile ? 28 : 40,
              fontWeight: FontWeight.w700,
              color: isDark ? WebColors.textPrimary : WebColors.textDark,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Tools and technologies I use to bring ideas to life",
            style: TextStyle(
              fontSize: 14,
              color: isDark ? WebColors.textSecondary : WebColors.textDarkSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoScrollStrip(bool isDark) {
    return Container(
      height: 56,
      color: isDark ? WebColors.cardDark : WebColors.cardLight,
      child: ScrollLoopAutoScroll(
        scrollDirection: Axis.horizontal,
        delay: const Duration(milliseconds: 100),
        gap: 20,
        reverseScroll: true,
        duplicateChild: 25,
        enableScrollInput: false,
        duration: const Duration(seconds: 150),
        child: Row(
          children: _skills.map((skill) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 8, height: 8,
                    decoration: BoxDecoration(
                      color: WebColors.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    skill,
                    style: TextStyle(
                      color: isDark ? WebColors.textPrimary : WebColors.textDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildSkillBars(bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _hp()),
      child: Wrap(
        spacing: 40,
        runSpacing: 28,
        children: _skillDetails.asMap().entries.map((entry) {
          final idx = entry.key;
          final skill = entry.value;
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 600 + idx * 100),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return SizedBox(
                width: 260,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          skill["name"],
                          style: TextStyle(
                            color: isDark
                                ? WebColors.textPrimary
                                : WebColors.textDark,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${(skill["level"] * 100).toInt()}%",
                          style: TextStyle(
                            color: WebColors.accent,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3),
                      child: LinearProgressIndicator(
                        value: skill["level"] * value,
                        backgroundColor:
                            (isDark ? Colors.white : Colors.black)
                                .withValues(alpha: 0.08),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          WebColors.accent,
                        ),
                        minHeight: 5,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  double _hp() => widget.isMobile ? 24 : 80;
}