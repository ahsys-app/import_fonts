import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

Future<Uint8List> downloadAndCacheStorage(String url) async {
  File file = await DefaultCacheManager().getSingleFile(url);
  return file.readAsBytesSync();
}

Future<String?> getLocalFontPath(String localFontFilename) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final localFilePath = '${directory.path}/$localFontFilename';
    return localFilePath;
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    }
    return null;
  }
}

Future<File?> downloadFile(String fileUrl, String fileName) async {
  try {
    final response = await http.get(Uri.parse(fileUrl));
    if (response.statusCode == 200) {
      final filePath = await getLocalFontPath(fileName);
      final file = File(filePath!);
      await file.writeAsBytes(response.bodyBytes);
      if (kDebugMode) {
        log('File downloaded to: $filePath');
      }
      return file;
    } else {
      if (kDebugMode) {
        log('Failed to download file (Status code: ${response.statusCode})');
      }
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      log('Error downloading file: $e');
    }
    return null;
  }
}

Future<ByteData> loadFontPath(String path) async {
  File file = File(path);
  if (await file.exists()) {
    Uint8List bytes = await file.readAsBytes();
    return ByteData.sublistView(bytes.buffer.asUint8List());
  } else {
    throw FileSystemException('File not found at path: $path');
  }
}
