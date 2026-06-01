import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/resume_data.dart';

class ResumeSection extends StatelessWidget {
  const ResumeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final data = ResumeData.piyush;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Resume"),
          const SizedBox(height: 30),
          _educationSection(data),
          const SizedBox(height: 35),
          _experienceSection(data),
          const SizedBox(height: 35),
          _skillsSection(data),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.white2,
          ),
        ),
        const SizedBox(height: 7),
        Container(
          width: 40,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: LinearGradient(colors: AppColors.goldGradient),
          ),
        ),
      ],
    );
  }

  Widget _educationSection(ResumeData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timelineHeader(Icons.book_outlined, "Education"),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 45),
          child: Column(
            children: List.generate(data.education.length, (i) {
              return _timelineItem(
                title: data.education[i].school,
                subtitle: data.education[i].degree,
                period: data.education[i].period,
                description: data.education[i].description,
                isLast: i == data.education.length - 1,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _experienceSection(ResumeData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _timelineHeader(Icons.work_outline, "Experience"),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 45),
          child: Column(
            children: List.generate(data.experience.length, (i) {
              return _timelineItem(
                title: data.experience[i].company,
                subtitle: data.experience[i].role,
                period: data.experience[i].period,
                description: "${data.experience[i].location}\n${data.experience[i].description}",
                isLast: i == data.experience.length - 1,
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _timelineHeader(IconData icon, String title) {
    return Row(
      children: [
        _iconBox(icon),
        const SizedBox(width: 15),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.white2,
          ),
        ),
      ],
    );
  }

  Widget _timelineItem({
    required String title,
    required String subtitle,
    required String period,
    required String description,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(colors: AppColors.goldGradient),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.jet,
                        blurRadius: 4,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(width: 1, color: AppColors.jet),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  period,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: AppColors.vegasGold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: AppColors.lightGray,
                    height: 1.5,
                  ),
                ),
                if (!isLast) const SizedBox(height: 25),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _skillsSection(ResumeData data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "My skills",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.white2,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              colors: [AppColors.gradientOnyxLight, AppColors.gradientOnyxDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                blurRadius: 30,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: Column(
            children: List.generate(data.skills.length, (i) {
              return _skillBar(data.skills[i], i == data.skills.length - 1);
            }),
          ),
        ),
      ],
    );
  }

  Widget _skillBar(Skill skill, bool isLast) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                skill.name,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white2,
                ),
              ),
              const Spacer(),
              Text(
                "${skill.percentage}%",
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColors.lightGray,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.jet,
              borderRadius: BorderRadius.circular(10),
            ),
            child: FractionallySizedBox(
              widthFactor: skill.percentage / 100,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: AppColors.goldGradient),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconBox(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
        child: Icon(icon, size: 18, color: AppColors.orangeYellowCrayola),
      ),
    );
  }
}