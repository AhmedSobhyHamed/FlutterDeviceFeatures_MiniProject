import 'package:flutter/material.dart';
import 'package:flutterdevicefeatures_miniproject/futures/auth/domain/auth_finger.dart';

class AddAuthPage extends StatefulWidget {
  const AddAuthPage({super.key});

  @override
  State<AddAuthPage> createState() => _AddAuthPageState();
}

class _AddAuthPageState extends State<AddAuthPage> {
  AuthFinger? _authFinger;
  int _pagestage = 1;

  @override
  void initState() {
    super.initState();
    initAuthFinger();
  }

  void initAuthFinger() async {
    final authFinger = await AuthFinger.instance();
    await authFinger!.refreshFingerprintList();
    if (!mounted) return;
    setState(() {
      _authFinger = authFinger;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildAddAuthPage(context);
  }

  Widget _buildAddAuthPage(BuildContext context) {
    if (_authFinger == null) {
      return const Center(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Auth'),
      ),
      body: _pagestage == 1 && _authFinger!.canAuthenticate() ? _buildAddAuthPage1(context) : _buildAddAuthPage2(context),
    );
  }

  Widget _buildAddAuthPage1(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Scan your fingerprint to add to the system'),
          ElevatedButton(
            onPressed: () async {
              final result = await _authFinger!.addFingerprint();
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
              await _authFinger!.refreshFingerprintList();
              if (!mounted) return;
              setState(() {
                _pagestage = 2;
              });
            },
            child: Text('Scan Fingerprint'),
          ),
          // _buildFingerprintList(),
        ],
      ),
    );
  }

  Widget _buildAddAuthPage2(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Fingerprint added successfully'),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _pagestage = 1;
              });
            },
            child: Text('Add Another Fingerprint'),
          ),
          // _buildFingerprintList(),
        ],
      ),
    );
  }

  Widget _buildFingerprintList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _authFinger!.getFingerprintList().length,
      itemBuilder: (context, index) {
        return Center(child: Text(_authFinger!.getFingerprintList()[index].toString()));
      },
    );
  }
}