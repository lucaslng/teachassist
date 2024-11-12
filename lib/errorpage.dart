import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: theme.colorScheme.error,
            size: 60,
          ),
          const SizedBox(height: 4),
          Text(
            "Error: ${snapshot.error}",
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
            onPressed: () {
              Navigator.pop(context);
            }
          )
        ],
      )
    );
  }
}
