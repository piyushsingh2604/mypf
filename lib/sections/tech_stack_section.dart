import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

class TechStackSection extends StatefulWidget {
  const TechStackSection({super.key});
  @override
  State<TechStackSection> createState() => _TechStackSectionState();
}

class _TechStackSectionState extends State<TechStackSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  static const _techs = [
    'Flutter',
    'Dart',
    'Firebase',
    'REST API',
    'GetX',
    'Provider',
    'SQLite',
    'Hive',
    'Git',
    'GitHub',
    'iOS',
    'Android',
    'Figma',
    'VS Code',
    'Cloud Functions',
    'Firestore',
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      color: AppColors.backgroundAlt,
      child: Column(
        children: [
          Text(
            'TECH STACK',
            style: GoogleFonts.dmSans(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.accent,
              letterSpacing: 3.0,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: ClipRect(
              child: AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return FractionalTranslation(
                    translation: Offset(-_animController.value * 0.5, 0.0),
                    child: child,
                  );
                },
                child: OverflowBox(
                  maxWidth: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ..._techs.map((tech) => _buildTechPill(tech)),
                      ..._techs.map((tech) => _buildTechPill(tech)),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechPill(String tech) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border),
        ),
        child: Center(
          child: Text(
            tech,
            style: GoogleFonts.dmSans(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
