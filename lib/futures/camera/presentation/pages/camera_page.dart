import 'package:flutter/material.dart';
import 'package:flutterdevicefeatures_miniproject/futures/camera/domain/camera.dart';
import 'package:flutterdevicefeatures_miniproject/futures/camera/presentation/widgets/control_bar.dart';
import 'package:flutterdevicefeatures_miniproject/futures/camera/presentation/widgets/camera_view.dart';
import 'dart:io';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<File> _files = [];

  void _addFiles(List<File> picked) {
    if (picked.isEmpty) return;
    setState(() {
      _files = [..._files, ...picked];
    });
  }

  void _clearFiles() {
    setState(() {
      _files.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Page'),
        actions: [
          IconButton(onPressed: _clearFiles, icon: const Icon(Icons.clear)),
          IconButton(onPressed: () {
            _files.clear();
            Navigator.pop(context);
          }, icon: const Icon(Icons.arrow_back)),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(child: CameraView(files: _files)),
            ControlBar(addFiles: _addFiles),
          ],
        ),
      ),
    );
  }
}