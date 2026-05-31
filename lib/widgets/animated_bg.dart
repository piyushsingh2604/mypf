import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

class AnimatedBg extends StatefulWidget {
  final Widget child;
  const AnimatedBg({super.key, required this.child});

  @override
  State<AnimatedBg> createState() => _AnimatedBgState();
}

class _AnimatedBgState extends State<AnimatedBg> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                HSLColor.fromAHSL(
                  0.06, (340 + _controller.value * 60) % 360, 0.8, 0.5,
                ).toColor(),
                HSLColor.fromAHSL(
                  0.04, (190 + _controller.value * 40) % 360, 0.7, 0.5,
                ).toColor(),
                HSLColor.fromAHSL(
                  0.03, (280 + _controller.value * 50) % 360, 0.6, 0.4,
                ).toColor(),
                Colors.transparent,
              ],
              stops: const [0.0, 0.3, 0.6, 1.0],
              radius: 1.5,
              center: Alignment(
                sin(_controller.value * 2 * pi) * 0.4,
                cos(_controller.value * 1.5 * pi) * 0.3,
              ),
            ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class GlowOrbs extends StatelessWidget {
  final Animation<double> animation;

  const GlowOrbs({super.key, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Stack(
          children: List.generate(3, (i) {
            return Positioned(
              left: 100 + sin(animation.value * 2 * pi + i * 2.1) * 300,
              top: 200 + cos(animation.value * 1.7 * pi + i * 1.3) * 200,
              child: Container(
                width: 300 + i * 100,
                height: 300 + i * 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: [
                        WebColors.primary,
                        WebColors.secondary,
                        WebColors.tertiary,
                      ][i].withValues(alpha: 0.08),
                      blurRadius: 120,
                      spreadRadius: 40,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}