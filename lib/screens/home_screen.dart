import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../sections/hero_section.dart';
import '../sections/services_section.dart';
import '../sections/tech_stack_section.dart';
import '../sections/portfolio_section.dart';
import '../sections/about_section.dart';
import '../sections/resume_section.dart';
import '../sections/blog_section.dart';
import '../sections/faq_section.dart';
import '../sections/contact_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;

  // Section keys for smooth scrolling
  final _homeKey = GlobalKey();
  final _servicesKey = GlobalKey();
  final _workKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _faqKey = GlobalKey();
  final _contactKey = GlobalKey();

  List<GlobalKey> get _sectionKeys => [
    _homeKey,
    _servicesKey,
    _workKey,
    _aboutKey,
    _faqKey,
    _contactKey,
  ];

  static const _sectionLabels = [
    'Home',
    'Services',
    'Work',
    'About',
    'FAQ',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToContact() {
    final key = _contactKey;
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Extra top padding for navbar
                const SizedBox(height: 64),

                // Sections
                _keyed(_homeKey, HeroSection(onContactTap: _scrollToContact)),
                _keyed(_servicesKey, const ServicesSection()),
                const TechStackSection(),
                _keyed(_workKey, const PortfolioSection()),
                _keyed(_aboutKey, const AboutSection()),
                const ResumeSection(),
                const BlogSection(),
                _keyed(_faqKey, const FaqSection()),
                _keyed(_contactKey, const ContactSection()),
                const Footer(),
              ],
            ),
          ),

          // Sticky Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
              sectionLabels: _sectionLabels,
            ),
          ),
        ],
      ),
    );
  }

  Widget _keyed(GlobalKey key, Widget child) {
    return Container(key: key, child: child);
  }
}