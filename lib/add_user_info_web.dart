import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mypf/utils/web_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUserInfoWeb extends StatefulWidget {
  const AddUserInfoWeb({super.key});

  @override
  State<AddUserInfoWeb> createState() => _AddUserInfoWebState();
}

class _AddUserInfoWebState extends State<AddUserInfoWeb> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController extraController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: WebColors.backroundColor,
      appBar: AppBar(
        backgroundColor: WebColors.backroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Back", style: TextStyle(fontSize: 20)),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text("Add Details", style: TextStyle(fontSize: 24)),
                const SizedBox(height: 25),

                // Email
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.deny(' ')],
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    decoration: const InputDecoration(
                      label: Text("Enter your Email"),
                      hintText: "Enter your Email",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff22d292)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter your Email";
                      }
                      final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                      );
                      if (!emailRegex.hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Name + Phone in Row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.text,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\s]'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            label: Text("Enter your Name"),
                            hintText: "Enter your Name",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff22d292)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your Name";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(' '),
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\+?[0-9]*$'),
                            ),
                          ],

                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          maxLength: 15,
                          decoration: const InputDecoration(
                            counterText: "",
                            label: Text("Enter your Phone Number"),
                            hintText: "+91XXXXXXXXXX",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xff22d292)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your Phone Number with country code";
                            }

                            final phoneRegex = RegExp(r'^\+[0-9]{7,15}$');
                            if (!phoneRegex.hasMatch(value)) {
                              return "Enter a valid number with country code (e.g. +91XXXXXXXXXX)";
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                  child: TextFormField(
                    controller: extraController,
                    maxLines: 4,
                    minLines: 3,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      label: Text("Tell us about your requirements"),
                      hintText: "Your requirements",
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff22d292)),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please tell us about your requirements";
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.09),
                  child: Obx(
                    () => InkWell(
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
                                Get.snackbar("Success", "info saved");
                                nameController = TextEditingController(
                                  text: "",
                                );
                                emailController = TextEditingController(
                                  text: "",
                                );
                                phoneController = TextEditingController(
                                  text: "",
                                );
                                extraController = TextEditingController(
                                  text: "",
                                );

                                Navigator.pop(context);
                              } else {
                                log("validation failed");
                              }
                            },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color(0xff22d292),
                        ),
                        child: Center(
                          child: isLoading.value
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )
                              : const Text(
                                  "Save Info",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
