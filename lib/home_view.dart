import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/widgets/name_widget.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController _containerController;
  late AnimationController _aboutController;

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    final List<String> expList = [
      "Flutter",
      "Dart",
      "Firebase",
      "Git",
      "GitHub",
      "REST API",
      "SQLite",
      "Provider",
      "GetX",
      "Figma",
      "UI/UX",
    ];

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
      body: Padding(
        padding: const EdgeInsets.only(top: 25, bottom: 20, right: 20),
        child: SingleChildScrollView(
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
                  const NameWidget(),
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

              Container(
                color: WebColors.expColor,
                child: ScrollLoopAutoScroll(
                  scrollDirection: Axis.horizontal,
                  delay: const Duration(seconds: 1),
                  gap: 20,
                  reverseScroll: true,
                  duplicateChild: 25,
                  enableScrollInput: true,
                  delayAfterScrollInput: const Duration(seconds: 10),
                  duration: const Duration(seconds: 150),
                  child: Row(
                    children: expList.map((data) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: 60,
                          child: Center(
                            child: Text(
                              data,
                              style: TextStyle(
                                color: WebColors.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 60, left: 128, right: 50),
                child: AnimatedBuilder(
                  animation: _aboutController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 50 * (1 - _aboutController.value)),
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
                                color: WebColors.textColor.withOpacity(0.9),
                              ),
                            ),
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
    );
  }
}
