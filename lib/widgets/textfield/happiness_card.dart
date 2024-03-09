import 'package:flutter/material.dart';

class HappinessCard extends StatelessWidget {
  final Widget child;
  HappinessCard(this.child);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Card(
        elevation: 8,
        child: child,
      ),
    );
  }
}
