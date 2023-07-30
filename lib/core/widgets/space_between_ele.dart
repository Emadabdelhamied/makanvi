import 'package:flutter/material.dart';
import '../constant/spaces.dart';

///Space Between ELements Verticaly
class SpaceV5BE extends StatelessWidget {
  const SpaceV5BE({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: spaceHeightElements5);
  }
}

class SpaceV15BE extends StatelessWidget {
  const SpaceV15BE({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: spaceHeightElements15);
  }
}

class SpaceV35BE extends StatelessWidget {
  const SpaceV35BE({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: spaceHeightElements35);
  }
}

class SpaceH10BE extends StatelessWidget {
  const SpaceH10BE({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: spacewidthElements10);
  }
}

class SpaceH22BE extends StatelessWidget {
  const SpaceH22BE({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: spacewidthElements22);
  }
}
