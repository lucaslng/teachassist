import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ListView(
        
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
              Text("Settings", style: theme.textTheme.headlineLarge),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.palette),
                title: const Text("Appearance"),
                trailing: const Icon(Icons.arrow_forward_rounded),
                onTap:() => Navigator.push(context, MaterialPageRoute(builder: (context) => Appearance())),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                label: const Text("Logout"),
                icon: const Icon(Icons.logout),
                onPressed:() {
                  Navigator.popUntil(context, ModalRoute.withName("/"));
                },
              )
            ],
          ),
        ]
      ),
    );
  }
  
}

class Appearance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Appearance"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          children: const [
            Column(
              children: [
                SizedBox(height: 10),
                Text("not implemented yet"),
              ]
            )
          ]
        ),
      )
    );
  }
}