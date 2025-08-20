import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/widgets/name_widget.dart';
import 'package:mypf/widgets/total_work_widget.dart';

class MobileHomeView extends StatefulWidget {
  const MobileHomeView({super.key});

  @override
  State<MobileHomeView> createState() => _MobileHomeViewState();
}

class _MobileHomeViewState extends State<MobileHomeView> {
  List expData = [];
  RxBool isLoading = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfirebaseData();
  }

  Future<void> getfirebaseData() async {
    isLoading.value = true;
    final response = await FirebaseFirestore.instance
        .collection('piyush_data')
        .get();

    expData = response.docs.map((doc) => doc.data()).toList();
    isLoading.value = false;
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

                      const SizedBox(height: 30),
                      Center(child: MobileNameWidget()),
                      // SizedBox(height: 40,),
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
                            textAlign: TextAlign.center, // ← Center the text
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
