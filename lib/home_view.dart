import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypf/models/project_model.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/widgets/animated_bg.dart';
import 'package:mypf/widgets/glass_nav.dart';
import 'package:mypf/widgets/hero_section.dart';
import 'package:mypf/widgets/skill_section.dart';
import 'package:mypf/widgets/project_card.dart';
import 'package:mypf/widgets/stat_card.dart';
import 'package:mypf/widgets/contact_section.dart';
import 'package:mypf/widgets/footer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  List expData = [];
  RxBool loading = false.obs;
  List<ProjectModel> projects = [];
  final _scroll = ScrollController();
  String _active = "home";

  final Map<String, GlobalKey> _keys = {
    "home": GlobalKey(), "skills": GlobalKey(),
    "projects": GlobalKey(), "stats": GlobalKey(), "contact": GlobalKey(),
  };

  late AnimationController _bgAnim;

  @override
  void initState() {
    super.initState();
    _bgAnim = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
    _fetch();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _bgAnim.dispose();
    super.dispose();
  }

  void _onScroll() {
    double win = MediaQuery.of(context).size.height * 0.4;
    String ns = "home";
    for (final e in _keys.entries) {
      final key = e.value.currentContext;
      if (key != null) {
        final box = key.findRenderObject() as RenderBox?;
        if (box != null && box.localToGlobal(Offset.zero).dy < win) {
          ns = e.key;
        }
      }
    }
    if (ns != _active) setState(() => _active = ns);
  }

  Future<void> _fetch() async {
    loading.value = true;
    try {
      var r = await FirebaseFirestore.instance.collection('piyush_data').get();
      expData = r.docs.map((d) => d.data()).toList();
      r = await FirebaseFirestore.instance.collection('project_data').get();
      projects = r.docs.map((d) => ProjectModel.fromJson(d.data())).toList();
    } catch (_) {
      expData = [];
      projects = [];
    }
    loading.value = false;
  }

  void _scrollTo(String s) {
    final c = _keys[s]?.currentContext;
    if (c != null) Scrollable.ensureVisible(c, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() => loading.value
          ? const Center(child: CircularProgressIndicator(color: WebColors.primary))
          : Stack(
              children: [
                AnimatedBg(
                  child: SingleChildScrollView(
                    controller: _scroll,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 64),
                        HeroSection(key: _keys["home"], onGoToProjects: () => _scrollTo("projects")),
                        _divider(),
                        SkillSection(key: _keys["skills"]),
                        _divider(),
                        _projects(w),
                        _divider(),
                        _stats(),
                        _divider(),
                        ContactSection(key: _keys["contact"]),
                        const SizedBox(height: 40),
                        Footer(),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 0, left: 0, right: 0,
                  child: GlassNav(active: _active, keys: _keys),
                ),
              ],
            ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 80, vertical: 48),
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [WebColors.glass, WebColors.primary.withValues(alpha: 0.1), WebColors.glass],
        ),
      ),
    );
  }

  Widget _projects(double w) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: _keys["projects"],
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("portfolio"),
              const SizedBox(height: 12),
              const Text("Featured Work",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: WebColors.text, letterSpacing: -0.5),
              ),
              const SizedBox(height: 8),
              const Text("Projects that challenged and shaped me",
                style: TextStyle(fontSize: 14, color: WebColors.textMuted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: LayoutBuilder(
            builder: (context, c) {
              return MasonryGridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: c.maxWidth > 1200 ? 3 : c.maxWidth > 800 ? 2 : 1,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                itemCount: projects.length,
itemBuilder: (context, i) {
                  final d = projects[i];
                  final dirs = [
                    EdgeInsets.only(top: 80),
                    EdgeInsets.only(left: 80),
                    EdgeInsets.only(bottom: 80),
                    EdgeInsets.only(right: 80),
                    EdgeInsets.only(top: 60, left: 60),
                    EdgeInsets.only(bottom: 60, right: 60),
                  ];
                  return TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: Duration(milliseconds: 600 + i * 120),
                    curve: Curves.easeOutCubic,
                    builder: (context, v, child) {
                      final insets = dirs[i % dirs.length];
                      return Padding(
                        padding: EdgeInsets.only(
                          top: insets.top * (1 - v),
                          left: insets.left * (1 - v),
                          bottom: insets.bottom * (1 - v),
                          right: insets.right * (1 - v),
                        ),
                        child: Opacity(
                          opacity: v,
                          child: Transform.scale(
                            scale: 0.85 + 0.15 * v,
                            child: child,
                          ),
                        ),
                      );
                    },
                    child: ProjectCard(
                      images: d.images, projectName: d.name,
                      chips: d.chips, des: d.des,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _stats() {
    return Container(
      key: _keys["stats"],
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("metrics"),
          const SizedBox(height: 12),
          const Text("By the Numbers",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, color: WebColors.text, letterSpacing: -0.5),
          ),
          const SizedBox(height: 32),
          if (expData.isNotEmpty)
            Wrap(
              spacing: 24, runSpacing: 24,
              children: [
                StatCard(value: expData[0]['completed'] ?? '0', label: "Completed Projects", suffix: "+"),
                StatCard(value: expData[0]['happedClint'] ?? '0', label: "Client Satisfaction", suffix: "%", color: WebColors.secondary),
                StatCard(value: expData[0]['totalYear'] ?? '0', label: "Years Experience", suffix: "+", color: WebColors.tertiary),
              ],
            ),
        ],
      ),
    );
  }

  Widget _label(String t) {
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