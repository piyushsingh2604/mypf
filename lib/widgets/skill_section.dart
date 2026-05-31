import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

class SkillSection extends StatefulWidget {
  final bool isMobile;
  const SkillSection({super.key, this.isMobile = false});

  @override
  State<SkillSection> createState() => _SkillSectionState();
}

class _SkillSectionState extends State<SkillSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final _hovered = ValueNotifier<int>(-1);

  final _skills = const [
    "Flutter", "Dart", "Firebase", "Git", "REST API",
    "Provider", "GetX", "Bloc", "Riverpod", "Figma",
    "UI/UX", "Hive", "SQLite", "Node.js",
    "Go", "Python", "Docker", "MongoDB", "PostgreSQL",
    "GraphQL", "WebSockets", "CI/CD", "AWS", "TypeScript",
  ];

  final _detail = const [
    {"name": "Flutter", "level": 0.95},
    {"name": "Dart", "level": 0.9},
    {"name": "Firebase", "level": 0.85},
    {"name": "REST API", "level": 0.85},
    {"name": "Git/GitHub", "level": 0.8},
    {"name": "Provider/GetX", "level": 0.88},
    {"name": "Go", "level": 0.7},
    {"name": "Docker", "level": 0.65},
    {"name": "MongoDB", "level": 0.75},
    {"name": "PostgreSQL", "level": 0.7},
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _hovered.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const SizedBox(height: 24),
        _chipCloud(),
        const SizedBox(height: 48),
        if (!widget.isMobile) _progressBars(),
      ],
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 24 : 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _meta("expertise"),
          const SizedBox(height: 12),
          Text(
            "My Toolbox",
            style: TextStyle(
              fontSize: widget.isMobile ? 28 : 40,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).brightness == Brightness.dark
                  ? WebColors.text : WebColors.textLight,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Technologies I work with daily",
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).brightness == Brightness.dark
                  ? WebColors.textMuted : WebColors.textLightMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chipCloud() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.isMobile ? 24 : 80),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: _skills.asMap().entries.map((e) {
          final i = e.key;
          final s = e.value;
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 400 + i * 50),
            curve: Curves.easeOutCubic,
            builder: (context, val, child) {
              return Opacity(
                opacity: val.clamp(0.0, 1.0),
                child: Transform.scale(scale: val, child: child),
              );
            },
            child: ValueListenableBuilder<int>(
              valueListenable: _hovered,
              builder: (context, h, _) {
                final isHover = h == i;
                return MouseRegion(
                  onEnter: (_) => _hovered.value = i,
                  onExit: (_) => _hovered.value = -1,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isHover
                          ? WebColors.primary.withValues(alpha: 0.15)
                          : WebColors.card,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                        color: isHover
                            ? WebColors.primary.withValues(alpha: 0.5)
                            : WebColors.glass,
                      ),
                      boxShadow: isHover
                          ? [BoxShadow(
                              color: WebColors.primary.withValues(alpha: 0.15),
                              blurRadius: 16,
                            )]
                          : null,
                    ),
                    child: Text(
                      s,
                      style: TextStyle(
                        color: isHover ? WebColors.primary : WebColors.text,
                        fontSize: 14,
                        fontWeight: isHover ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _progressBars() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Wrap(
        spacing: 60,
        runSpacing: 28,
        children: _detail.asMap().entries.map((e) {
          final i = e.key;
          final s = e.value;
          return TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 800 + i * 100),
            curve: Curves.easeOutCubic,
            builder: (context, val, _) {
              return SizedBox(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(s["name"] as String, style: const TextStyle(
                          color: WebColors.text, fontSize: 14, fontWeight: FontWeight.w500,
                        )),
                        Text("${((s["level"] as double) * 100).toInt()}%", style: const TextStyle(
                          color: WebColors.primary, fontSize: 13, fontWeight: FontWeight.w600,
                        )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (s["level"] as double) * val,
                        backgroundColor: WebColors.glass,
                        valueColor: const AlwaysStoppedAnimation(WebColors.primary),
                        minHeight: 4,
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

  Widget _meta(String t) {
    return Row(
      children: [
        Container(width: 3, height: 20, color: WebColors.primary),
        const SizedBox(width: 10),
        Text(t, style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: WebColors.primary, letterSpacing: 2,
        )),
      ],
    );
  }
}