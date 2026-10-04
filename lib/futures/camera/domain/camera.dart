import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Camera {
  late ImagePicker _imagePicker;
  static Camera? _instance;

  Camera._();

  static Camera instance() {
    if (_instance == null) {
      _instance = Camera._();
      _instance!._imagePicker = ImagePicker();
    }
    return _instance!;
  }

  Future<File?> pickImage() async {
    final XFile? xFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (xFile == null) {
      return null;
    }
    return File(xFile.path);
  }

  Future<File?> pickVideo() async {
    final XFile? xFile = await _imagePicker.pickVideo(source: ImageSource.camera);
    if (xFile == null) {
      return null;
    }
    return File(xFile.path);
  }

  Future<File?> pickImageFromGallery() async {
    final XFile? xFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile == null) {
      return null;
    }
    return File(xFile.path);
  }
  Future<List<File>?> pickImagesFromGallery() async {
    final List<XFile>? xFiles = await _imagePicker.pickMultiImage();
    if (xFiles == null) {
      return null;
    }
    return xFiles.map((xFile) => File(xFile.path)).toList();
  }

  Future<File?> pickVideoFromGallery() async {
    final XFile? xFile = await _imagePicker.pickVideo(source: ImageSource.gallery);
    if (xFile == null) {
      return null;
    }
    return File(xFile.path);
  }
}