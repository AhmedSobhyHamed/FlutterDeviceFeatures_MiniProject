import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/domain/device_info_interface.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/data/android_info.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/data/linux_info.dart';
import 'package:flutterdevicefeatures_miniproject/futures/about/data/web_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class DeviceInfo implements DeviceInfoInterface {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static DeviceInfo? _instance;
  late Map<String, dynamic> _deviceData;

  DeviceInfo._();

  static Future<DeviceInfo> instance() async {
    if (_instance == null) {
      _instance = DeviceInfo._();
    }
    return _instance!;
  }

  @override
  Future<bool> captureDeviceInfo() async {
    try {
      _deviceData = await _initPlatformState();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  String getDeviceId() => _deviceData['id'] as String? ?? '';

  @override
  String getDeviceName() => _deviceData['name'] as String? ?? '';

  @override
  String getDeviceManufacturer() => _deviceData['manufacturer'] as String? ?? '';

  @override
  String getDeviceModel() => _deviceData['model'] as String? ?? '';

  @override
  String getDeviceOperatingSystem() => _deviceData['operatingSystem'] as String? ?? '';

  @override
  String getDeviceOperatingSystemVersion() => _deviceData['operatingSystemVersion'] as String? ?? '';

  @override
  String getDeviceOperatingSystemBuildVersion() => _deviceData['operatingSystemBuildVersion'] as String? ?? '';

  @override
  String getDeviceOperatingSystemBuildNumber() => _deviceData['operatingSystemBuildNumber'] as String? ?? '';

  @override
  String getDeviceOperatingSystemBuildId() => _deviceData['operatingSystemBuildId'] as String? ?? '';

  @override
  String getDeviceOperatingSystemBuildVariant() => _deviceData['operatingSystemBuildVariant'] as String? ?? '';

  Future<Map<String, dynamic>> _initPlatformState() async {
    try {
      if (kIsWeb) {
        return WebInfo.fromDevice(await _deviceInfoPlugin.webBrowserInfo).toMap();
      } else {
        return switch (defaultTargetPlatform) {
          TargetPlatform.android => AndroidInfo.fromDevice(
            await _deviceInfoPlugin.androidInfo,
          ).toMap(),
          TargetPlatform.linux => LinuxInfo.fromDevice(
            await _deviceInfoPlugin.linuxInfo,
          ).toMap(),
          TargetPlatform.iOS => throw Exception('iOS platform isn\'t supported'),
          TargetPlatform.macOS => throw Exception('macOS platform isn\'t supported'),
          TargetPlatform.windows => throw Exception('Windows platform isn\'t supported'),
          TargetPlatform.fuchsia => throw Exception('Fuchsia platform isn\'t supported'),
        };
      }
    } on PlatformException {
      return <String, dynamic>{
        'Error:': 'Failed to get platform version.',
      };
    } catch (e) {
      return <String, dynamic>{
        'Error:': e.toString(),
      };
    }

  }

}