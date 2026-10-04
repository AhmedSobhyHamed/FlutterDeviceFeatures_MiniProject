import 'package:flutter/material.dart';
import 'package:flutterdevicefeatures_miniproject/futures/camera/domain/camera.dart';
import 'dart:io';

class ControlBar extends StatelessWidget {
  final Camera _camera = Camera.instance();
  final Function(List<File>) _addFiles;

  ControlBar({super.key, required Function(List<File>) addFiles}): _addFiles = addFiles;

  void _takePhoto() async {
    final File? image = await _camera.pickImage();
    if (image != null) {
      _addFiles([image]);
    }
  }

  void _pickImageFromGallery() async {
    final File? image = await _camera.pickImageFromGallery();
    if (image != null) {
      _addFiles([image]);
    }
  }

  void _pickVideoFromGallery() async {
    final File? video = await _camera.pickVideoFromGallery();
    if (video != null) {
      _addFiles([video]);
    }
  }

  void _takeVideo() async {
    final File? video = await _camera.pickVideo();
    if (video != null) {
      _addFiles([video]);
    }
  }

  void _pickImagesFromGallery() async {
    final List<File>? images = await _camera.pickImagesFromGallery();
    if (images != null) {
      _addFiles(images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        IconButton(onPressed: _takePhoto, icon: const Icon(Icons.camera)),
        IconButton(onPressed: _pickImageFromGallery, icon: const Icon(Icons.photo_album)),  
        IconButton(onPressed: _pickImagesFromGallery, icon: const Icon(Icons.photo_library)),  
        IconButton(onPressed: _takeVideo, icon: const Icon(Icons.videocam)),  
        IconButton(onPressed: _pickVideoFromGallery, icon: const Icon(Icons.video_library)),  
      ],
    );
  }
}