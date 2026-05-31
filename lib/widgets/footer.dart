import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final bool mobile;
  const Footer({super.key, this.mobile = false});

  static const _links = [
    ("https://cdn.jsdelivr.net/npm/simple-icons@latest/icons/instagram.svg", "https://www.instagram.com/piyushhh.dev?igsh=MTl5cG1kdWlxcnRzYw=="),
    ("https://cdn.jsdelivr.net/npm/simple-icons@latest/icons/x.svg", "https://x.com/VLOKING1"),
    ("https://cdn.jsdelivr.net/npm/simple-icons@latest/icons/linkedin.svg", "https://www.linkedin.com/in/piyush-singh-028582259"),
    ("https://cdn.jsdelivr.net/npm/simple-icons@latest/icons/github.svg", "https://github.com/piyushsingh2604"),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: mobile ? 24 : 80, vertical: 48),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: WebColors.glass)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _links.asMap().entries.map((e) => Padding(
              padding: EdgeInsets.only(left: e.key == 0 ? 0 : 14),
              child: _socialIcon(e.value.$1, e.value.$2),
            )).toList(),
          ),
          const SizedBox(height: 28),
          Container(width: 2, height: 24, color: WebColors.glass),
          const SizedBox(height: 20),
          const Text("Piyush Singh", style: TextStyle(
            color: WebColors.text, fontSize: 15, fontWeight: FontWeight.w700,
          )),
          const SizedBox(height: 4),
          Text("Built with Flutter", style: TextStyle(
            fontSize: 13, color: WebColors.textMuted.withValues(alpha: 0.6),
          )),
          const SizedBox(height: 20),
          Text("© ${DateTime.now().year}", style: TextStyle(
            fontSize: 12, color: WebColors.textMuted.withValues(alpha: 0.4),
          )),
        ],
      ),
    );
  }

  Widget _socialIcon(String svgUrl, String linkUrl) {
    return GestureDetector(
      onTap: () async {
        try {
          await launchUrl(Uri.parse(linkUrl), mode: LaunchMode.platformDefault);
        } catch (_) {}
      },
      child: Container(
        width: 40, height: 40,
        decoration: BoxDecoration(
          color: WebColors.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.network(
            svgUrl,
            colorFilter: const ColorFilter.mode(WebColors.primary, BlendMode.srcIn),
            fit: BoxFit.contain,
            placeholderBuilder: (_) => const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}