import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/resume_data.dart';
import '../widgets/section_heading.dart';
import '../widgets/animations.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ResumeData.piyush;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionHeading(
                label: 'SERVICES',
                title: 'What I do',
                subtitle: 'Specialized services to bring your ideas to life',
              ),
              const SizedBox(height: 40),
              LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;
                  if (width > 768) {
                    return _buildGrid(data, width);
                  }
                  return _buildColumn(data);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Grid layout (desktop / tablet) ──
  Widget _buildGrid(ResumeData data, double width) {
    const double spacing = 20.0;
    final double cardWidth = (width - spacing) / 2;

    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: List.generate(data.services.length, (index) {
        return SizedBox(
          width: cardWidth,
          child: _serviceCard(
            data.services[index],
            delay: Duration(milliseconds: index * 100),
          ),
        );
      }),
    );
  }

  // ── Column layout (mobile) ──
  Widget _buildColumn(ResumeData data) {
    return Column(
      children: [
        for (int i = 0; i < data.services.length; i++) ...[
          _serviceCard(
            data.services[i],
            delay: Duration(milliseconds: i * 100),
          ),
          if (i < data.services.length - 1) const SizedBox(height: 16),
        ],
      ],
    );
  }

  // ── Service card ──
  Widget _serviceCard(ServiceItem service, {Duration delay = Duration.zero}) {
    return FadeInSlideUp(
      delay: delay,
      child: HoverCard(
        borderRadius: 16,
        child: Container(
          padding: const EdgeInsets.all(24),
          color: AppColors.cardBg,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(service.icon, size: 24, color: AppColors.accent),
                ),
              ),
              const SizedBox(height: 16),
              // Title
              Text(
                service.title,
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              // Description
              Text(
                service.description,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  color: AppColors.textMuted,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
