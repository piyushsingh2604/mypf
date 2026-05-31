import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

class StatCounterWidget extends StatefulWidget {
  final String value;
  final String label;
  final String suffix;
  final IconData icon;
  final Color iconColor;

  const StatCounterWidget({
    super.key,
    required this.value,
    required this.label,
    required this.suffix,
    this.icon = Icons.code_rounded,
    this.iconColor = WebColors.primary,
  });

  @override
  State<StatCounterWidget> createState() => _StatCounterWidgetState();
}

class _StatCounterWidgetState extends State<StatCounterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final numValue = double.tryParse(widget.value) ?? 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: (isDark ? WebColors.cardDark : WebColors.cardLight),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: 0.06),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: widget.iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(widget.icon, color: widget.iconColor, size: 20),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      final display = (numValue * _animation.value).round();
                      return Text(
                        "$display",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? WebColors.textPrimary
                              : WebColors.textDark,
                          letterSpacing: -0.5,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 2),
                  Text(
                    widget.suffix,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: widget.iconColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 13,
                  color: isDark
                      ? WebColors.textSecondary
                      : WebColors.textDarkSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}