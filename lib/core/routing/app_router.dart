import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/people/presentations/cubit/people_cubit.dart';
import '../../features/people/presentations/views/people_view.dart';
import '../di/dependency_injection.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.peopleScreen:
        return _buildRoute(
          BlocProvider(
            create: (_) => getIt<PeopleCubit>(),
            child: const PeopleView(),
          ),
        );

      default:
        return _buildRoute(
          BlocProvider(
            create: (_) => getIt<PeopleCubit>(),
            child: const PeopleView(),
          ),
        );
    }
  }

  Route _buildRoute(Widget page, {bool useCupertino = false}) {
    if (useCupertino || TargetPlatform.iOS == defaultTargetPlatform) {
      return CupertinoPageRoute(builder: (_) => page);
    } else {
      return MaterialPageRoute(builder: (_) => page);
    }
  }
}
