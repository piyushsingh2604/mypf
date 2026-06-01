import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../widgets/sidebar.dart';
import '../sections/about_section.dart';
import '../sections/resume_section.dart';
import '../sections/portfolio_section.dart';
import '../sections/blog_section.dart';
import '../sections/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;

  final List<_PageConfig> _pages = const [
    _PageConfig("About", Icons.person_outline),
    _PageConfig("Resume", Icons.book_outlined),
    _PageConfig("Portfolio", Icons.folder_outlined),
    _PageConfig("Blog", Icons.article_outlined),
    _PageConfig("Contact", Icons.mail_outline),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 1024;

    return Scaffold(
      body: SafeArea(
        child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Container(
      decoration: const BoxDecoration(color: AppColors.smokyBlack),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 60),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Sidebar(),
              const SizedBox(width: 25),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 500),
                  decoration: BoxDecoration(
                    color: AppColors.eerieBlack2,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.jet),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.25),
                        blurRadius: 40,
                        offset: const Offset(0, 24),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _buildNavBar(),
                      Expanded(
                        child: _buildPageContent(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Container(
      decoration: const BoxDecoration(color: AppColors.smokyBlack),
      child: Column(
        children: [
          const Sidebar(),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.eerieBlack2,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.jet),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.25),
                    blurRadius: 24,
                    offset: const Offset(0, 16),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildNavBar(),
                  Expanded(
                    child: _buildPageContent(),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 75),
        ],
      ),
    );
  }

  Widget _buildNavBar() {
    final isWide = MediaQuery.of(context).size.width > 580;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.onyx.withValues(alpha: 0.75),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(color: AppColors.jet),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: List.generate(_pages.length, (i) {
              final isActive = _currentPage == i;
              return GestureDetector(
                onTap: () => setState(() => _currentPage = i),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWide ? 16 : 10,
                    vertical: 20,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        _pages[i].icon,
                        size: 14,
                        color: isActive ? AppColors.orangeYellowCrayola : AppColors.lightGray,
                      ),
                      if (isWide) ...[
                        const SizedBox(width: 6),
                        Text(
                          _pages[i].label,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                            color: isActive ? AppColors.orangeYellowCrayola : AppColors.lightGray,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Padding(
        key: ValueKey(_currentPage),
        padding: const EdgeInsets.all(15),
        child: _buildCurrentPage(),
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (_currentPage) {
      case 0:
        return const AboutSection();
      case 1:
        return const ResumeSection();
      case 2:
        return const PortfolioSection();
      case 3:
        return const BlogSection();
      case 4:
        return const ContactSection();
      default:
        return const AboutSection();
    }
  }
}

class _PageConfig {
  final String label;
  final IconData icon;
  const _PageConfig(this.label, this.icon);
}