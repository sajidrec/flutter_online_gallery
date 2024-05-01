import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_gallery_app/presentation/controllers/upload_screen_controller.dart';
import 'package:online_gallery_app/presentation/utils/app_color_utils.dart';
import 'package:online_gallery_app/presentation/widgets/appbar.dart';
import 'package:online_gallery_app/presentation/widgets/circular_center_loader.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(pageName: "Upload"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<UploadScreenController>(
            builder: (uploadScreenController) {
          return Visibility(
            visible: !uploadScreenController.uploadingProgress,
            replacement: circularCenterLoader(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(uploadScreenController.pickedImage?.name ?? ""),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    await uploadScreenController.getImageFromGallery();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColorsUtil.appColor,
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
                    if (uploadScreenController.pickedImage == null) {
                      Get.snackbar(
                        "Nothing selected",
                        "Please select first",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.grey.withOpacity(.7),
                        colorText: AppColorsUtil.appTextColor,
                      );
                    } else {
                      await uploadScreenController.uploadFileToServer();
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColorsUtil.appColor,
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
          );
        }),
      ),
    );
  }
}
