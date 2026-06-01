import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/project_model.dart';

class ProjectDetailScreen extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailScreen({super.key, required this.project});

  @override
  State<ProjectDetailScreen> createState() => _ProjectDetailScreenState();
}

class _ProjectDetailScreenState extends State<ProjectDetailScreen> {
  final _pageCtrl = PageController();
  int _currentImage = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final hasImages = project.screenshots.isNotEmpty;

    return Scaffold(
      backgroundColor: AppColors.smokyBlack,
      appBar: AppBar(
        backgroundColor: AppColors.eerieBlack2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white2),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          project.name,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.white2,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImages) ...[
              SizedBox(
                height: 280,
                child: Stack(
                  children: [
                    PageView.builder(
                      controller: _pageCtrl,
                      onPageChanged: (i) => setState(() => _currentImage = i),
                      itemCount: project.screenshots.length,
                      itemBuilder: (context, index) {
                        return Container(
                          color: AppColors.eerieBlack1,
                          child: Image.network(
                            project.screenshots[index],
                            fit: BoxFit.contain,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => _imagePlaceholder(),
                            loadingBuilder: (_, child, progress) {
                              if (progress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.orangeYellowCrayola,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    if (project.screenshots.length > 1)
                      Positioned(
                        bottom: 12,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            project.screenshots.length,
                            (i) => AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              width: _currentImage == i ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: _currentImage == i
                                    ? AppColors.orangeYellowCrayola
                                    : AppColors.lightGray70,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ] else
              Container(
                height: 200,
                color: AppColors.eerieBlack1,
                child: _imagePlaceholder(),
              ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name,
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: project.chips.map((c) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.orangeYellowCrayola.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        c,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.orangeYellowCrayola,
                        ),
                      ),
                    )).toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "About",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    project.des,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: AppColors.lightGray,
                      height: 1.7,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Center(
      child: Icon(
        Icons.folder_outlined,
        size: 64,
        color: AppColors.orangeYellowCrayola.withValues(alpha: 0.4),
      ),
    );
  }
}