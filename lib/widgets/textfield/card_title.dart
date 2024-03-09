import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/common/theme.dart';
import 'package:flutter_happiness_poc/widgets/textfield/title_text.dart';

class CardTitle extends StatelessWidget {
  final String text;
  CardTitle(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleText(text, 18, oceanGreen),
          SizedBox(
            height: 8,
          ),
          Divider(
            height: 1,
            color: oceanGreen,
          ),
        ],
      ),
    );
  }
}
