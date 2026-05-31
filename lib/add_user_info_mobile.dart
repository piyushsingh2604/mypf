import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserInfoMobile extends StatefulWidget {
  const AddUserInfoMobile({super.key});

  @override
  State<AddUserInfoMobile> createState() => _AddUserInfoMobileState();
}

class _AddUserInfoMobileState extends State<AddUserInfoMobile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController extraController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? WebColors.backgroundDark : WebColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        title: Text(
          "Back",
          style: TextStyle(
            fontSize: 16,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [WebColors.accent, WebColors.accentSecondary],
                ).createShader(bounds),
                child: const Text(
                  "Let's Collaborate",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Fill in the details and I'll get back to you shortly",
                style: TextStyle(
                  fontSize: 14,
                  color: isDark
                      ? WebColors.textSecondary
                      : WebColors.textDarkSecondary,
                ),
              ),
              const SizedBox(height: 32),
              TextFormField(
                inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "your@email.com",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter your Email";
                  final emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return "Enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: nameController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                ],
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Your name",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return "Enter your Name";
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(' '),
                  FilteringTextInputFormatter.allow(RegExp(r'^\+?[0-9]*$')),
                ],
                controller: phoneController,
                keyboardType: TextInputType.phone,
                maxLength: 15,
                decoration: const InputDecoration(
                  counterText: "",
                  labelText: "Phone",
                  hintText: "+91XXXXXXXXXX",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter your Phone Number with country code";
                  }
                  final phoneRegex = RegExp(r'^\+[0-9]{7,15}$');
                  if (!phoneRegex.hasMatch(value)) {
                    return "Enter a valid number with country code";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: extraController,
                maxLines: 4,
                minLines: 3,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: "Project Details",
                  hintText: "Tell me about your requirements...",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please tell us about your requirements";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              Obx(
                () => GestureDetector(
                  onTap: isLoading.value
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            isLoading.value = true;
                            await FirebaseFirestore.instance
                                .collection('clints_info')
                                .add({
                              'name': nameController.text,
                              'email': emailController.text,
                              'number': phoneController.text,
                              'about': extraController.text,
                            });
                            isLoading.value = false;
                            Get.snackbar(
                              "Success",
                              "Your info has been saved!",
                              backgroundColor: WebColors.accentTertiary,
                              colorText: Colors.white,
                            );
                            nameController.clear();
                            emailController.clear();
                            phoneController.clear();
                            extraController.clear();
                            Navigator.pop(context);
                          } else {
                            log("validation failed");
                          }
                        },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: WebColors.accent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color:
                              WebColors.accent.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: isLoading.value
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            )
                          : const Text(
                              "Send Message",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
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