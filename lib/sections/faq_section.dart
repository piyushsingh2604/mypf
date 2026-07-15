import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../models/resume_data.dart';
import '../widgets/section_heading.dart';

class FaqSection extends StatefulWidget {
  const FaqSection({super.key});
  @override
  State<FaqSection> createState() => _FaqSectionState();
}

class _FaqSectionState extends State<FaqSection> {
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = List.filled(ResumeData.piyush.faqItems.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final faqItems = ResumeData.piyush.faqItems;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppColors.background,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionHeading(
                label: 'FAQ',
                title: 'Frequently Asked Questions',
                subtitle: "Got questions? I've got answers.",
              ),
              const SizedBox(height: 40),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: Column(
                    children: List.generate(faqItems.length, (i) {
                      final item = faqItems[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color: AppColors.cardBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: _expanded[i]
                                  ? AppColors.accent
                                  : AppColors.border,
                            ),
                          ),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _expanded[i] = !_expanded[i];
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 16,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.question,
                                          style: GoogleFonts.dmSans(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            color: _expanded[i]
                                                ? AppColors.textPrimary
                                                : AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                      AnimatedRotation(
                                        turns: _expanded[i] ? 0.5 : 0,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: const Icon(
                                          Icons.add,
                                          color: AppColors.accent,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              AnimatedCrossFade(
                                firstChild: const SizedBox.shrink(),
                                secondChild: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    bottom: 16,
                                  ),
                                  child: Text(
                                    item.answer,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      color: AppColors.textMuted,
                                      height: 1.7,
                                    ),
                                  ),
                                ),
                                crossFadeState: _expanded[i]
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 200),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
