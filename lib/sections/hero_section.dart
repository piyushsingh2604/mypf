import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';
import '../models/resume_data.dart';
import '../widgets/animations.dart';
import '../services/download_helper.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback? onContactTap;

  const HeroSection({super.key, this.onContactTap});

  // ── Social URLs ──
  static const _githubUrl = 'https://github.com/piyushsingh2604';
  static const _linkedinUrl = 'https://www.linkedin.com/in/piyush-singh-028582259';
  static const _instaUrl = 'https://www.instagram.com/piyushhh.dev';
  static const _xUrl = 'https://x.com/VLOKING1';

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ResumeData.piyush;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isDesktop = width > 900;
        final isTablet = width > 600;

        return Container(
          width: double.infinity,
          color: AppColors.background,
          child: Stack(
            children: [
              // ── Decorative blobs ──
              Positioned(
                top: -100,
                right: -100,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.accent.withValues(alpha: 0.06),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -50,
                left: -50,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accent.withValues(alpha: 0.04),
                  ),
                ),
              ),

              // ── Content ──
              Padding(
                padding: isDesktop
                    ? const EdgeInsets.fromLTRB(48, 100, 48, 80)
                    : const EdgeInsets.fromLTRB(24, 80, 24, 60),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 1200),
                    child: isDesktop
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: _buildLeftColumn(data, isDesktop, isTablet)),
                              const SizedBox(width: 48),
                              Expanded(child: _buildCodeCard()),
                            ],
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLeftColumn(data, isDesktop, isTablet),
                            ],
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Left column ──
  Widget _buildLeftColumn(ResumeData data, bool isDesktop, bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. Available badge
        FadeInSlideUp(
          delay: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.successBg,
              border: Border.all(color: AppColors.successBorder, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.successText,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Available for work',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.successText,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // 2. Main heading
        FadeInSlideUp(
          delay: const Duration(milliseconds: 200),
          child: Text(
            'I build mobile\napps people\nuse every day.',
            style: GoogleFonts.dmSans(
              fontSize: isDesktop ? 72 : (isTablet ? 60 : 42),
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.02,
              letterSpacing: -1.5,
            ),
          ),
        ),

        const SizedBox(height: 20),

        // 3. Subtitle
        FadeInSlideUp(
          delay: const Duration(milliseconds: 300),
          child: Text(
            'Flutter developer with 1.5+ years of industry experience shipping cross-platform apps to real users on Play Store & App Store.',
            style: GoogleFonts.dmSans(
              fontSize: isDesktop ? 18 : 16,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),

        const SizedBox(height: 32),

        // 4. CTA row
        FadeInSlideUp(
          delay: const Duration(milliseconds: 400),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              // Let's Talk button
              GestureDetector(
                onTap: onContactTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    "Let's Talk",
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textOnAccent,
                    ),
                  ),
                ),
              ),

              // Download Resume button
              GestureDetector(
                onTap: downloadResumeFile,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: AppColors.border, width: 1),
                    ),
                    child: Text(
                      'Download Resume',
                      style: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // 5. Social row
        FadeInSlideUp(
          delay: const Duration(milliseconds: 500),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _socialButton(Icons.code, _githubUrl),
              const SizedBox(width: 12),
              _socialButton(Icons.business_center, _linkedinUrl),
              const SizedBox(width: 12),
              _socialButton(Icons.camera_alt, _instaUrl),
              const SizedBox(width: 12),
              _socialButton(Icons.alternate_email, _xUrl),
            ],
          ),
        ),
      ],
    );
  }

  // ── Social button ──
  Widget _socialButton(IconData icon, String url) {
    return GestureDetector(
      onTap: () => _launch(url),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.borderMedium, width: 1),
        ),
        child: Center(
          child: Icon(icon, size: 18, color: AppColors.textSecondary),
        ),
      ),
    );
  }

  // ── Code preview card (desktop only) ──
  Widget _buildCodeCard() {
    return Center(
      child: FadeInSlideUp(
        delay: const Duration(milliseconds: 600),
        child: Container(
          width: 360,
          height: 400,
          decoration: BoxDecoration(
            color: AppColors.backgroundAlt,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.borderLight, width: 1),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowLight,
                blurRadius: 30,
                offset: Offset(0, 16),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Window dots
                Row(
                  children: [
                    _dot(const Color(0xFFFF5F57)),
                    const SizedBox(width: 8),
                    _dot(const Color(0xFFFFBD2E)),
                    const SizedBox(width: 8),
                    _dot(const Color(0xFF27C93F)),
                  ],
                ),
                const SizedBox(height: 20),

              // Code block
              Expanded(
                child: SingleChildScrollView(
                  child: _buildSyntaxHighlightedCode(),
                ),
              ),
            ],
          ),
        ),
        ),
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }

  // ── Syntax highlighted code ──
  Widget _buildSyntaxHighlightedCode() {
    const keywordColor = AppColors.accent;
    const stringColor = Color(0xFF22863A);
    const defaultColor = AppColors.textSecondary;

    final codeStyle = GoogleFonts.firaCode(
      fontSize: 12,
      height: 1.8,
      color: defaultColor,
    );

    return RichText(
      text: TextSpan(
        style: codeStyle,
        children: [
          TextSpan(text: 'class', style: TextStyle(color: keywordColor)),
          const TextSpan(text: ' MyApp '),
          TextSpan(text: 'extends', style: TextStyle(color: keywordColor)),
          const TextSpan(text: ' StatelessWidget {\n'),
          const TextSpan(text: '  @override\n'),
          const TextSpan(text: '  Widget build(BuildContext context) {\n'),
          const TextSpan(text: '    '),
          TextSpan(text: 'return', style: TextStyle(color: keywordColor)),
          const TextSpan(text: ' MaterialApp(\n'),
          const TextSpan(text: "      title: "),
          TextSpan(text: "'Piyush Singh'", style: TextStyle(color: stringColor)),
          const TextSpan(text: ',\n'),
          const TextSpan(text: '      theme: ThemeData(\n'),
          const TextSpan(text: '        primarySwatch: Colors.blue,\n'),
          const TextSpan(text: '      ),\n'),
          const TextSpan(text: '      home: '),
          TextSpan(text: 'const', style: TextStyle(color: keywordColor)),
          const TextSpan(text: ' Portfolio(),\n'),
          const TextSpan(text: '    );\n'),
          const TextSpan(text: '  }\n'),
          const TextSpan(text: '}'),
        ],
      ),
    );
  }
}
