import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AudioFiles {
  static Future<Directory> getAudiosFolder() async {
    final documents = await getApplicationDocumentsDirectory();
    final folder = Directory('${documents.path}/audios');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return folder;
  }
  static Future<List<String>> getAudioFiles() async {
    final folder = await getAudiosFolder();
    final files = folder
        .listSync()
        .whereType<File>()
        .map((file) => file.path)
        .where((path) =>
            path.endsWith('.mp3') ||
            path.endsWith('.wav') ||
            path.endsWith('.ogg') ||
            path.endsWith('.m4a') ||
            path.endsWith('.aac'))
        .toList();
    return files;
  }
}