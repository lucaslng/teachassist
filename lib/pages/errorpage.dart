import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/utils/authprovider.dart';

@RoutePage()
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
              var authProvider = Provider.of<AuthProvider>(context, listen: false);
              authProvider.logout();
              context.router.popUntilRoot();
            }
          )
        ],
      )
    );
  }
}
