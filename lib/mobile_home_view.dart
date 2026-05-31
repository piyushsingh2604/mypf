import 'package:cloud_firestore/cloud_firestore.dart';
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

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({super.key});
  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView> {
  List expData = [];
  RxBool loading = false.obs;
  List<ProjectModel> projects = [];
  final _scroll = ScrollController();

  final Map<String, GlobalKey> _keys = {
    "home": GlobalKey(), "skills": GlobalKey(),
    "projects": GlobalKey(), "stats": GlobalKey(), "contact": GlobalKey(),
  };

  @override
  void initState() {
    super.initState();
    _fetch();
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

  void _go(String s) {
    final c = _keys[s]?.currentContext;
    if (c != null) Scrollable.ensureVisible(c, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
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
                        HeroSection(key: _keys["home"], onGoToProjects: () => _go("projects"), isMobile: true),
                        _div(),
                        SkillSection(key: _keys["skills"], isMobile: true),
                        _div(),
                        _projects(),
                        _div(),
                        _stats(),
                        _div(),
                        ContactSection(key: _keys["contact"], isMobile: true),
                        const SizedBox(height: 40),
                        Footer(mobile: true),
                      ],
                    ),
                  ),
                ),
                Positioned(top: 0, left: 0, right: 0,
                  child: GlassNav(active: "home", keys: _keys, mobile: true),
                ),
              ],
            ),
      ),
    );
  }

  Widget _div() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      height: 1, color: WebColors.glass,
    );
  }

  Widget _projects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      key: _keys["projects"],
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("portfolio"),
              const SizedBox(height: 12),
              const Text("Featured Work",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700,
                  color: WebColors.text,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ListView.builder(
          itemCount: projects.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, i) {
            final d = projects[i];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ProjectCard(
                images: d.images, projectName: d.name, chips: d.chips, des: d.des,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _stats() {
    return Container(
      key: _keys["stats"],
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label("metrics"),
          const SizedBox(height: 12),
          const Text("By the Numbers",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: WebColors.text),
          ),
          const SizedBox(height: 24),
          if (expData.isNotEmpty)
            Wrap(
              spacing: 16, runSpacing: 16,
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