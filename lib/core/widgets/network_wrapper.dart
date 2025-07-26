import 'package:flutter/material.dart';
import '../const/constants.dart';
import '../services/network_connection_service.dart';
import '../utils/app_text_styles.dart';

class NetworkWrapper extends StatelessWidget {
  final Widget child;

  const NetworkWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: NetworkConnectivityService.instance.connectionStream,
      initialData: NetworkConnectivityService.instance.isConnected,
      builder: (context, snapshot) {
        final isConnected = snapshot.data ?? true;

        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.noScaling),
          child: Scaffold(
            body: Column(
              children: [
                if (!isConnected)
                  Container(
                    decoration: BoxDecoration(color: Colors.red.withAlpha(180)),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.all(horizontalPadding),
                          child: Text(
                            'It looks like you are offline. Please check your network and try again.',
                            style: TextStyles.regular16,
                          ),
                        ),

                      ],
                    ),
                  ),
                Expanded(child: child),
              ],
            ),
          ),
        );
      },
    );
  }
}
