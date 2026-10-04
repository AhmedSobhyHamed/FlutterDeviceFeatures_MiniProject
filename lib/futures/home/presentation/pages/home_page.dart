import 'package:flutter/material.dart';
import 'package:flutterdevicefeatures_miniproject/futures/home/presentation/widgets/menu_buttom.dart';
import 'package:flutterdevicefeatures_miniproject/futures/home/presentation/widgets/side_menu.dart';
import 'package:flutterdevicefeatures_miniproject/futures/auth/presentation/pages/profile_page.dart';
import 'package:flutterdevicefeatures_miniproject/futures/auth/domain/auth_finger.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildHomePage(context);
  }

  Widget _buildHomePage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device control'),
        automaticallyImplyLeading: false,
        leading: MenuButtom(),
        actions: [
          IconButton(
            onPressed: () => _navigateToProfile(context),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      drawer: SideMenu(),
      body: _buildDeviceInfo(),
    );
  }

  Widget _buildDeviceInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home_bkg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(child: Text('Device control')),
        ],
      ),
    );
  }

  void _navigateToProfile(BuildContext context) async {
    final authFinger = await AuthFinger.instance();
    if (!authFinger.canAuthenticate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fingerprint authentication not supported')),
      );
      return;
    }
    final result = await authFinger.addFingerprint();
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fingerprint authentication failed')),
      );
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Fingerprint authentication successful')),
      );
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
  }
}