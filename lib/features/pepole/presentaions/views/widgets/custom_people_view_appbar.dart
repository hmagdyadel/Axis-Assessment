import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';

class CustomPeopleViewAppbar extends StatelessWidget {
  const CustomPeopleViewAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Actors, Directors', style: TextStyles.bold16.copyWith(color: Colors.black)),
      trailing: Container(
        padding: const EdgeInsets.all(12),
        decoration: const ShapeDecoration(shape: OvalBorder(), color: Color(0xFFEEF8ED)),
        child: Icon(Icons.calendar_view_month, color: Colors.black, size: 24),
      ),
    );
  }
}
