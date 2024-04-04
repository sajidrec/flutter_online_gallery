import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_gallery_app/presentation/utils/app_color_utils.dart';
import 'package:online_gallery_app/presentation/widgets/appbar.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  XFile? _pickedImage;
  bool _uploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(pageName: "Upload"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Visibility(
          visible: !_uploading,
          replacement: Center(
            child: CircularProgressIndicator(
              color: AppColorsUtil.appColor,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_pickedImage?.name ?? ""),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  _getImageFromGallery();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  width: double.infinity,
                  height: 45,
                  child: Center(
                    child: Wrap(
                      children: [
                        Icon(
                          Icons.add,
                          color: AppColorsUtil.appTextColor,
                          size: 26,
                        ),
                        Text(
                          "Select File",
                          style: TextStyle(
                              color: AppColorsUtil.appTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  // color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  if (_pickedImage == null) {
                    Get.snackbar("Nothing selected", "Please select first",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.black,
                        colorText: AppColorsUtil.appTextColor);
                  } else {
                    _uploading = true;
                    setState(() {});

                    final storageRef = FirebaseStorage.instance.ref();
                    final mountainsRef = storageRef.child(_pickedImage!.name);
                    final mountainImagesRef =
                        storageRef.child(_pickedImage!.path);
                    assert(mountainsRef.name == mountainImagesRef.name);
                    assert(mountainsRef.fullPath != mountainImagesRef.fullPath);

                    String filePath = _pickedImage!.path;
                    File file = File(filePath);

                    try {
                      await mountainsRef.putFile(file);
                      Get.snackbar("Success", "Upload Successful",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: AppColorsUtil.appTextColor);
                      _pickedImage = null;
                      setState(() {});
                    } catch (e) {
                      if (mounted) {
                        Get.snackbar("Failed", "Upload Failed",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: Colors.red,
                            colorText: AppColorsUtil.appTextColor);
                      }
                    }

                    _uploading = false;
                    setState(() {});
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  width: double.infinity,
                  height: 45,
                  child: Center(
                    child: Wrap(
                      children: [
                        Icon(
                          Icons.upload,
                          color: AppColorsUtil.appTextColor,
                          size: 26,
                        ),
                        Text(
                          "Upload",
                          style: TextStyle(
                              color: AppColorsUtil.appTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  // color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }
}
