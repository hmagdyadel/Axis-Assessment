import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gal/gal.dart';
import 'package:http/http.dart' as http;

import 'image_download_states.dart';

class ImageDownloadCubit extends Cubit<ImageDownloadStates> {
  ImageDownloadCubit() : super(const ImageDownloadStates.initial());

  Future<void> downloadImage({
    required String imageUrl,
    String? personName,
  }) async {
    try {
      emit(const ImageDownloadStates.downloading());

      // Download the image
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        // Generate filename
        final fileName = _generateFileName(personName);

        // Save to gallery
        await Gal.putImageBytes(response.bodyBytes, name: fileName);

        emit(const ImageDownloadStates.success('Image saved to gallery'));
      } else {
        emit(const ImageDownloadStates.error('Failed to download image'));
      }
    } catch (e) {
      emit(ImageDownloadStates.error('Error downloading image: $e'));
    }
  }

  /// Generates a filename for the downloaded image
  String _generateFileName(String? personName) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    if (personName != null && personName.isNotEmpty) {
      final cleanName = personName
          .replaceAll(' ', '_')
          .replaceAll(RegExp(r'[^\w\s-]'), '');
      return '${cleanName}_$timestamp.jpg';
    }

    return 'person_image_$timestamp.jpg';
  }
}
