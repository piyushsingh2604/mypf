import 'package:flutter/material.dart';
import 'package:mypf/add_user_info_mobile.dart';
import 'package:mypf/add_user_info_web.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/widgets/exp_list_widget.dart';
import 'package:mypf/widgets/row_button.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';

class NameWidget extends StatelessWidget {
  final VoidCallback onGoToProjects;

  const NameWidget({super.key, required this.onGoToProjects});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 130),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IntrinsicWidth(
                      child: OffsetText(
                        text: 'Hello',
                        duration: const Duration(seconds: 1),
                        type: AnimationType.word,
                        slideType: SlideAnimationType.rightLeft,
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 35,
                          color: WebColors.textColor,
                        ),
                      ),
                    ),

                    Transform.translate(
                      offset: const Offset(-6, 8),
                      child: OffsetText(
                        text: '.',
                        duration: const Duration(seconds: 1),
                        type: AnimationType.word,
                        slideType: SlideAnimationType.rightLeft,
                        textStyle: TextStyle(
                          fontSize: 60,
                          color: WebColors.buttonColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.translate(
                offset: const Offset(0, 8),
                child: Container(
                  width: 149,
                  height: 3,
                  color: WebColors.buttonColor,
                ),
              ),

              const SizedBox(width: 10),

              OffsetText(
                text: "I'm Piyush",
                duration: const Duration(seconds: 1),
                type: AnimationType.word,
                slideType: SlideAnimationType.leftRight,
                textStyle: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                  color: WebColors.textColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 128),
            child: OffsetText(
              text: "Software Developer",
              duration: const Duration(seconds: 1),
              type: AnimationType.word,
              slideType: SlideAnimationType.rightLeft,
              textStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: WebColors.textColor,
              ),
            ),
          ),
          RowButton(
            isMobile: false,
            addUserData: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddUserInfoWeb()),
              );
            },
            autoScroller: onGoToProjects,
          ),
        ],
      ),
    );
  }
}

class MobileNameWidget extends StatelessWidget {
  final VoidCallback onGoToProjects;

  const MobileNameWidget({super.key, required this.onGoToProjects});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hello with dot
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min, // shrink to content
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IntrinsicWidth(
                  child: OffsetText(
                    text: 'Hello',
                    duration: const Duration(seconds: 2), // longer
                    type: AnimationType.word,
                    slideType: SlideAnimationType.rightLeft,
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                      color: WebColors.textColor,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: const Offset(-6, 8),
                  child: OffsetText(
                    text: '.',
                    duration: const Duration(seconds: 2), // longer
                    type: AnimationType.word,
                    slideType: SlideAnimationType.rightLeft,
                    textStyle: TextStyle(
                      fontSize: 60,
                      color: WebColors.buttonColor,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 1),

          // "I'm Piyush"
          Center(
            child: OffsetText(
              text: "I'm Piyush",
              duration: const Duration(seconds: 2), // longer
              type: AnimationType.word,
              slideType: SlideAnimationType.leftRight,
              textStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w500,
                color: const Color.fromARGB(219, 255, 255, 255),
              ),
            ),
          ),

          const SizedBox(height: 3),

          // Divider line
          Center(
            child: Container(
              width: 100,
              height: 3,
              color: WebColors.buttonColor,
            ),
          ),

          const SizedBox(height: 1),

          // "Software Developer"
          Center(
            child: OffsetText(
              text: "Software Developer",
              duration: const Duration(seconds: 2), // longer
              type: AnimationType.word,
              slideType: SlideAnimationType.rightLeft,
              textStyle: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w700,
                color: WebColors.textColor,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Button row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RowButton(
                isMobile: true,
                addUserData: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUserInfoMobile(),
                    ),
                  );
                },
                autoScroller: onGoToProjects,
              ),
            ],
          ),
          SizedBox(height: 9),
          Stack(
            children: [
              // Image background
              Container(
                height: 310,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/WhatsApp Image 2025-08-24 at 8.10.11 PM.jpeg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Top gradient overlay - fades over 10% from top to bottom
              Container(
                height: 310,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF121F28),
                      Colors.transparent, // fully transparent after 10%
                    ],
                    stops: [0.0, 0.1], // fade within 10% height
                  ),
                ),
              ),

              // Left gradient overlay - fades over 20% from left to right
              Container(
                height: 310,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF121F28).withValues(alpha: 1.0), // strong dark on left
                      Colors.transparent, // fully transparent after 20%
                    ],
                    stops: [0.0, 0.2], // fade within 20% width
                  ),
                ),
              ),
            ],
          ),
          ExpListWidget(),
        ],
      ),
    );
  }
}
