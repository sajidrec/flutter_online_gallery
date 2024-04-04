import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_gallery_app/presentation/screens/main_bottom_nav_screen.dart';

class OnlineGalleryApp extends StatelessWidget {
  const OnlineGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: "Online Gallery App",
      home: MainBottomNavScreen(),
    );
  }
}
