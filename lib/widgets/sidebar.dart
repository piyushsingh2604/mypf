import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../theme/app_colors.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  bool _showContacts = false;

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 1024;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: isWide ? null : double.infinity,
      constraints: isWide ? const BoxConstraints(maxWidth: 300) : null,
      decoration: BoxDecoration(
        color: AppColors.eerieBlack2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.jet),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 24,
            offset: const Offset(-4, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          if (_showContacts || isWide) ...[
            const _Separator(),
            _buildContactList(),
            const _Separator(),
            _buildSocialLinks(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [AppColors.gradientOnyxLight, AppColors.gradientOnyxDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Text("PS", style: GoogleFonts.poppins(
                  fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.orangeYellowCrayola,
                )),
              ),
            ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Piyush Singh",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white2,
                    letterSpacing: -0.25,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.onyx,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Flutter Developer",
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w300,
                      color: AppColors.white1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).size.width <= 1024)
            GestureDetector(
              onTap: () => setState(() => _showContacts = !_showContacts),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.gradientOnyxLight,
                      AppColors.gradientOnyxDark,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: Icon(
                  _showContacts ? Icons.expand_less : Icons.expand_more,
                  color: AppColors.orangeYellowCrayola,
                  size: 24,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContactList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          _contactItem(
            Icons.email_outlined,
            "Email",
            "singhpiyush2604@gmail.com",
          ),
          const SizedBox(height: 16),
          _contactItem(Icons.phone_android_outlined, "Phone", "+91 8983302922"),
          const SizedBox(height: 16),
          _contactItem(
            Icons.calendar_month_outlined,
            "Birthday",
            "April 26, 2008",
          ),
          const SizedBox(height: 16),
          _contactItem(
            Icons.location_on_outlined,
            "Location",
            "Mumbai, India 401303",
          ),
        ],
      ),
    );
  }

  Widget _contactItem(IconData icon, String title, String value) {
    return Row(
      children: [
        _iconBox(icon),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w300,
                  color: AppColors.lightGray70,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _iconBox(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [AppColors.gradientOnyxLight, AppColors.gradientOnyxDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: const Offset(-4, 8),
          ),
        ],
      ),
      child: Center(
        child: Icon(icon, size: 16, color: AppColors.orangeYellowCrayola),
      ),
    );
  }

  Widget _buildSocialLinks() {
    const links = [
      _SocialInfo("GitHub", "https://github.com/piyushsingh2604", 'assets/icons/github.svg'),
      _SocialInfo("LinkedIn", "https://www.linkedin.com/in/piyush-singh-028582259", 'assets/icons/linkedin.svg'),
      _SocialInfo("Instagram", "https://www.instagram.com/piyushhh.dev", 'assets/icons/instagram.svg'),
      _SocialInfo("X", "https://x.com/VLOKING1", 'assets/icons/x.svg'),
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 22, bottom: 4),
      child: Row(
        children: links.map((s) => Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () => launchUrl(Uri.parse(s.url)),
            child: SvgPicture.asset(s.assetPath, width: 18, height: 18,
              colorFilter: const ColorFilter.mode(AppColors.lightGray70, BlendMode.srcIn)),
          ),
        )).toList(),
      ),
    );
  }
}

class _SocialInfo {
  final String label;
  final String url;
  final String assetPath;
  const _SocialInfo(this.label, this.url, this.assetPath);
}

class _Separator extends StatelessWidget {
  const _Separator();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.jet,
      margin: const EdgeInsets.symmetric(vertical: 16),
    );
  }
}
