import 'package:flutter/material.dart';
import 'package:online_gallery_app/presentation/widgets/appbar.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(pageName: "Image View"),
      body: Center(
        child: SingleChildScrollView(
          child: Image.network(
            imageUrl,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
