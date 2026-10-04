import 'package:flutterdevicefeatures_miniproject/futures/about/domain/device_info_interface.dart';
import 'package:device_info_plus/device_info_plus.dart';


class LinuxInfo {
  final String? name;
  final String? version;
  final String? id;
  final List<String>? idLike;
  final String? versionCodename;
  final String? versionId;
  final String? prettyName;
  final String? buildId;
  final String? variant;
  final String? variantId;
  final String? machineId;

  LinuxInfo({
    required this.name,
    required this.version,
    required this.id,
    required this.idLike,
    required this.versionCodename,
    required this.versionId,
    required this.prettyName,
    required this.buildId,
    required this.variant,
    required this.variantId,
    required this.machineId,
  });

  factory LinuxInfo.fromDevice(LinuxDeviceInfo data) {
    return LinuxInfo(
      name: data.name,
      version: data.version,
      id: data.id,
      idLike: _copyList(data.idLike),
      versionCodename: data.versionCodename,
      versionId: data.versionId,
      prettyName: data.prettyName,
      buildId: data.buildId,
      variant: data.variant,
      variantId: data.variantId,
      machineId: data.machineId,
    );
  }

  factory LinuxInfo.fromMap(Map<String, dynamic> map) {
    return LinuxInfo(
      name: map['name'] as String?,
      version: map['version'] as String?,
      id: map['id'] as String?,
      idLike: _listFromMap(map['idLike']),
      versionCodename: map['versionCodename'] as String?,
      versionId: map['versionId'] as String?,
      prettyName: map['prettyName'] as String?,
      buildId: map['buildId'] as String?,
      variant: map['variant'] as String?,
      variantId: map['variantId'] as String?,
      machineId: map['machineId'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'version': version,
      'id': id,
      'idLike': idLike,
      'versionCodename': versionCodename,
      'versionId': versionId,
      'prettyName': prettyName,
      'buildId': buildId,
      'variant': variant,
      'variantId': variantId,
      'machineId': machineId,

      'operatingSystem': name,
      'operatingSystemVersion': version,
      'operatingSystemBuildVersion': versionId,
      'operatingSystemBuildNumber': versionId,
      'operatingSystemBuildId': buildId,
      'operatingSystemBuildVariant': variant,
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
