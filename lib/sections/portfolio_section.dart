import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/project_model.dart';
import '../services/firestore_service.dart';
import '../screens/project_detail_screen.dart';

class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  State<PortfolioSection> createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  String _selectedFilter = "All";
  final List<String> _filters = ["All", ];

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;

    List<ProjectModel> filtered = _selectedFilter == "All"
        ? _projects
        : _projects.where((p) =>
            p.chips.any((c) => c.toLowerCase() == _selectedFilter.toLowerCase())
        ).toList();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Portfolio"),
          const SizedBox(height: 30),
          if (isTablet) _filterButtons() else _filterDropdown(),
          const SizedBox(height: 25),
          if (_loading)
            const Center(child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppColors.orangeYellowCrayola),
            ))
          else if (filtered.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(40),
                child: Text("No projects found", style: GoogleFonts.poppins(color: AppColors.lightGray70)),
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isTablet ? (screenWidth > 1024 ? 3 : 2) : 1,
                crossAxisSpacing: 25,
                mainAxisSpacing: 25,
                childAspectRatio: isTablet ? 0.95 : 1.2,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) => _projectCard(filtered[index]),
            ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.white2)),
        const SizedBox(height: 7),
        Container(
          width: 40, height: 5,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), gradient: LinearGradient(colors: AppColors.goldGradient)),
        ),
      ],
    );
  }

  Widget _filterButtons() {
    return Row(
      children: List.generate(_filters.length, (i) {
        final isActive = _selectedFilter == _filters[i];
        return GestureDetector(
          onTap: () => setState(() => _selectedFilter = _filters[i]),
          child: Padding(
            padding: EdgeInsets.only(right: i < _filters.length - 1 ? 25 : 0),
            child: Text(_filters[i], style: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.w400,
              color: isActive ? AppColors.orangeYellowCrayola : AppColors.lightGray,
            )),
          ),
        );
      }),
    );
  }

  Widget _filterDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: AppColors.eerieBlack2, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.jet)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedFilter,
          dropdownColor: AppColors.eerieBlack2,
          isExpanded: true,
          icon: const Icon(Icons.expand_more, color: AppColors.lightGray),
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w300, color: AppColors.lightGray),
          items: _filters.map((f) => DropdownMenuItem(value: f, child: Text(f))).toList(),
          onChanged: (v) => setState(() => _selectedFilter = v!),
        ),
      ),
    );
  }

  Widget _projectCard(ProjectModel project) {
    return InkWell(
      onTap: () => _showProjectDetail(project),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(colors: [AppColors.gradientOnyxLight, AppColors.gradientOnyxDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.25), blurRadius: 30, offset: const Offset(0, 24))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                gradient: LinearGradient(colors: [AppColors.orangeYellowCrayola.withValues(alpha: 0.15), AppColors.vegasGold.withValues(alpha: 0.05)]),
              ),
              child: Center(child: Icon(Icons.folder_outlined, size: 48, color: AppColors.orangeYellowCrayola.withValues(alpha: 0.6))),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(project.name, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.white2)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: project.chips.map((c) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.orangeYellowCrayola.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                        child: Text(c, style: GoogleFonts.poppins(fontSize: 10, color: AppColors.orangeYellowCrayola)),
                      )).toList(),
                    ),
                    const SizedBox(height: 8),
                    Flexible(
                      child: Text(project.des, style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w300, color: AppColors.lightGray, height: 1.4), maxLines: 3, overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
            ),
          ],
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