import 'dart:io';

import 'package:apex_logistics/models/profile.dart';
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
  RxBool readOnly = false.obs;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    image.value = profileSnapshot.value.image;
    name.text = profileSnapshot.value.name!;
    email.text = profileSnapshot.value.email!;
    phone.text = profileSnapshot.value.phone!;
  }

  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imgPerm = await saveImagePermanent(image.path);
      selectedPic.value = imgPerm;
      showSelectionCard.value = false;
    } catch (e) {
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
