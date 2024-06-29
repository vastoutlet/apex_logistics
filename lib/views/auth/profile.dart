import 'dart:convert';

import 'package:apex_logistics/components/defaultForm.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/profile_controller.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        child: Column(
          children: [
            Obx(() => controller.image.value == ''
                ? Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/rider.jpg",
                        width: 170,
                        height: 170,
                        fit: BoxFit.cover,
                      ),
                    ))
                : Stack(clipBehavior: Clip.none, children: [
                    Center(
                      child: controller.selectedPic.value == null
                          ? ClipOval(
                              // to be changed to user image (memory)
                              child: Image.asset(
                                "assets/images/rider.jpg",
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            )
                          : ClipOval(
                              child: Image.file(
                                controller.selectedPic.value!,
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 100,
                      child: GestureDetector(
                        onTap: () async {
                          controller.showSelectionCard.value =
                              !controller.showSelectionCard.value;
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Constants.primaryNormal,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/add_camera.svg",
                          ),
                        ),
                      ),
                    ),
                    controller.showSelectionCard.value
                        ? Positioned(
                            bottom: -30,
                            left: 10,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        await controller
                                            .getImage(ImageSource.gallery);
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.image, size: 30),
                                          SizedBox(width: 10.0),
                                          DefaultText(text: "Gallery"),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 20.0),
                                    InkWell(
                                      onTap: () async {
                                        await controller
                                            .getImage(ImageSource.camera);
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(Icons.camera_alt, size: 30),
                                          SizedBox(width: 10.0),
                                          DefaultText(text: "Camera"),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        : Container()
                  ])),
            const SizedBox(height: 20.0),
            DefaultText(
              text: controller.profileSnapshot.value.name,
              size: 18.0,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 40.0),
            Form(
                child: Column(
              children: [
                ProfileTextField(
                  controller: controller.name,
                  labelText: "Full Name",
                ),
                const SizedBox(height: 20.0),
                ProfileTextField(
                  controller: controller.email,
                  labelText: "Email Address",
                ),
                const SizedBox(height: 20.0),
                ProfileTextField(
                  controller: controller.phone,
                  labelText: "Phone",
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  const ProfileTextField(
      {super.key,
      required this.controller,
      this.labelText,
      this.readonly = false});

  final TextEditingController controller;
  final String? labelText;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Constants.whiteNormal),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        readOnly: readonly,
        decoration: InputDecoration(
          hintText: labelText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          border: InputBorder.none,
          label: DefaultText(
            text: labelText,
            weight: FontWeight.bold,
          ),
          suffixIcon: const Icon(
            Icons.edit,
            color: Constants.primaryNormal,
          ),
          fillColor: Constants.whiteNormal,
          filled: true,
          focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
