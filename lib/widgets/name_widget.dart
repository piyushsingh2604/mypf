import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/widgets/row_button.dart';
import 'package:pretty_animated_text/pretty_animated_text.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({super.key});

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
          RowButton(),
        ],
      ),
    );
  }
}
