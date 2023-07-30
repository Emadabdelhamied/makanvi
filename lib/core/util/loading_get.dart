import 'package:flutter/material.dart';

import '../widgets/loading.dart';

class LoadingGet extends StatelessWidget {
  const LoadingGet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 40, width: 100, child: Loading());
  }
}
