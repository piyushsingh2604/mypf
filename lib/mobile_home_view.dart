import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypf/models/project_model.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/widgets/name_widget.dart';
import 'package:mypf/widgets/total_work_widget.dart';
import 'package:mypf/work_view.dart';

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({super.key});

  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView> {
  List expData = [];
  RxBool isLoading = false.obs;

  List<ProjectModel> projectList = [];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _projectsKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
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
    return Scaffold(
      backgroundColor: WebColors.backroundColor,
      body: Obx(
        () => isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.only(top: 25, bottom: 10),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Piyush Singh",
                              style: TextStyle(
                                color: WebColors.textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),
                      Center(
                        child: MobileNameWidget(
                          onGoToProjects: _scrollToProjects,
                        ),
                      ),
                      Container(
                        key: _projectsKey,
                        child: ListView.builder(
                          itemCount: projectList.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final data = projectList[index];
                            return Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Center(
                                child: WhatsAppImageGrid(
                                  images: data.images,
                                  projectName: data.name,
                                  chips: data.chips,
                                  des: data.des,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 90),
                      Center(
                        child: Text(
                          "About",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            color: WebColors.textColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "Hi, I'm Piyush Singh, a passionate Flutter developer with 3+ years "
                            "of experience in app development. I specialize in building clean, "
                            "responsive, and scalable applications using Flutter, Firebase, and REST APIs. "
                            "I enjoy turning creative ideas into real products, contributing to open source, "
                            "and constantly learning new tools to improve my craft.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.5,
                              color: WebColors.textColor.withOpacity(0.9),
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          left: 35,
                          right: 55,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          right: 35,
                          left: 35,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            showAbout(
                              num: expData[0]['totalYear'],
                              title: "Years of",
                              subTitle: "experience",
                              symbol: '+',
                            ),
                            showAbout(
                              num: "",
                              title: "",
                              subTitle: "",
                              symbol: '',
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
}
