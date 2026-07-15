import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  static const List<_SocialLink> _socialLinks = [
    _SocialLink(
      icon: Icons.code,
      url: 'https://github.com/piyushsingh2604',
    ),
    _SocialLink(
      icon: Icons.business_center,
      url: 'https://www.linkedin.com/in/piyush-singh-028582259',
    ),
    _SocialLink(
      icon: Icons.camera_alt,
      url: 'https://www.instagram.com/piyushhh.dev',
    ),
    _SocialLink(
      icon: Icons.alternate_email,
      url: 'https://x.com/VLOKING1',
    ),
  ];

  static const List<String> _navLabels = [
    'Home',
    'Services',
    'Work',
    'About',
    'FAQ',
    'Contact',
  ];

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth <= 768;

    return Container(
      width: double.infinity,
      color: AppColors.textPrimary,
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment:
                isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: [
              // Top row
              if (isMobile) ...[
                Text(
                  'Piyush Singh',
                  style: GoogleFonts.dmSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                _buildSocialIcons(),
              ] else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Piyush Singh',
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _buildSocialIcons(),
                  ],
                ),

              // Divider
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(vertical: 24),
                color: Colors.white.withValues(alpha: 0.15),
              ),

              // Bottom row
              if (isMobile) ...[
                Text(
                  '© 2025 Piyush Singh. All rights reserved.',
                  style: GoogleFonts.dmSans(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                _buildNavLinks(),
              ] else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '© 2025 Piyush Singh. All rights reserved.',
                      style: GoogleFonts.dmSans(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 13,
                      ),
                    ),
                    _buildNavLinks(),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _socialLinks.map((link) {
        return Padding(
          padding: const EdgeInsets.only(left: 8),
          child: GestureDetector(
            onTap: () => _launchUrl(link.url),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Icon(
                  link.icon,
                  color: Colors.white.withValues(alpha: 0.7),
                  size: 18,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNavLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_navLabels.length, (index) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index > 0)
              Text(
                ' · ',
                style: GoogleFonts.dmSans(
                  color: Colors.white.withValues(alpha: 0.6),
                  fontSize: 13,
                ),
              ),
            Text(
              _navLabels[index],
              style: GoogleFonts.dmSans(
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 13,
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _SocialLink {
  final IconData icon;
  final String url;

  const _SocialLink({required this.icon, required this.url});
}
