import 'package:flutter/material.dart';

class Maindrain extends StatelessWidget {
  const Maindrain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Road Maintenance"),
      ),
      body: const Center(
        child: Text("Road Maintenance Page Content"),
      ),
    );
  }
}
