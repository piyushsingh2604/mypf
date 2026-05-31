import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';

class GlassNav extends StatelessWidget {
  final String active;
  final Map<String, GlobalKey> keys;
  final bool mobile;

  const GlassNav({
    super.key,
    required this.active,
    required this.keys,
    this.mobile = false,
  });

  void _go(String s) {
    final k = keys[s]?.currentContext;
    if (k != null) {
      Scrollable.ensureVisible(k, duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: WebColors.bg.withValues(alpha: 0.8),
        border: Border(bottom: BorderSide(color: WebColors.glass)),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: mobile ? 16 : 80),
            child: Row(
              children: [
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: WebColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text("PS", style: TextStyle(
                      color: WebColors.primary, fontSize: 12, fontWeight: FontWeight.w800,
                    )),
                  ),
                ),
                const SizedBox(width: 10),
                Text("Piyush Singh", style: TextStyle(
                  color: WebColors.textMuted, fontSize: 13, fontWeight: FontWeight.w500,
                )),
                const Spacer(),
                if (!mobile)
                  ...keys.keys.map((s) => _btn(s, _fmt(s), active == s, () => _go(s))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _btn(String key, String label, bool active, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: active ? WebColors.primary.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: active ? Border.all(color: WebColors.primary.withValues(alpha: 0.2)) : null,
        ),
        child: Text(label, style: TextStyle(
          color: active ? WebColors.primary : WebColors.textMuted,
          fontSize: 13,
          fontWeight: active ? FontWeight.w600 : FontWeight.w400,
        )),
      ),
    );
  }

  String _fmt(String s) => s == "home" ? "Home" : s[0].toUpperCase() + s.substring(1);
}