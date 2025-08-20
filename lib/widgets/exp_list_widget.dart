import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class ExpListWidget extends StatelessWidget {
  ExpListWidget({super.key});
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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WebColors.expColor,
      child: ScrollLoopAutoScroll(
        scrollDirection: Axis.horizontal,
        delay: const Duration(milliseconds: 100),
        gap: 20,
        reverseScroll: true,
        duplicateChild: 25,
        enableScrollInput: false,
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
    );
  }
}
