import 'package:flutter/material.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/domain/device_info_interface.dart';

class AboutColumn extends StatelessWidget {
  const AboutColumn({super.key, required DeviceInfoInterface deviceInfo}) : _deviceInfo = deviceInfo;
  final DeviceInfoInterface _deviceInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        // Center(child: Text('Device ID: ${_deviceInfo.getDeviceId()}')),
        Center(child: Text('Device Name: ${_deviceInfo.getDeviceName()}')),
        Center(child: Text('Device Manufacturer: ${_deviceInfo.getDeviceManufacturer()}')),
        // Center(child: Text('Device Model: ${_deviceInfo.getDeviceModel()}')),
        Center(child: Text('Device Operating System: ${_deviceInfo.getDeviceOperatingSystem()}')),
        Center(child: Text('Device Operating System Version: ${_deviceInfo.getDeviceOperatingSystemVersion()}')),
        // Center(child: Text('Device Operating System Build Version: ${_deviceInfo.getDeviceOperatingSystemBuildVersion()}')),
        // Center(child: Text('Device Operating System Build Number: ${_deviceInfo.getDeviceOperatingSystemBuildNumber()}')),
      ],
    );
  }
}