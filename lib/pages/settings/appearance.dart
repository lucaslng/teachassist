import 'package:flutter/material.dart';

class Appearance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appearance"),
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