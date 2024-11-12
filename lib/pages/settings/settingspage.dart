import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              Navigator.popUntil(context, ModalRoute.withName("/"));
            },
          )
        ]
      ),
    );
  }
  
}