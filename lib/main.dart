import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/di/dependency_injection.dart';
import 'core/routing/app_router.dart';
import 'core/routing/routes.dart';

import 'core/services/hive_service.dart';
import 'core/services/network_connection_service.dart';
import 'core/widgets/network_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  // Initialize services
  await NetworkConnectivityService.instance.initialize();
  await HiveService.instance.initialize();

  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Axis Assessment',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter().generateRoute,
      initialRoute: Routes.peopleScreen,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      builder: (context, child) {
        return NetworkWrapper(child: child!);
      },
    );
  }
}
