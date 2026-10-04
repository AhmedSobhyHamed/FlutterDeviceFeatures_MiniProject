import 'package:flutter/material.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/presentation/pages/about_page.dart';
import 'package:flutterdevicefeatures_miniproject/futures/auth/presentation/pages/add_auth.dart';
import 'package:flutterdevicefeatures_miniproject/futures/camera/presentation/pages/camera_page.dart';
import 'package:flutterdevicefeatures_miniproject/futures/map/presentation/pages/map_page.dart';
import 'package:flutterdevicefeatures_miniproject/futures/audio/presentation/pages/sound_player.dart';

class SideMenu extends StatelessWidget {
  final List<Map<String, dynamic>> _sideMenuItems = [
    {
      'title': 'About',
      'page': AboutPage(),
      'icon': Icons.info,
    },
    {
      'title': 'Add Auth',
      'page': AddAuthPage(),
      'icon': Icons.fingerprint,
    },
    {
      'title': 'Camera',
      'page': CameraPage(),
      'icon': Icons.camera,
    },
    {
      'title': 'Map',
      'page': MapPage(),
      'icon': Icons.map,
    },
    {
      'title': 'Sound Player',
      'page': SoundPlayerPage(),
      'icon': Icons.music_note,
    },
  ];
  SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildSideMenu(context);
  }

  Widget _buildSideMenu(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              ..._sideMenuItems.map((item) => _buildSideMenuItems(context, item['title'] as String, item['page'] as Widget, item['icon'] as IconData)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSideMenuItems(BuildContext context, String title, Widget page, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
    );
  }
}