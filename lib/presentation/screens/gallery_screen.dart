import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:online_gallery_app/presentation/utils/app_color_utils.dart';
import 'package:online_gallery_app/presentation/widgets/appbar.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final List<String> _listOfAllImages = [];
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
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 500,
                      width: 200,
                      child: Image.network(
                        _listOfAllImages[index],
                        fit: BoxFit.fill,
                      ),
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
      _listOfAllImages.add(await item.getDownloadURL());
    }
    _networkLoading = false;
    setState(() {});
  }
}
