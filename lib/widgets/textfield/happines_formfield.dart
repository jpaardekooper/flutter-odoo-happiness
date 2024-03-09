import 'package:flutter/material.dart';

class HappinessFormField extends StatelessWidget {
  final TextEditingController controller;
  const HappinessFormField(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.all(8),
        fillColor: Colors.white,
        hintText: 'Vul hier je opmerking in...',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
