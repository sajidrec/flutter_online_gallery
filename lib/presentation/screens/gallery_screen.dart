import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:online_gallery_app/presentation/utils/app_color_utils.dart';
import 'package:online_gallery_app/presentation/widgets/appbar.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<List<String>> _listOfAllImages = [];
  bool _networkLoading = false;

  @override
  void initState() {
    super.initState();
    _getAllItemLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(pageName: "Gallery"),
      body: Visibility(
        visible: !_networkLoading,
        replacement: Center(
          child: CircularProgressIndicator(
            color: AppColorsUtil.appColor,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () => _getAllItemLists(),
          child: (_listOfAllImages.isEmpty)
              ? const Center(
                  child: Text("No Item Found"),
                )
              : GridView.builder(
                  itemCount: _listOfAllImages.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 135,
                          height: 135,
                          child: Stack(children: [
                            const Center(child: CircularProgressIndicator()),
                            Image.network(
                              _listOfAllImages[index][1],
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
                                      title: "Are you sure you want to delete?",
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
                                              final desertRef = FirebaseStorage
                                                  .instance
                                                  .ref()
                                                  .child(_listOfAllImages[index]
                                                      [0]);
                                              await desertRef.delete();
                                              Get.back();
                                              _getAllItemLists();
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
                                onTap: () {},
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
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
        ),
      ),
    );
  }

  Future<void> _getAllItemLists() async {
    _listOfAllImages.clear();
    _networkLoading = true;
    setState(() {});

    final Reference storageRef = FirebaseStorage.instance.ref();
    final ListResult listResult = await storageRef.listAll();
    for (Reference item in listResult.items) {
      _listOfAllImages.add([item.name, await item.getDownloadURL()]);
    }
    _networkLoading = false;
    setState(() {});
  }
}
