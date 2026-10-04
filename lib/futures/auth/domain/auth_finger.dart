import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class AuthFinger {
  bool _hasFingerScanner = false;
  late LocalAuthentication _auth;
  static AuthFinger? _instance;
  List<BiometricType> _fingerprintList = [];

  AuthFinger._();

  static Future<AuthFinger> instance() async {
    if (_instance == null) {
      _instance = AuthFinger._();
      await _instance!.init();
    }
    return _instance!;
  }

  Future<void> init() async {
    _auth = LocalAuthentication();
    _hasFingerScanner = await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
  }

  bool canAuthenticate() {
    return _hasFingerScanner;
  }

  Future<void> refreshFingerprintList() async {
    _fingerprintList = await _auth.getAvailableBiometrics();
  }
  
  List<BiometricType> getFingerprintList() => _fingerprintList;

  Future<bool> addFingerprint() async {
    final result = await _auth.authenticate(
      localizedReason: 'Authenticate to add fingerprint',
      biometricOnly: true,
      authMessages: <AuthMessages>[
        AndroidAuthMessages(
          signInTitle: 'Sign in with fingerprint',
          cancelButton: 'thanks',
        ),
      ],
    );
    return result;
  }
}