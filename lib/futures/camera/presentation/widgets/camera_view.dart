import 'package:flutter/material.dart';
import 'dart:io';

class CameraView extends StatelessWidget {
  final List<File> _files;

  CameraView({super.key, required List<File> files}): _files = files;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _files.length,
      itemBuilder: (context, index) {
        final file = _files[index];
        final path = file.path.toLowerCase();
        if (path.endsWith('.jpg') || path.endsWith('.jpeg') || path.endsWith('.png') || path.endsWith('.gif') || path.endsWith('.webp')) {
          return Image.file(file, fit: BoxFit.cover);
      } else if (path.endsWith('.mp4')) {
        // return AspectRatio(
        //   aspectRatio: 16 / 9,
        //   child: VideoPlayer(VideoPlayerController.file(_files[index])),
        // );
        return SizedBox.shrink();
      }
      return SizedBox.shrink();
      },
    );
  }
}