import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../services/firestore_service.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 768;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader("Contact"),
          const SizedBox(height: 30),
          _contactForm(isTablet),
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

  Widget _contactForm(bool isTablet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Contact Form",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: AppColors.white2,
          ),
        ),
        const SizedBox(height: 20),
        Form(
          key: _formKey,
          child: Column(
            children: [
              if (isTablet)
                Row(
                  children: [
                    Expanded(child: _buildTextField(_nameCtrl, "Full name", isEmail: false)),
                    const SizedBox(width: 25),
                    Expanded(child: _buildTextField(_emailCtrl, "Email address", isEmail: true)),
                  ],
                )
              else ...[
                _buildTextField(_nameCtrl, "Full name", isEmail: false),
                const SizedBox(height: 25),
                _buildTextField(_emailCtrl, "Email address", isEmail: true),
              ],
              const SizedBox(height: 25),
              TextFormField(
                controller: _messageCtrl,
                maxLines: 5,
                minLines: 4,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white2,
                ),
                decoration: _inputDecoration("Your Message"),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return "Message is required";
                  if (v.trim().length < 10) return "Message must be at least 10 characters";
                  return null;
                },
              ),
              const SizedBox(height: 25),
              Align(
                alignment: isTablet ? Alignment.centerRight : Alignment.center,
                child: Container(
                  width: isTablet ? null : double.infinity,
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: ElevatedButton.icon(
                    onPressed: _sending
                        ? null
                        : () async {
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
                                  const SnackBar(content: Text("Message sent!")),
                                );
                                _nameCtrl.clear();
                                _emailCtrl.clear();
                                _messageCtrl.clear();
                              } catch (e) {
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Failed to send: $e")),
                                );
                              } finally {
                                if (mounted) setState(() => _sending = false);
                              }
                            }
                          },
                    icon: const Icon(Icons.send, size: 16),
                    label: Text(
                      "Send Message",
                      style: GoogleFonts.poppins(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      backgroundColor: AppColors.orangeYellowCrayola,
                      foregroundColor: AppColors.smokyBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.white2,
      ),
      decoration: _inputDecoration(hint),
      validator: (v) {
        if (v == null || v.trim().isEmpty) return "$hint is required";
        if (isEmail) {
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(v.trim())) {
            return "Enter a valid email address";
          }
        } else {
          if (v.trim().length < 2) return "Name must be at least 2 characters";
        }
        return null;
      },
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.lightGray70,
      ),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.jet),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.jet),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.orangeYellowCrayola),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.bittersweetShimmer),
      ),
    );
  }
}