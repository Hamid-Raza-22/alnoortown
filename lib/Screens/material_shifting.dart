import 'package:flutter/material.dart';

class MaterialShiftingPage extends StatefulWidget {
  const MaterialShiftingPage({super.key});

  @override
  State<MaterialShiftingPage> createState() => _MaterialShiftingPageState();
}

class _MaterialShiftingPageState extends State<MaterialShiftingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Shifting'),
        backgroundColor: const Color(0xFF0D0700),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Material',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
