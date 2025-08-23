import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

class RowButton extends StatefulWidget {
  final bool isMobile;
  final VoidCallback autoScroller;
  final VoidCallback addUserData;

  const RowButton({super.key, required this.isMobile,required this.addUserData,required this.autoScroller});

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

  Widget buildButton({required String text, required bool filled,required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: filled ? WebColors.buttonColor : Colors.transparent,
          border: Border.all(color: WebColors.buttonColor, width: 2),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: WebColors.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30, left: widget.isMobile ? 0 : 128),
      child: SlideTransition(
        position: _slideAnimation,
        child: Row(
          children: [
            buildButton(text: "Got a project?", filled: true, onTap: widget.addUserData),
            const SizedBox(width: 15),
            buildButton(text: "Show projects", filled: false, onTap: widget.autoScroller),
          ],
        ),
      ),
    );
  }
}
