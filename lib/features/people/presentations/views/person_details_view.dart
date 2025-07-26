import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/const/constants.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/routing/routes.dart';
import '../../data/models/image_viewer_args.dart';
import '../../data/models/person_details_model.dart';
import '../cubit/people_cubit.dart';
import '../cubit/people_states.dart';

class PersonDetailsView extends StatefulWidget {
  final int? personId;

  const PersonDetailsView({super.key, required this.personId});

  @override
  State<PersonDetailsView> createState() => _PersonDetailsViewState();
}

class _PersonDetailsViewState extends State<PersonDetailsView> {
  @override
  void initState() {
    super.initState();
    _loadPersonDetails();
  }

  void _loadPersonDetails() {
    if (widget.personId != null) {
      context.read<PeopleCubit>().getPersonDetails(personId: widget.personId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<PeopleCubit, PeopleStates>(
          builder: (context, state) {
            return state.whenOrNull(
                  loading: () => _buildLoadingState(),
                  successPersonDetails: (personDetails) =>
                      _buildSuccessState(personDetails),
                  error: (message) => _buildErrorState(message),
                ) ??
                _buildLoadingState();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Skeletonizer(
      enabled: true,
      child: CustomScrollView(
        slivers: [_buildSkeletonAppBar(), _buildSkeletonContent()],
      ),
    );
  }

  Widget _buildSkeletonAppBar() {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Colors.grey[800],
          child: const Center(
            child: Icon(Icons.person, color: Colors.grey, size: 80),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonContent() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(horizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 32,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 20,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              3,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  height: 16,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 24,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 0.67,
              ),
              itemCount: 6,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessState(PersonDetailsModel personDetails) {
    return CustomScrollView(
      slivers: [_buildAppBar(personDetails), _buildPersonInfo(personDetails)],
    );
  }

  Widget _buildAppBar(PersonDetailsModel personDetails) {
    final profileImageUrl = personDetails.profilePath != null
        ? 'https://image.tmdb.org/t/p/w500${personDetails.profilePath}'
        : '';

    final originalImageUrl = personDetails.profilePath != null
        ? 'https://image.tmdb.org/t/p/original${personDetails.profilePath}'
        : '';

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      flexibleSpace: GestureDetector(
        onTap: () {
          debugPrint("originalImageUrl $originalImageUrl");
          _openImageViewer(originalImageUrl, personDetails.name);
        },
        child: FlexibleSpaceBar(
          background: Stack(
            fit: StackFit.expand,
            children: [
              profileImageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: profileImageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 80,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[800],
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            color: Colors.grey,
                            size: 80,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.grey[800],
                      child: const Center(
                        child: Icon(Icons.person, color: Colors.grey, size: 80),
                      ),
                    ),
              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withAlpha(178)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openImageViewer(String imageUrl, String? personName) {
    if (imageUrl.isNotEmpty) {
      ImageViewerArgs args = ImageViewerArgs(
        imageUrl: imageUrl,
        personName: personName,
      );
      Navigator.pushNamed(context, Routes.imageViewerScreen, arguments: args);
    }
  }

  Widget _buildPersonInfo(PersonDetailsModel personDetails) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(horizontalPadding),
        padding: const EdgeInsets.all(horizontalPadding),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Text(
              personDetails.name ?? 'Unknown',
              style: TextStyles.bold19.copyWith(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),

            // Department
            if (personDetails.knownForDepartment != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.blue.withAlpha(51),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withAlpha(128),
                    width: 1,
                  ),
                ),
                child: Text(
                  personDetails.knownForDepartment!,
                  style: TextStyles.regular13.copyWith(
                    color: Colors.blue[300],
                    fontSize: 12,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Info rows
            _buildInfoRow('Birthday', personDetails.birthday),
            _buildInfoRow('Place of Birth', personDetails.placeOfBirth),
            if (personDetails.deathday != null)
              _buildInfoRow('Death Date', personDetails.deathday),
            if (personDetails.popularity != null)
              _buildInfoRow(
                'Popularity',
                '${personDetails.popularity?.toStringAsFixed(1)}',
              ),

            // Biography
            if (personDetails.biography?.isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Text(
                'Biography',
                style: TextStyles.bold19.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                personDetails.biography!,
                style: TextStyles.regular13.copyWith(
                  color: Colors.grey[300],
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],

            // Also known as
            if (personDetails.alsoKnownAs?.isNotEmpty == true) ...[
              const SizedBox(height: 16),
              Text(
                'Also Known As',
                style: TextStyles.bold19.copyWith(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: personDetails.alsoKnownAs!
                    .map(
                      (name) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          name,
                          style: TextStyles.regular13.copyWith(
                            color: Colors.grey[300],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyles.regular13.copyWith(
                color: Colors.grey[400],
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyles.regular13.copyWith(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(horizontalPadding),
        padding: const EdgeInsets.all(horizontalPadding * 2),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(77),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              'Error Loading Person Details',
              style: TextStyles.bold19.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: TextStyles.regular13.copyWith(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPersonDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
