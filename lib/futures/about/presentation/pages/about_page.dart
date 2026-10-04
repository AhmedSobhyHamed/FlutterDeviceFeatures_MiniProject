import 'package:flutter/material.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/domain/device_info.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/domain/device_info_interface.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/presentation/widgets/about_col.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key, required});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  late DeviceInfoInterface _deviceInfo;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    _deviceInfo = await DeviceInfo.instance();
    final captured = await _deviceInfo.captureDeviceInfo();
    setState(() {
      _isLoading = false;
      if (!captured) {
        _errorMessage = 'Failed to capture device info';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        actions: [
          IconButton(onPressed: () {
            Navigator.pop(context);
          }, icon: const Icon(Icons.close)),
        ],
      ),
      body:  _isLoading ? const Center(child: CircularProgressIndicator()) : _errorMessage != null ? Center(child: Text(_errorMessage!)) : _buildDeviceInfo(),
    );
  }

  Widget _buildDeviceInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 24,
      children: [
        AboutColumn(deviceInfo: _deviceInfo),
        ElevatedButton(onPressed: () {
          Navigator.pop(context);
        }, child: const Text('OK')),
      ]
    );
  }
}