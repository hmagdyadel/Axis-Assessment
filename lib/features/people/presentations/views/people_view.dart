import 'package:flutter/material.dart';

import 'widgets/people_view_body.dart';

class PeopleView extends StatelessWidget {
  const PeopleView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: PeopleViewBody()),
    );
  }
}
