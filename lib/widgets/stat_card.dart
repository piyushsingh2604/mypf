import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

class StatCard extends StatefulWidget {
  final String value;
  final String label;
  final String suffix;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.value,
    required this.label,
    required this.suffix,
    this.icon = Icons.code_rounded,
    this.color = WebColors.primary,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic);
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = double.tryParse(widget.value) ?? 0;
    return AnimatedBuilder(
      animation: _anim,
      builder: (context, _) {
        final display = (n * _anim.value).round();
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          decoration: BoxDecoration(
            color: WebColors.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: WebColors.glass),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48, height: 48,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(widget.icon, color: widget.color, size: 22),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "$display",
                        style: const TextStyle(
                          fontSize: 32, fontWeight: FontWeight.w800,
                          color: WebColors.text, letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Text(
                        widget.suffix,
                        style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w700,
                          color: widget.color,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 13, color: WebColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}