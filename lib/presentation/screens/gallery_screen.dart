import 'package:flutter/material.dart';
import 'package:online_gallery_app/presentation/widgets/appbar.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(pageName: "Gallery"),
    );
  }
}
