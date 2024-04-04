import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_gallery_app/app.dart';
import 'package:online_gallery_app/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const OnlineGalleryApp());
}
