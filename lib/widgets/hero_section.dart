import 'package:flutter/material.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:mypf/add_user_info_web.dart';
import 'package:mypf/add_user_info_mobile.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onGoToProjects;
  final bool isMobile;

  const HeroSection({
    super.key,
    required this.onGoToProjects,
    this.isMobile = false,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatCtrl;

  @override
  void initState() {
    super.initState();
    _floatCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 6))
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Container(
      height: widget.isMobile ? null : h,
      padding: EdgeInsets.symmetric(
        horizontal: widget.isMobile ? 24 : 80,
        vertical: widget.isMobile ? 48 : 0,
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          widget.isMobile ? _buildMobile() : _buildDesktop(),
          Positioned(
            right: widget.isMobile ? 0 : 80,
            top: 60,
            child: AnimatedBuilder(
              animation: _floatCtrl,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _floatCtrl.value * 15),
                  child: _glowCircle(widget.isMobile ? 40 : 80, WebColors.primary),
                );
              },
            ),
          ),
          Positioned(
            right: widget.isMobile ? 20 : 200,
            bottom: 100,
            child: AnimatedBuilder(
              animation: _floatCtrl,
              builder: (context, _) {
                return Transform.translate(
                  offset: Offset(0, _floatCtrl.value * -12),
                  child: _glowCircle(widget.isMobile ? 30 : 50, WebColors.secondary),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktop() {
    return Row(
      children: [
        Expanded(flex: 7, child: _buildContent()),
        Expanded(flex: 3, child: _buildSidePanel()),
      ],
    );
  }

  Widget _buildMobile() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [_buildContent()],
    );
  }

  Widget _buildContent() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: widget.isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        _badge(),
        const SizedBox(height: 28),
        Text(
          "Hi, I'm",
          style: TextStyle(
            fontSize: widget.isMobile ? 20 : 28,
            fontWeight: FontWeight.w300,
            color: isDark ? WebColors.textMuted : WebColors.textLightMuted,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 4),
        ShaderMask(
          shaderCallback: (b) => const LinearGradient(
            colors: [WebColors.primary, WebColors.secondary, WebColors.tertiary],
          ).createShader(b),
          child: Text(
            "Piyush Singh",
            style: TextStyle(
              fontSize: widget.isMobile ? 56 : 88,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.0,
              letterSpacing: -2.5,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 4, height: 4,
              decoration: BoxDecoration(
                color: WebColors.primary, shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "Flutter Developer & UI Architect",
              style: TextStyle(
                fontSize: widget.isMobile ? 15 : 18,
                fontWeight: FontWeight.w500,
                color: isDark ? WebColors.text : WebColors.textLight,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          "I craft premium cross-platform experiences\nwith Flutter, Firebase, and modern tooling.",
          textAlign: widget.isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontSize: 15,
            height: 1.7,
            color: (isDark ? WebColors.textMuted : WebColors.textLightMuted)
                .withValues(alpha: 0.85),
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          alignment: widget.isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _btn("Start a Project", () {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => widget.isMobile ? AddUserInfoMobile() : AddUserInfoWeb(),
              ));
            }, true),
            _btn("View Projects", widget.onGoToProjects, false),
          ],
        ),
      ],
    );
  }

  Widget _badge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: WebColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: WebColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8, height: 8,
            decoration: const BoxDecoration(
              color: WebColors.tertiary, shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Available for work",
            style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500, color: WebColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _btn(String label, VoidCallback onTap, bool filled) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: filled ? WebColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: filled ? Colors.transparent : WebColors.glass,
            width: 1.5,
          ),
          boxShadow: filled
              ? [BoxShadow(
                  color: WebColors.primary.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                )]
              : null,
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildSidePanel() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _codeCard(),
          const SizedBox(height: 24),
          _statusRow(),
        ],
      ),
    );
  }

  Widget _codeCard() {
    return AnimatedBuilder(
      animation: _floatCtrl,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, -_floatCtrl.value * 12),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1117),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: WebColors.glass),
              boxShadow: [
                BoxShadow(
                  color: WebColors.primary.withValues(alpha: 0.06),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _codeDotRow(),
                const SizedBox(height: 12),
                _codeLine(WebColors.secondary, "class", " Developer", " {"),
                _codeLine(null, "  ", null),
                _codeLine(WebColors.tertiary, "  name", ': "Piyush Singh",'),
                _codeLine(WebColors.primary, "  role", ': "Flutter Developer",'),
                _codeLine(WebColors.secondary, "  stack", ': ["Flutter", "Dart", "Firebase"],'),
                _codeLine(WebColors.tertiary, "  status", ': "available",'),
                _codeLine(null, "  ", null),
                _codeLine(null, "}", null),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _codeDotRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 8, height: 8,
          decoration: BoxDecoration(color: const Color(0xFFFF5F56), shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Container(width: 8, height: 8,
          decoration: BoxDecoration(color: const Color(0xFFFFBD2E), shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Container(width: 8, height: 8,
          decoration: BoxDecoration(color: const Color(0xFF27C93F), shape: BoxShape.circle)),
      ],
    );
  }

  Widget _codeLine(Color? color, String text, [String? suffix, String? suffix2]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (color != null)
            Text(text, style: TextStyle(
              color: color, fontSize: 11, fontFamily: 'monospace', fontWeight: FontWeight.w600,
              letterSpacing: -0.2,
            ))
          else
            Text(text, style: TextStyle(
              color: WebColors.textMuted.withValues(alpha: 0.3), fontSize: 11, fontFamily: 'monospace',
            )),
          if (suffix != null)
            Flexible(child: Text(suffix, style: TextStyle(
              color: WebColors.text.withValues(alpha: 0.7), fontSize: 11, fontFamily: 'monospace',
            ))),
          if (suffix2 != null)
            Text(suffix2, style: TextStyle(
              color: WebColors.text.withValues(alpha: 0.5), fontSize: 11, fontFamily: 'monospace',
            )),
        ],
      ),
    );
  }

  Widget _statusRow() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: WebColors.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: WebColors.primary.withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7, height: 7,
            decoration: BoxDecoration(
              color: WebColors.tertiary, shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: WebColors.tertiary.withValues(alpha: 0.5),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Open to work",
            style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500,
              color: WebColors.text.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(width: 20),
          Icon(Icons.arrow_outward, size: 14, color: WebColors.primary),
        ],
      ),
    );
  }

  Widget _glowCircle(double size, Color color) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withValues(alpha: 0.15), blurRadius: 60, spreadRadius: 20),
        ],
        color: color.withValues(alpha: 0.05),
      ),
    );
  }
}