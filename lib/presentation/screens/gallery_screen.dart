import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:online_gallery_app/presentation/controllers/gallery_screen_controller.dart';
import 'package:online_gallery_app/presentation/screens/image_view_screen.dart';
import 'package:online_gallery_app/presentation/utils/app_color_utils.dart';
import 'package:online_gallery_app/presentation/widgets/appbar.dart';
import 'package:online_gallery_app/presentation/widgets/circular_center_loader.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final galleryScreenController = Get.find<GalleryScreenController>();

  @override
  void initState() {
    super.initState();
    galleryScreenController.getAllItemLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(pageName: "Gallery"),
      body: GetBuilder<GalleryScreenController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.networkLoadingProgress,
            replacement: circularCenterLoader(),
            child: RefreshIndicator(
              color: AppColorsUtil.appColor,
              onRefresh: () async => await controller.getAllItemLists(),
              child: (controller.listOfAllImages.isEmpty)
                  ? Stack(
                      children: [
                        ListView(),
                        const Center(
                          child: Text(
                            "No data found",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.all(5.0),
                      itemCount: controller.listOfAllImages.length,
                      itemBuilder: (context, index) => Column(
                        children: [
                          SizedBox(
                            width: 135,
                            height: 135,
                            child: Stack(children: [
                              circularCenterLoader(),
                              Image.network(
                                controller.listOfAllImages[index][1],
                                fit: BoxFit.cover,
                                height: 135,
                                width: 135,
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 135,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.defaultDialog(
                                        title: " You sure want to delete? ",
                                        backgroundColor: Colors.white,
                                        content: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              style: const ButtonStyle(
                                                foregroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.white),
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.red),
                                              ),
                                              onPressed: () async {
                                                Get.back();
                                                await controller
                                                    .deleteFIle(index);
                                                await controller
                                                    .getAllItemLists();
                                              },
                                              child: const Text("Yes"),
                                            ),
                                            ElevatedButton(
                                              style: const ButtonStyle(
                                                backgroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.green),
                                                foregroundColor:
                                                    MaterialStatePropertyAll(
                                                        Colors.white),
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text("No"),
                                            ),
                                          ],
                                        ));
                                  },
                                  child: const SizedBox(
                                    width: 67,
                                    child: Icon(Icons.delete),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(
                                      ImageViewScreen(
                                          imageUrl: controller
                                              .listOfAllImages[index][1]),
                                    );
                                  },
                                  child: const SizedBox(
                                    width: 67,
                                    child: Icon(Icons.remove_red_eye),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                    ),
            ),
          );
        },
      ),
    );
  }
}
