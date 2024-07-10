import 'package:apex_logistics/components/defaultAppBar2.dart';
import 'package:apex_logistics/components/defaultButton.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/controllers/profile_controller.dart';
import 'package:apex_logistics/main.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

class Profile extends StatelessWidget {
  Profile({super.key});

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.whiteLight,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // APP BAR
            DefaultAppBar2(
              backgroundColor: Constants.whiteLight,
              iconColor: Constants.blackDark,
              icon: Icons.arrow_back,
              onPressed: () => Get.back(),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: constraints.minHeight,
                        minWidth: constraints.minWidth),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0),
                        child: Column(
                          children: [
                            Obx(
                              () => controller.image.value == ''
                                  ? Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: ClipOval(
                                        child: Image.asset(
                                          "assets/images/rider.jpg",
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ))
                                  : Stack(clipBehavior: Clip.none, children: [
                                      Center(
                                        child: controller.selectedPic.value ==
                                                null
                                            ? ClipOval(
                                                // to be changed to user image (memory)
                                                child: Image.asset(
                                                  "assets/images/rider.jpg",
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : ClipOval(
                                                child: Image.file(
                                                  controller.selectedPic.value!,
                                                  width: 120,
                                                  height: 120,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 135,
                                        child: GestureDetector(
                                          onTap: () async {
                                            // controller.showSelectionCard.value =
                                            //     !controller
                                            //         .showSelectionCard.value;
                                            displayUploadImageOptions();
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color: Constants.primaryNormal,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: const Icon(
                                                Icons.add_a_photo_outlined,
                                                size: 20,
                                                color: Colors.white,
                                              )
                                              // SvgPicture.asset(
                                              //   "assets/images/add_camera.svg",
                                              //   height: 100,
                                              // ),
                                              ),
                                        ),
                                      ),
                                    ]),
                            ),
                            const SizedBox(height: 20.0),
                            DefaultText(
                              text: controller.profileSnapshot.value.name,
                              size: 22.0,
                              weight: FontWeight.bold,
                            ),
                            const SizedBox(height: 15.0),
                            sharedPreferences.getBool("driver")!
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      buildDriverStatistics("2.75%", "Rating"),
                                      buildDriverStatistics("50", "Accepted"),
                                      buildDriverStatistics("10", "Cancelled"),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 40.0),
                            Form(
                                child: Column(
                              children: [
                                Obx(() => ProfileTextField(
                                      controller: controller.name,
                                      labelText: "Full Name",
                                      readonly: controller.nameReadOnly.value,
                                      borderColor:
                                          controller.nameBorderColor.value,
                                      suffixIcon: SuffixIcon(
                                          toggleEdit:
                                              controller.nameToggleEdit),
                                    )),
                                const SizedBox(height: 20.0),
                                Obx(() => ProfileTextField(
                                      controller: controller.email,
                                      labelText: "Email Address",
                                      readonly: controller.emailReadOnly.value,
                                      borderColor:
                                          controller.emailBorderColor.value,
                                      suffixIcon: SuffixIcon(
                                          toggleEdit:
                                              controller.emailToggleEdit),
                                    )),
                                const SizedBox(height: 20.0),
                                ProfileTextField(
                                  controller: controller.phone,
                                  labelText: "Phone",
                                  readonly: true,
                                ),
                                const SizedBox(height: 40.0),
                                Obx(() => controller.editable.value
                                    ? DefaultButton(
                                        onPressed: () {
                                          controller.isClicked.value = true;
                                        },
                                        child: controller
                                            .btnLoading("Update Profile"))
                                    : const SizedBox.shrink())
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> displayUploadImageOptions() {
    return showDialog(
        barrierDismissible: true,
        context: Get.context!,
        builder: (context) {
          final size = MediaQuery.of(context).size;
          return Stack(
            children: [
              Positioned(
                top: size.height * 0.15,
                left: 30,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.close(1);

                            await controller.getImage(
                                context, ImageSource.gallery);
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
                            Navigator.pop(Get.context!);
                            await controller.getImage(
                                context, ImageSource.camera);
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
                ),
              )
            ],
          );
        });
  }
}

Widget buildDriverStatistics(String value, String label) {
  return Row(
    children: [
      Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Constants.whiteDark,
              borderRadius: BorderRadius.circular(50)),
          child: const Icon(Icons.star_rate_outlined, size: 20)),
      const SizedBox(width: 20),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DefaultText(
            text: value,
            weight: FontWeight.bold,
            size: 16.0,
          ),
          const SizedBox(height: 5),
          DefaultText(
            text: label,
            fontColor: Colors.grey,
            size: 16.0,
          ),
        ],
      ),

      // Row(
      //   children: [
      //     Container(
      //         padding: const EdgeInsets.all(5),
      //         decoration: BoxDecoration(
      //             color: Constants.whiteDark,
      //             borderRadius: BorderRadius.circular(50)),
      //         child: const Icon(Icons.star_rate_outlined, size: 20)),
      //     const SizedBox(width: 10.0),
      //     DefaultText(
      //       text: value,
      //       weight: FontWeight.bold,
      //       size: 16.0,
      //     )
      //   ],
      // ),
      // const SizedBox(height: 4),
      // DefaultText(
      //   text: label,
      //   fontColor: Colors.grey,
      //   size: 16.0,
      // )
    ],
  );
}

class ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool readonly;
  final VoidCallback? toggleEdit;
  final Widget? suffixIcon;
  final Color borderColor;

  const ProfileTextField(
      {super.key,
      required this.controller,
      this.labelText,
      this.readonly = false,
      this.toggleEdit,
      this.suffixIcon,
      this.borderColor = Constants.whiteNormal});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
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
          suffixIcon: suffixIcon,
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

class SuffixIcon extends StatelessWidget {
  const SuffixIcon({
    super.key,
    required this.toggleEdit,
  });

  final VoidCallback? toggleEdit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleEdit,
      child: const Icon(
        Icons.edit,
        color: Constants.primaryNormal,
      ),
    );
  }
}
