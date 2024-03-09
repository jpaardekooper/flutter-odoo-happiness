import 'package:flutter/material.dart';

class InformationCard extends StatelessWidget {
  final String heading;
  final VoidCallback onTap;

  InformationCard(this.heading, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Column(
        children: [Text(heading)],
      ),
    );
  }
}
