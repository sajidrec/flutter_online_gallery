import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_gallery_app/presentation/controllers/gallery_screen_controller.dart';
import 'package:online_gallery_app/presentation/utils/app_color_utils.dart';
import 'package:uuid/uuid.dart';

class UploadScreenController extends GetxController {
  XFile? _pickedImage;
  bool _uploading = false;

  get uploadingProgress => _uploading;

  get pickedImage => _pickedImage;

  Future<void> uploadFileToServer() async {
    _uploading = true;
    update();

    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef.child(const Uuid().v1());

    String filePath = _pickedImage!.path;
    File file = File(filePath);

    try {
      await mountainsRef.putFile(file);
      Get.snackbar("Success", "Upload Successful",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColorsUtil.appColor,
          colorText: AppColorsUtil.appTextColor);
      _pickedImage = null;

      final galleryScreenController = Get.find<GalleryScreenController>();
      galleryScreenController.getAllItemLists();

      update();
    } catch (e) {
      Get.snackbar(
        "Failed",
        "Upload Failed",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: AppColorsUtil.appTextColor,
      );
    }
    _uploading = false;
    update();
  }

  Future<void> getImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    update();
  }
}
