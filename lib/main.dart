import 'package:flutter/material.dart';
import 'context_menu.dart'; // Make sure this file exists in lib/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Context Menu Example',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Right-Click Menu')),
        body: Center(
          child: ContextMenu(
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.lightBlueAccent,
              child: const Text(
                'Right-click (or long-press on touch) here',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}





