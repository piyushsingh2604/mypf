import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypf/models/project_model.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/widgets/exp_list_widget.dart';
import 'package:mypf/widgets/name_widget.dart';
import 'package:mypf/widgets/total_work_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mypf/work_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  List expData = [];

  RxBool isLoading = false.obs;
  late AnimationController _containerController;
  late AnimationController _aboutController;
  List<ProjectModel> projectList = [];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    getAllData();
    _containerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();

    _aboutController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) _aboutController.forward();
    });
  }

  @override
  void dispose() {
    _containerController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> getAllData() async {
    isLoading.value = true;

    await getfirebaseData();
    await getProjects();
    isLoading.value = false;
  }

  Future<void> getfirebaseData() async {
    final response = await FirebaseFirestore.instance
        .collection('piyush_data')
        .get();

    expData = response.docs.map((doc) => doc.data()).toList();
  }

  Future<void> getProjects() async {
    final response = await FirebaseFirestore.instance
        .collection('project_data')
        .get();

    projectList = response.docs
        .map((doc) => ProjectModel.fromJson(doc.data()))
        .toList();
  }

  void _scrollToProjects() {
    final context = _projectsKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double containerWidth = MediaQuery.of(context).size.width;
    double getResponsiveWidth(double containerWidth) {
      if (containerWidth > 1000) {
        return 400;
      } else if (containerWidth > 600) {
        return 300;
      } else {
        return 100;
      }
    }

    return Scaffold(
      backgroundColor: WebColors.backroundColor,
      body: Obx(
        () => isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 20, right: 20),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 130),
                        child: Text(
                          "Piyush Singh",
                          style: TextStyle(
                            color: WebColors.textColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NameWidget(onGoToProjects: _scrollToProjects),
                          ScaleTransition(
                            scale: CurvedAnimation(
                              parent: _containerController,
                              curve: Curves.easeOutBack,
                            ),
                            child: FadeTransition(
                              opacity: _containerController,
                              child: Container(
                                height: containerWidth > 750 ? 400 : 200,
                                width: containerWidth > 750 ? 400 : 200,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),

                      ExpListWidget(),
                      Padding(
                        key: _projectsKey,
                        padding: const EdgeInsets.all(20),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return MasonryGridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: constraints.maxWidth > 1200
                                  ? 3
                                  : constraints.maxWidth > 800
                                  ? 2
                                  : 1,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              itemCount: projectList.length,
                              itemBuilder: (context, index) {
                                final data = projectList[index];
                                return WhatsAppImageGrid(
                                  images: data.images,
                                  projectName: data.name,
                                  chips: data.chips,
                                  des: data.des,
                                );
                              },
                            );
                          },
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 60,
                          left: 128,
                          right: 50,
                        ),
                        child: AnimatedBuilder(
                          animation: _aboutController,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(
                                0,
                                50 * (1 - _aboutController.value),
                              ),
                              child: Opacity(
                                opacity: _aboutController.value,
                                child: child,
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'assets/Slice 1(2).png',
                                fit: BoxFit.cover,
                                width: 200,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "About",
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w700,
                                      color: WebColors.textColor,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: getResponsiveWidth(containerWidth),

                                    child: Text(
                                      "Hi, I'm Piyush Singh, a passionate Flutter developer with 3+ years "
                                      "of experience in app development. I specialize in building clean, "
                                      "responsive, and scalable applications using Flutter, Firebase, and REST APIs. "
                                      "I enjoy turning creative ideas into real products, contributing to open source, "
                                      "and constantly learning new tools to improve my craft.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                        color: WebColors.textColor.withOpacity(
                                          0.9,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Wrap(
                                    spacing: 40,
                                    runSpacing: 40,
                                    children: [
                                      showAbout(
                                        num: expData[0]['completed'],
                                        title: "Completed",
                                        subTitle: "Projects",
                                        symbol: '+',
                                      ),
                                      showAbout(
                                        num: expData[0]['happedClint'],
                                        title: "Client",
                                        subTitle: "satisfaction",
                                        symbol: '%',
                                      ),
                                      showAbout(
                                        num: expData[0]['totalYear'],
                                        title: "Years of",
                                        subTitle: "experience",
                                        symbol: '+',
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
