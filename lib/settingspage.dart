import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teachassist/main.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        
        children: [
          const SizedBox(height: 10),
          Text("Settings", style: theme.textTheme.headlineLarge),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            label: const Text("Logout"),
            icon: const Icon(Icons.logout),
            onPressed:() {
              appState.logOutF();
            },
          )
        ]
      ),
    );
  }
  
}