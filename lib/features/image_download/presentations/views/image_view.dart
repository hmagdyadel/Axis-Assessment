import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../core/utils/app_text_styles.dart';
import '../cubit/image_download_cubit.dart';
import '../cubit/image_download_states.dart';

class ImageViewerScreen extends StatelessWidget {
  final String imageUrl;
  final String? personName;

  const ImageViewerScreen({
    super.key,
    required this.imageUrl,
    this.personName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _buildAppBar(context),
      body: _buildImageViewer(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      title: personName != null ? _buildTitle() : null,
      actions: [_buildDownloadButton()],
    );
  }

  Widget _buildTitle() {
    return Text(
      personName!,
      style: TextStyles.bold19.copyWith(
        color: Colors.white,
        fontSize: 18,
      ),
    );
  }

  Widget _buildDownloadButton() {
    return BlocConsumer<ImageDownloadCubit, ImageDownloadStates>(
      listener: _handleDownloadStateChanges,
      builder: (context, state) {
        final isDownloading = state.maybeWhen(
          downloading: () => true,
          orElse: () => false,
        );

        return IconButton(
          icon: isDownloading ? _buildLoadingIcon() : _buildDownloadIcon(),
          onPressed: isDownloading ? null : () => _downloadImage(context),
        );
      },
    );
  }

  Widget _buildLoadingIcon() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ),
    );
  }

  Widget _buildDownloadIcon() {
    return const Icon(Icons.download, color: Colors.white);
  }

  void _handleDownloadStateChanges(BuildContext context, ImageDownloadStates state) {
    state.whenOrNull(
      success: (message) => _showSuccessSnackBar(context, message),
      error: (message) => _showErrorSnackBar(context, message),
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Widget _buildImageViewer() {
    return Center(
      child: InteractiveViewer(
        panEnabled: true,
        boundaryMargin: const EdgeInsets.all(20),
        minScale: 0.5,
        maxScale: 4.0,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
          placeholder: (context, url) => _buildPlaceholder(),
          errorWidget: (context, url, error) => _buildErrorWidget(),
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[800],
      child: const Center(
        child: CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[800],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: 16),
            Text(
              'Failed to load image',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  void _downloadImage(BuildContext context) {
    context.read<ImageDownloadCubit>().downloadImage(
      imageUrl: imageUrl,
      personName: personName,
    );
  }
}