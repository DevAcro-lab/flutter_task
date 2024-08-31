import 'package:flutter/material.dart';
import 'package:flutter_task/configures/app_spaces.dart';

class ConsumerTab extends StatelessWidget {
  const ConsumerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSpaces.largeSpace(context),
        const Text(
          "Consumer Tab",
        ),
      ],
    );
  }
}
