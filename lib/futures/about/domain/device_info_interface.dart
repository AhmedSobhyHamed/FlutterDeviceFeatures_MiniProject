abstract interface class DeviceInfoInterface {
  Future<bool> captureDeviceInfo();
  String getDeviceId();
  String getDeviceName();
  String getDeviceManufacturer();
  String getDeviceModel();
  String getDeviceOperatingSystem();
  String getDeviceOperatingSystemVersion();
  String getDeviceOperatingSystemBuildVersion();
  String getDeviceOperatingSystemBuildNumber();
}