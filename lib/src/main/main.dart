import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:import_fonts/src/model/font_model.dart';
import 'package:import_fonts/src/main/support.dart';

class ImportFont {
  /// Downloads a font file from a specified URL and saves it with the given filename.
  ///
  /// This function attempts to download a font file from the provided URL. If the URL
  /// is valid, the font file is downloaded and saved with the specified filename.
  ///
  /// [url] - The URL from which to download the font file.
  /// [fontFilename] - The name to use when saving the downloaded font file.
  ///
  /// Returns a [File] object representing the downloaded font file, or null if the URL is invalid.
  ///
  /// Example usage:
  /// ```dart
  /// String url = 'https://example.com/fonts/myfont.ttf';
  /// String filename = 'custom_font.ttf';
  /// File? downloadedFont = await downloadFont(url, filename);
  /// if (downloadedFont != null) {
  ///   // Use the downloaded font.
  /// }
  /// ```
  ///
  /// Throws an error if any exceptions occur during the download process.
  ///
  /// [File] - A reference to the downloaded font file, or null if the URL is invalid.

  static Future<File?> downloadFont(String url, String fontFilename) async {
    if (Uri.tryParse(url)?.isAbsolute == true) {
      return downloadFile(url, fontFilename);
    }
    return null;
  }

  /// Loads a custom font from a URL and adds it to the Flutter app's font loader.
  ///
  /// This function takes a [FontModel] as input and attempts to load the font from
  /// the provided URL. If the URL is valid and the font is successfully loaded, it
  /// is added to the font loader. Any errors encountered during the process are
  /// caught and logged in debug mode.
  ///
  /// [fontModel] - The font model containing information about the font to be loaded.
  ///
  /// Throws an error if the URL is invalid or if any exceptions occur during font loading.
  ///
  /// Example usage:
  /// ```dart
  /// FontModel customFont = FontModel(url: 'https://example.com/myfont.ttf', family: 'CustomFont');
  /// await loadFromUrl(customFont);
  /// ```
  static Future<void> loadFromUrl(FontModel fontModel) async {
    try {
      final uri = Uri.tryParse(fontModel.url);
      if (uri != null && uri.isAbsolute) {
        final bytes = await downloadAndCacheStorage(fontModel.url);
        final fontLoader = FontLoader(fontModel.family);
        fontLoader.addFont(Future.value(ByteData.sublistView(bytes)));
        await fontLoader.load();
      }
    } catch (e) {
      if (kDebugMode) {
        log('Error loading font: $e');
      }
    }
  }

  /// Loads a font from local storage.
  ///
  /// This function checks if the provided `FontModel` has a local path and
  /// loads the font if the path is valid.
  ///
  /// If successful, it adds the font to the `FontLoader` and loads it.
  /// In case of an error, it logs the error in debug mode.
  ///
  /// Parameters:
  ///   - fontModel: The FontModel containing font information.
  ///
  Future<void> loadFromLocal(FontModel fontModel) async {
    final uri = Uri.tryParse(fontModel.url);

    if (uri != null && !uri.isAbsolute) {
      try {
        final data = await loadFontPath(fontModel.url);
        final fontLoader = FontLoader(fontModel.family);
        fontLoader.addFont(Future.value(ByteData.sublistView(data)));
        await fontLoader.load();
        if (kDebugMode) {
          log('Font loaded successfully from local storage: ${fontModel.url}');
        }
      } catch (e) {
        if (kDebugMode) {
          log('Error loading font from local storage: $e');
        }
      }
    }
  }
}
