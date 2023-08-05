import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:room_finder_app/core/common/Provider/internet_connection.dart';

class InternetConnection extends StatelessWidget {
  const InternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Connection'),
      ),
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final connectivityStatus = ref.watch(connectivityStatusProvider);
            if (connectivityStatus == ConnectivityStatus.isConnected) {
              return const Text(
                'Connected',
                style: TextStyle(fontSize: 24),
              );
            } else {
              return const Text(
                'Disconnected',
                style: TextStyle(fontSize: 24),
              );
            }
          },
        ),
      ),
    );
  }
}
