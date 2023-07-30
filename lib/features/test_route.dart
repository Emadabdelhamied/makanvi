import 'package:flutter/material.dart';

import '../core/widgets/appbar_generic.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGeneric(
        title: 'Test',
        isback: false,
      ),
      body: const Center(
        child: Text('Test Screen'),
      ),
    );
  }
}
