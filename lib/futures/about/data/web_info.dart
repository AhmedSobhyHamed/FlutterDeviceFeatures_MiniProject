import 'package:flutterdevicefeatures_miniproject/futures/about/domain/device_info_interface.dart';
import 'package:device_info_plus/device_info_plus.dart';

class WebInfo {
  final String? browserName;
  final String? appCodeName;
  final String? appName;
  final String? appVersion;
  final double? deviceMemory;
  final String? language;
  final List<String>? languages;
  final String? platform;
  final String? product;
  final String? productSub;
  final String? userAgent;
  final String? vendor;
  final String? vendorSub;
  final int? hardwareConcurrency;
  final int? maxTouchPoints;

  WebInfo({
    required this.browserName,
    required this.appCodeName,
    required this.appName,
    required this.appVersion,
    required this.deviceMemory,
    required this.language,
    required this.languages,
    required this.platform,
    required this.product,
    required this.productSub,
    required this.userAgent,
    required this.vendor,
    required this.vendorSub,
    required this.hardwareConcurrency,
    required this.maxTouchPoints,
  });

  factory WebInfo.fromDevice(WebBrowserInfo data) {
    return WebInfo(
      browserName: data.browserName.name,
      appCodeName: data.appCodeName,
      appName: data.appName,
      appVersion: data.appVersion,
      deviceMemory: data.deviceMemory,
      language: data.language,
      languages: _copyList(data.languages),
      platform: data.platform,
      product: data.product,
      productSub: data.productSub,
      userAgent: data.userAgent,
      vendor: data.vendor,
      vendorSub: data.vendorSub,
      hardwareConcurrency: data.hardwareConcurrency,
      maxTouchPoints: data.maxTouchPoints,
    );
  }

  factory WebInfo.fromMap(Map<String, dynamic> map) {
    return WebInfo(
      browserName: map['browserName'] as String?,
      appCodeName: map['appCodeName'] as String?,
      appName: map['appName'] as String?,
      appVersion: map['appVersion'] as String?,
      deviceMemory: (map['deviceMemory'] as num?)?.toDouble(),
      language: map['language'] as String?,
      languages: _listFromMap(map['languages']),
      platform: map['platform'] as String?,
      product: map['product'] as String?,
      productSub: map['productSub'] as String?,
      userAgent: map['userAgent'] as String?,
      vendor: map['vendor'] as String?,
      vendorSub: map['vendorSub'] as String?,
      hardwareConcurrency: map['hardwareConcurrency'] as int?,
      maxTouchPoints: map['maxTouchPoints'] as int?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'browserName': browserName,
      'appCodeName': appCodeName,
      'appName': appName,
      'appVersion': appVersion,
      'deviceMemory': deviceMemory,
      'language': language,
      'languages': languages,
      'platform': platform,
      'product': product,
      'productSub': productSub,
      'userAgent': userAgent,
      'vendor': vendor,
      'vendorSub': vendorSub,
      'hardwareConcurrency': hardwareConcurrency,
      'maxTouchPoints': maxTouchPoints,

      'id': userAgent,
      'name': browserName,
      'manufacturer': vendor,
      'model': appName,
      'operatingSystem': platform,
      'operatingSystemVersion': appVersion,
      'operatingSystemBuildVersion': productSub,
      'operatingSystemBuildNumber': productSub,
      'operatingSystemBuildId': userAgent,
      'operatingSystemBuildVariant': browserName,
    };
  }

  static List<String>? _copyList(List<dynamic>? list) {
    if (list == null) return null;
    return list.map((value) => value.toString()).toList();
  }
  static List<String>? _listFromMap(dynamic value) {
    if (value is! List) return null;
    return value.map((item) => item as String).toList();
  }
}
