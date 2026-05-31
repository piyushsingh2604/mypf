import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

class RowButton extends StatefulWidget {
  final bool isMobile;
  final VoidCallback autoScroller;
  final VoidCallback addUserData;

  const RowButton({
    super.key,
    required this.isMobile,
    required this.addUserData,
    required this.autoScroller,
  });

  @override
  State<RowButton> createState() => _RowButtonState();
}

class _RowButtonState extends State<RowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: widget.isMobile ? 0 : 128),
      child: SlideTransition(
        position: _slideAnimation,
        child: Wrap(
          spacing: 15,
          runSpacing: 10,
          children: [
            _buildButton(
              text: "Got a project?",
              filled: true,
              onTap: widget.addUserData,
            ),
            _buildButton(
              text: "Show projects",
              filled: false,
              onTap: widget.autoScroller,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String text,
    required bool filled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          gradient: filled
              ? LinearGradient(colors: [WebColors.accent, WebColors.accentSecondary])
              : null,
          color: filled ? null : Colors.transparent,
          border: Border.all(
            color: filled ? Colors.transparent : WebColors.accent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: WebColors.accent.withValues(alpha: 0.25),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}