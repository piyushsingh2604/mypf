import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../services/firestore_service.dart';
import '../widgets/section_heading.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: AppColors.backgroundAlt,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              const SectionHeading(
                label: 'CONTACT',
                title: 'Get in touch',
                subtitle: 'Have a project in mind? Let\'s talk about it.',
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isDesktop = constraints.maxWidth > 800;
                  if (isDesktop) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _contactForm()),
                        const SizedBox(width: 48),
                        Expanded(child: _contactInfo()),
                      ],
                    );
                  }
                  return Column(
                    children: [
                      _contactForm(),
                      const SizedBox(height: 40),
                      _contactInfo(),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactForm() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a message',
              style: GoogleFonts.dmSans(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 24),
            _buildTextField(_nameCtrl, 'Full name', isEmail: false),
            const SizedBox(height: 16),
            _buildTextField(_emailCtrl, 'Email address', isEmail: true),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageCtrl,
              maxLines: 5,
              minLines: 4,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
              decoration: _inputDecoration('Your message'),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'Message is required';
                if (v.trim().length < 10) return 'Message must be at least 10 characters';
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: GestureDetector(
                onTap: _sending ? null : _submitForm,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: _sending ? AppColors.textLight : AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.send, size: 16, color: AppColors.textOnAccent),
                        const SizedBox(width: 8),
                        Text(
                          _sending ? 'Sending...' : 'Send Message',
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textOnAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _sending = true);
      try {
        await FirestoreService.submitContact(
          name: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          message: _messageCtrl.text.trim(),
        );
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Message sent successfully!', style: GoogleFonts.dmSans()),
            backgroundColor: AppColors.successText,
          ),
        );
        _nameCtrl.clear();
        _emailCtrl.clear();
        _messageCtrl.clear();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send: $e', style: GoogleFonts.dmSans()),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) setState(() => _sending = false);
      }
    }
  }

  Widget _contactInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: GoogleFonts.dmSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Feel free to reach out. I\'m always open to discussing new projects and opportunities.',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.textMuted,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 32),
        _contactInfoItem(Icons.email_outlined, 'Email', 'singhpiyush2604@gmail.com'),
        const SizedBox(height: 20),
        _contactInfoItem(Icons.phone_outlined, 'Phone', '+91 8983302922'),
        const SizedBox(height: 20),
        _contactInfoItem(Icons.location_on_outlined, 'Location', 'Mumbai, India 401303'),
        const SizedBox(height: 20),
        _contactInfoItem(Icons.calendar_today_outlined, 'Birthday', 'April 26, 2008'),
      ],
    );
  }

  Widget _contactInfoItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.accentLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Icon(icon, size: 20, color: AppColors.accent),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.dmSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textLight,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController ctrl, String hint, {required bool isEmail}) {
    return TextFormField(
      controller: ctrl,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      inputFormatters: isEmail
          ? [FilteringTextInputFormatter.deny(RegExp(r'\s'))]
          : null,
      style: GoogleFonts.dmSans(
        fontSize: 14,
        color: AppColors.textPrimary,
      ),
      decoration: _inputDecoration(hint),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return '$hint is required';
        if (isEmail) {
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(v.trim())) {
            return 'Enter a valid email address';
          }
        } else {
          if (v.trim().length < 2) return 'Name must be at least 2 characters';
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.dmSans(
        fontSize: 14,
        color: AppColors.textLight,
      ),
      filled: true,
      fillColor: AppColors.background,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }
}