import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/project_model.dart';
import '../services/firestore_service.dart';
import '../screens/project_detail_screen.dart';
import '../widgets/section_heading.dart';
import '../widgets/animations.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  List<ProjectModel> _projects = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    try {
      final projects = await FirestoreService.fetchProjects();
      if (mounted) setState(() { _projects = projects; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                label: 'MY WORK',
                title: 'Featured Projects',
                subtitle: 'A showcase of apps I\'ve built and shipped to real users.',
              ),
              const SizedBox(height: 40),
              if (_loading)
                const Padding(
                  padding: EdgeInsets.all(40),
                  child: CircularProgressIndicator(color: AppColors.accent),
                )
              else if (_projects.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                    'No projects found',
                    style: GoogleFonts.dmSans(color: AppColors.textMuted),
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final crossAxisCount = width > 800 ? 3 : (width > 500 ? 2 : 1);
                    const double spacing = 20.0;
                    final double cardWidth = (width - (crossAxisCount - 1) * spacing) / crossAxisCount;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: spacing,
                      children: List.generate(_projects.length, (index) {
                        return SizedBox(
                          width: cardWidth,
                          child: _projectCard(
                            _projects[index],
                            delay: Duration(milliseconds: index * 100),
                          ),
                        );
                      }),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _projectCard(ProjectModel project, {Duration delay = Duration.zero}) {
    return FadeInSlideUp(
      delay: delay,
      child: GestureDetector(
        onTap: () => _showProjectDetail(project),
        child: HoverCard(
          borderRadius: 16,
          child: Container(
            color: AppColors.cardBg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project image placeholder
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accent.withValues(alpha: 0.08),
                        AppColors.accent.withValues(alpha: 0.03),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: AppColors.accentLight,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Icon(Icons.phone_android, size: 28, color: AppColors.accent),
                      ),
                    ),
                  ),
                ),
                // Project info
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: project.chips.map((c) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.accentLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            c,
                            style: GoogleFonts.dmSans(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.accent,
                            ),
                          ),
                        )).toList(),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        project.des,
                        style: GoogleFonts.dmSans(
                          fontSize: 13,
                          color: AppColors.textMuted,
                          height: 1.5,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showProjectDetail(ProjectModel project) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProjectDetailScreen(project: project),
      ),
    );
  }
}