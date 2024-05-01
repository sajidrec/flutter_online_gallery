import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class GalleryScreenController extends GetxController {
  static final List<List<String>> _listOfAllImages = [];

  get listOfAllImages => _listOfAllImages;

  bool _networkLoading = false;

  get networkLoadingProgress => _networkLoading;

  Future<void> getAllItemLists() async {
    _listOfAllImages.clear();
    _networkLoading = true;
    update();

    final Reference storageRef = FirebaseStorage.instance.ref();
    final ListResult listResult = await storageRef.listAll();

    for (Reference item in listResult.items) {
      _listOfAllImages.add([item.name, await item.getDownloadURL()]);
    }
    _networkLoading = false;
    update();
  }

  Future<void> deleteFIle(int index) async {
    _networkLoading = true;
    update();

    final desertRef =
        FirebaseStorage.instance.ref().child(_listOfAllImages[index][0]);
    await desertRef.delete();

    _networkLoading = false;
    update();
  }
}
