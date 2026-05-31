import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContactSection extends StatefulWidget {
  final bool isMobile;
  const ContactSection({super.key, this.isMobile = false});
  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _form = GlobalKey<FormState>();
  final _n = TextEditingController();
  final _e = TextEditingController();
  final _m = TextEditingController();
  final RxBool loading = false.obs;

  @override
  void dispose() {
    _n.dispose(); _e.dispose(); _m.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_form.currentState!.validate()) return;
    loading.value = true;
    try {
      await FirebaseFirestore.instance.collection('clints_info').add({
        'name': _n.text, 'email': _e.text, 'about': _m.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      Get.snackbar("Sent!", "Thanks — I'll get back to you soon.",
        backgroundColor: WebColors.tertiary, colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      _n.clear(); _e.clear(); _m.clear();
    } catch (_) {
      Get.snackbar("Error", "Something went wrong.",
        backgroundColor: WebColors.primary, colorText: Colors.white,
      );
    }
    loading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final hp = widget.isMobile ? 24.0 : 80.0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label("contact"),
              const SizedBox(height: 12),
              Text(
                "Let's Talk",
                style: TextStyle(
                  fontSize: widget.isMobile ? 28 : 40,
                  fontWeight: FontWeight.w700,
                  color: WebColors.text,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Have a project? Let's make it real.",
                style: TextStyle(fontSize: 14, color: WebColors.textMuted),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: hp),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.isMobile) ...[
                  _field("Your Name", _n, false),
                  const SizedBox(height: 14),
                  _field("Your Email", _e, true),
                  const SizedBox(height: 14),
                  _field("Tell me about your project", _m, false, maxLines: 5),
                ] else ...[
                  Row(
                    children: [
                      Expanded(child: _field("Your Name", _n, false)),
                      const SizedBox(width: 20),
                      Expanded(child: _field("Your Email", _e, true)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _field("Tell me about your project", _m, false, maxLines: 5),
                ],
                const SizedBox(height: 28),
                _submitBtn(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _field(String label, TextEditingController c, bool email, {int maxLines = 1}) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      inputFormatters: email ? [FilteringTextInputFormatter.deny(' ')] : null,
      keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
      style: const TextStyle(color: WebColors.text),
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        labelStyle: const TextStyle(color: WebColors.textMuted),
      ),
      validator: (v) {
        if (v == null || v.isEmpty) return "Required";
        if (email) {
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(v)) {
            return "Invalid email";
          }
        }
        return null;
      },
    );
  }

  Widget _submitBtn() {
    return Obx(() => GestureDetector(
      onTap: loading.value ? null : _submit,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
        decoration: BoxDecoration(
          color: WebColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: WebColors.primary.withValues(alpha: 0.3),
              blurRadius: 24, offset: const Offset(0, 8),
            ),
          ],
        ),
        child: loading.value
            ? const SizedBox(
                width: 18, height: 18,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
              )
            : const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Send Message",
                    style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                ],
              ),
      ),
    ));
  }

  Widget _label(String t) {
    return Row(
      children: [
        Container(width: 3, height: 20, color: WebColors.primary),
        const SizedBox(width: 10),
        Text(t, style: const TextStyle(
          fontSize: 12, fontWeight: FontWeight.w600, color: WebColors.primary, letterSpacing: 2,
        )),
      ],
    );
  }
}