import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;

import 'image_download_states.dart';

/// Cubit for handling image downloads from URLs and saving them to device gallery.
///
/// Features:
/// - Downloads images from remote URLs
/// - Saves images directly to device gallery using Gal package
/// - Generates unique filenames with optional person names
/// - Provides download progress states (downloading, success, error)
/// - Handles network errors and permission issues gracefully
///
/// State Flow: initial → downloading → success/error
class ImageDownloadCubit extends Cubit<ImageDownloadStates> {
  ImageDownloadCubit() : super(const ImageDownloadStates.initial());

  /// Downloads an image from the provided URL and saves it to the device gallery.
  ///
  /// [imageUrl] The URL of the image to download (required)
  /// [personName] Optional name to include in the filename for better organization
  ///
  /// Process:
  /// 1. Emits downloading state to show loading UI
  /// 2. Downloads image data from the URL using HTTP GET
  /// 3. Generates a unique filename (with timestamp)
  /// 4. Saves image bytes to gallery using Gal package
  /// 5. Emits success or error state based on result
  ///
  /// Throws: Handles all exceptions internally and emits appropriate error states
  Future<void> downloadImage({
    required String imageUrl,
    String? personName,
  }) async {
    try {
      emit(const ImageDownloadStates.downloading());

      // Download the image data from remote URL
      final response = await http.get(Uri.parse(imageUrl));

      if (response.statusCode == 200) {
        // Generate unique filename with optional person name
        final fileName = _generateFileName(personName);

        // Save image bytes directly to device gallery
        await Gal.putImageBytes(response.bodyBytes, name: fileName);

        emit(const ImageDownloadStates.success('Image saved to gallery'));
      } else {
        emit(const ImageDownloadStates.error('Failed to download image'));
      }
    } catch (e) {
      // Handle all exceptions (network errors, permission errors, etc.)
      emit(ImageDownloadStates.error('Error downloading image: $e'));
    }
  }

  /// Generates a unique filename for the downloaded image.
  ///
  /// [personName] Optional person name to include in filename
  ///
  /// Filename format:
  /// - With person name: "john_doe_1234567890.jpg"
  /// - Without name: "person_image_1234567890.jpg"
  ///
  /// Features:
  /// - Replaces spaces with underscores for file system compatibility
  /// - Removes special characters that might cause file system issues
  /// - Adds timestamp to ensure uniqueness and avoid overwrites
  /// - Always uses .jpg extension for consistency
  ///
  /// Returns: A sanitized, unique filename suitable for saving to gallery
  String _generateFileName(String? personName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    if (personName != null && personName.isNotEmpty) {
      // Clean the person name for file system compatibility
      final cleanName = personName
          .replaceAll(' ', '_')                    // Replace spaces with underscores
          .replaceAll(RegExp(r'[^\w\s-]'), '');   // Remove special characters except word chars, spaces, hyphens
      return '${cleanName}_$timestamp.jpg';
    }

    // Default filename when no person name is provided
    return 'person_image_$timestamp.jpg';
  }
}