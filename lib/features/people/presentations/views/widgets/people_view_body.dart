import 'people_item.dart';
import 'package:flutter/material.dart';

import '../../../../../core/const/constants.dart';
import '../../../../../core/widgets/search_text_field.dart';
import 'custom_people_view_appbar.dart';

class PeopleViewBody extends StatelessWidget {
  const PeopleViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: horizontalPadding),
                CustomPeopleViewAppbar(),
                SizedBox(height: horizontalPadding),
                SearchTextField(),
                SizedBox(height: 12),
                PeopleFeaturedItem()              ],

            ),
          ),
        ],
      ),
    );
  }
}
