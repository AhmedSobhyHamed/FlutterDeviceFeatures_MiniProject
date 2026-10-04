import 'package:flutterdevicefeatures_miniproject/futures/about/domain/device_info_interface.dart';
import 'package:device_info_plus/device_info_plus.dart';


class AndroidInfo {
  final String? securityPatch;
  final int? sdkInt;
  final String? release;
  final int? previewSdkInt;
  final String? incremental;
  final String? codename;
  final String? baseOS;
  final String? board;
  final String? bootloader;
  final String? brand;
  final String? device;
  final String? display;
  final String? fingerprint;
  final String? hardware;
  final String? host;
  final String? id;
  final String? manufacturer;
  final String? model;
  final String? product;
  final String? name;
  final List<String>? supported32BitAbis;
  final List<String>? supported64BitAbis;
  final List<String>? supportedAbis;
  final String? tags;
  final String? type;
  final bool? isPhysicalDevice;
  final int? freeDiskSize;
  final int? totalDiskSize;
  final List<String>? systemFeatures;
  final bool? isLowRamDevice;
  final int? physicalRamSize;
  final int? availableRamSize;

  AndroidInfo({
    required this.securityPatch,
    required this.sdkInt,
    required this.release,
    required this.previewSdkInt,
    required this.incremental,
    required this.codename,
    required this.baseOS,
    required this.board,
    required this.bootloader,
    required this.brand,
    required this.device,
    required this.display,
    required this.fingerprint,
    required this.hardware,
    required this.host,
    required this.id,
    required this.manufacturer,
    required this.model,
    required this.product,
    required this.name,
    required this.supported32BitAbis,
    required this.supported64BitAbis,
    required this.supportedAbis,
    required this.tags,
    required this.type,
    required this.isPhysicalDevice,
    required this.freeDiskSize,
    required this.totalDiskSize,
    required this.systemFeatures,
    required this.isLowRamDevice,
    required this.physicalRamSize,
    required this.availableRamSize,
  });

  factory AndroidInfo.fromDevice(AndroidDeviceInfo deviceInfo) {
    return AndroidInfo(
      securityPatch: deviceInfo.version.securityPatch,
      sdkInt: deviceInfo.version.sdkInt,
      release: deviceInfo.version.release,
      previewSdkInt: deviceInfo.version.previewSdkInt,
      incremental: deviceInfo.version.incremental,
      codename: deviceInfo.version.codename,
      baseOS: deviceInfo.version.baseOS,
      board: deviceInfo.board,
      bootloader: deviceInfo.bootloader,
      brand: deviceInfo.brand,
      device: deviceInfo.device,
      display: deviceInfo.display,
      fingerprint: deviceInfo.fingerprint,
      hardware: deviceInfo.hardware,
      host: deviceInfo.host,
      id: deviceInfo.id,
      manufacturer: deviceInfo.manufacturer,
      model: deviceInfo.model,
      product: deviceInfo.product,
      name: deviceInfo.name,
      supported32BitAbis: _copyList(deviceInfo.supported32BitAbis),
      supported64BitAbis: _copyList(deviceInfo.supported64BitAbis),
      supportedAbis: _copyList(deviceInfo.supportedAbis),
      tags: deviceInfo.tags,
      type: deviceInfo.type,
      isPhysicalDevice: deviceInfo.isPhysicalDevice,
      freeDiskSize: deviceInfo.freeDiskSize,
      totalDiskSize: deviceInfo.totalDiskSize,
      systemFeatures: _copyList(deviceInfo.systemFeatures),
      isLowRamDevice: deviceInfo.isLowRamDevice,
      physicalRamSize: deviceInfo.physicalRamSize,
      availableRamSize: deviceInfo.availableRamSize,
    );
  }

  factory AndroidInfo.fromMap(Map<String, dynamic> map) {
    return AndroidInfo(
      securityPatch: map['version.securityPatch'] as String?,
      sdkInt: map['version.sdkInt'] as int?,
      release: map['version.release'] as String?,
      previewSdkInt: map['version.previewSdkInt'] as int?,
      incremental: map['version.incremental'] as String?,
      codename: map['version.codename'] as String?,
      baseOS: map['version.baseOS'] as String?,
      board: map['board'] as String?,
      bootloader: map['bootloader'] as String?,
      brand: map['brand'] as String?,
      device: map['device'] as String?,
      display: map['display'] as String?,
      fingerprint: map['fingerprint'] as String?,
      hardware: map['hardware'] as String?,
      host: map['host'] as String?,
      id: map['id'] as String?,
      manufacturer: map['manufacturer'] as String?,
      model: map['model'] as String?,
      product: map['product'] as String?,
      name: map['name'] as String?,
      supported32BitAbis: _listFromMap(map['supported32BitAbis']),
      supported64BitAbis: _listFromMap(map['supported64BitAbis']),
      supportedAbis: _listFromMap(map['supportedAbis']),
      tags: map['tags'] as String?,
      type: map['type'] as String?,
      isPhysicalDevice: map['isPhysicalDevice'] as bool?,
      freeDiskSize: map['freeDiskSize'] as int?,
      totalDiskSize: map['totalDiskSize'] as int?,
      systemFeatures: _listFromMap(map['systemFeatures']),
      isLowRamDevice: map['isLowRamDevice'] as bool?,
      physicalRamSize: map['physicalRamSize'] as int?,
      availableRamSize: map['availableRamSize'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'version.securityPatch': securityPatch,
      'version.sdkInt': sdkInt,
      'version.release': release,
      'version.previewSdkInt': previewSdkInt,
      'version.incremental': incremental,
      'version.codename': codename,
      'version.baseOS': baseOS,
      'board': board,
      'bootloader': bootloader,
      'brand': brand,
      'device': device,
      'display': display,
      'fingerprint': fingerprint,
      'hardware': hardware,
      'host': host,
      'id': id,
      'manufacturer': manufacturer,
      'model': model,
      'product': product,
      'name': name,
      'supported32BitAbis': supported32BitAbis,
      'supported64BitAbis': supported64BitAbis,
      'supportedAbis': supportedAbis,
      'tags': tags,
      'type': type,
      'isPhysicalDevice': isPhysicalDevice,
      'freeDiskSize': freeDiskSize,
      'totalDiskSize': totalDiskSize,
      'systemFeatures': systemFeatures,
      'isLowRamDevice': isLowRamDevice,
      'physicalRamSize': physicalRamSize,
      'availableRamSize': availableRamSize,

      'operatingSystem': 'Android',
      'operatingSystemVersion': release,
      'operatingSystemBuildVersion': incremental,
      'operatingSystemBuildNumber': sdkInt?.toString() ?? '',
      'operatingSystemBuildId': id,
      'operatingSystemBuildVariant': codename,
    };
  }

  static List<String>? _copyList(List<String>? list) {
    if (list == null) return null;
    return List<String>.from(list);
  }
  static List<String>? _listFromMap(dynamic value) {
    if (value is! List) return null;
    return value.map((item) => item as String).toList();
  }
}
