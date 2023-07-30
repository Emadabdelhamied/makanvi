import 'package:flutter/material.dart';

import '../constant/spaces.dart';
import '../constant/styles/styles.dart';

class ColumnScaffold extends StatelessWidget {
  const ColumnScaffold({super.key, this.title, required this.children});
  final String? title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: title == null
            ? null
            : AppBar(
                title: Text(
                title!,
                style: TextStyles.textViewMedium13,
              )),
        body: Padding(
            padding: sidePadding,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children)));
  }
}

class ColumnScrolleScaffold extends StatelessWidget {
  const ColumnScrolleScaffold({super.key, this.title, required this.children});
  final String? title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: title == null
            ? null
            : AppBar(
                title: Text(
                title!,
                style: TextStyles.textViewMedium13,
              )),
        body: SingleChildScrollView(
          child: Padding(
              padding: sidePadding,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children)),
        ));
  }
}
