import 'dart:io';

import 'package:apex_logistics/components/defaultSnackBar.dart';
import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/models/profile.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

class ProfileController extends GetxController {
  Rx<File?> selectedPic = Rx<File?>(null);
  RxString image = ''.obs;
  RxBool showSelectionCard = false.obs;
  var profileSnapshot = ProfileModel().obs;
  // var readOnly = List.generate(2, (index) => true.obs);

  RxBool nameReadOnly = true.obs;
  RxBool emailReadOnly = true.obs;
  RxBool isClicked = false.obs;
  RxBool editable = false.obs;
  Rx<Color> nameBorderColor = Constants.whiteNormal.obs;
  Rx<Color> emailBorderColor = Constants.whiteNormal.obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  Widget btnLoading(String text) {
    if (isClicked.value) {
      return const Center(
          child: CircularProgressIndicator(
        color: Constants.whiteNormal,
      ));
    } else {
      return DefaultText(
        text: text,
        fontColor: Colors.white,
        size: 18.0,
        align: TextAlign.center,
      );
    }
  }

  nameToggleEdit() {
    nameReadOnly.value = !nameReadOnly.value;
    if (nameReadOnly.value == false) {
      editable.value = true;
      nameBorderColor.value = Constants.primaryNormal;
    } else {
      editable.value = false;
      nameBorderColor.value = Constants.whiteNormal;
    }
  }

  emailToggleEdit() {
    emailReadOnly.value = !emailReadOnly.value;
    if (emailReadOnly.value == false) {
      editable.value = true;
      emailBorderColor.value = Constants.primaryNormal;
    } else {
      editable.value = false;
      emailBorderColor.value = Constants.whiteNormal;
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    image.value = profileSnapshot.value.image;
    name.text = profileSnapshot.value.name!;
    email.text = profileSnapshot.value.email!;
    phone.text = profileSnapshot.value.phone!;
  }

  Future getImage(context, ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imgPerm = await saveImagePermanent(image.path);
      selectedPic.value = imgPerm;
      showSelectionCard.value = false;
    } catch (e) {
      defaultSnackBar(context, false, "An error occurred: $e");
      CustomSnackBar.error(message: "An error occurred: $e");
    }
  }

  Future saveImagePermanent(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(imagePath);
    final image = File("${directory.path}/$name");

    return File(imagePath).copy(image.path);
  }
}
