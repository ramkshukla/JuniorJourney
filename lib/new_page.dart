import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  final String title;

  const NewPage({required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Page'),
      ),
      body: Center(
        child: Text('You clicked on the item with title: $title'),
      ),
    );
  }
}
