import 'package:axis_assessment/core/const/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../data/models/people_model.dart';

class PeopleFeaturedItem extends StatelessWidget {
  final PersonResult person;

  const PeopleFeaturedItem({super.key, required this.person});

  String _getProfileImageUrl() {
    if (person.profilePath != null &&
        (person.profilePath?.isNotEmpty ?? false)) {
      return 'https://image.tmdb.org/t/p/w500${person.profilePath}';
    }
    return '';
  }

  String _getKnownForText() {
    if (person.knownFor != null && (person.knownFor?.isNotEmpty ?? false)) {
      // Get the first 2-3 known for items
      final items = person.knownFor!
          .take(3)
          .map((item) {
            return item.title ?? item.name ?? '';
          })
          .where((title) => title.isNotEmpty)
          .toList();

      if (items.isNotEmpty) {
        return items.join(', ');
      }
    }
    return 'No known works';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final profileImageUrl = _getProfileImageUrl();
    final knownForText = _getKnownForText();

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.personDetailsScreen,
          arguments: person.id ?? 0,
        );
      },
      child: Container(
        width: width - 32,
        margin: const EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: horizontalPadding / 2,
        ),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(78),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(horizontalPadding),
          child: Row(
            children: [
              // Profile Image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey[700]!, width: 2),
                ),
                child: ClipOval(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: profileImageUrl.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: profileImageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey[800],
                              child: const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 40,
                              ),
                            ),
                          )
                        : Container(
                            color: Colors.grey[800],
                            child: const Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Person Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Name
                    Text(
                      person.name ?? 'Unknown',
                      style: TextStyles.bold19.copyWith(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 4),

                    // Department/Role
                    if (person.knownForDepartment != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
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
                          person.knownForDepartment ?? "",
                          style: TextStyles.regular13.copyWith(
                            color: Colors.blue[300],
                            fontSize: 11,
                          ),
                        ),
                      ),

                    const SizedBox(height: 8),

                    // Known For
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Known for:',
                          style: TextStyles.regular13.copyWith(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          knownForText,
                          style: TextStyles.regular13.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow Icon
              Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
