import 'package:flutter/material.dart';
import 'package:online_gallery_app/presentation/screens/gallery_screen.dart';
import 'package:online_gallery_app/presentation/screens/upload_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;
  
  final List<Widget> _screens = [
    const UploadScreen(),
    const GalleryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int itemNumber) {
            _selectedIndex = itemNumber;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.upload),
              label: "Upload",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.photo),
              label: "Gallery",
            ),
          ]),
    );
  }
}
