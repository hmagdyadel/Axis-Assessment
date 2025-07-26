import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_download_states.freezed.dart';

@Freezed()
class ImageDownloadStates with _$ImageDownloadStates {
  const factory ImageDownloadStates.initial() = _Initial;
  const factory ImageDownloadStates.downloading() = _Downloading;
  const factory ImageDownloadStates.success(String message) = _Success;
  const factory ImageDownloadStates.error(String message) = _Error;
}