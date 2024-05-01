import 'package:get/get.dart';
import 'package:online_gallery_app/presentation/controllers/gallery_screen_controller.dart';
import 'package:online_gallery_app/presentation/controllers/upload_screen_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(GalleryScreenController());
    Get.put(UploadScreenController());
  }
}
