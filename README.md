# Import Fonts

Download and load custom fonts from URLs or local storage. It simplifies the process of adding custom fonts to your Flutter app.

## Contents
- [Usage](#usage)
- [Installation](#installation)
- [API](#api)

## Usage

### Downloading Fonts from URLs

To download a font file from a specified URL and save it with a given filename, you can use the `downloadFont` method:

```dart
String url = 'https://example.com/fonts/myfont.ttf';
String filename = 'custom_font.ttf';
File? downloadedFont = await ImportFont.downloadFont(url, filename);

if (downloadedFont != null) {
  // Use the downloaded font.
}
```

Loading Fonts from URLs
To load a custom font from a URL and add it to the Flutter app's font loader, use the loadFromUrl method:

```dart
FontModel customFont = FontModel(url: 'https://example.com/myfont.ttf', family: 'CustomFont');
await ImportFont.loadFromUrl(customFont);
```

Loading Fonts from Local Storage
To load a font from local storage, you can use the loadFromLocal method:

```dart
FontModel customFont = FontModel(url: 'local/font_path.ttf', family: 'LocalFont');
await ImportFont.loadFromLocal(customFont);
```

# Installation
1. Add this package to your pubspec.yaml file:
```yaml
dependencies:
  import_fonts: ^1.0.0  # Replace with the latest version
```
2. Run flutter pub get to install the package.

## API

### `ImportFont` Class

#### `downloadFont(String url, String fontFilename)`

📥 Downloads a font file from a specified URL and saves it with the given filename.

- `url` (String): The URL from which to download the font file.
- `fontFilename` (String): The name to use when saving the downloaded font file.

Returns a `File` object representing the downloaded font file, or null if the URL is invalid. Throws an error if any exceptions occur during the download process.

#### `loadFromUrl(FontModel fontModel)`

🔤 Loads a custom font from a URL and adds it to the Flutter app's font loader.

- `fontModel` (FontModel): The font model containing information about the font to be loaded.

Throws an error if the URL is invalid or if any exceptions occur during font loading.

#### `loadFromLocal(FontModel fontModel)`

📂 Loads a font from local storage.

- `fontModel` (FontModel): The `FontModel` containing font information.

Checks if the provided `FontModel` has a local path and loads the font if the path is valid. If successful, it adds the font to the `FontLoader` and loads it. In case of an error, it logs the error in debug mode.

For more details about the `FontModel` class and other dependencies, refer to the source code.

---

If you find this package useful, please consider giving it a ⭐️ (star) on GitHub to show your support and appreciation. Your feedback and support are greatly valued and can help the package grow and improve. Thank you!




