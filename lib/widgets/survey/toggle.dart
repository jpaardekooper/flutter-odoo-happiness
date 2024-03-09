import 'package:flutter/material.dart';

class ToggleAllowRead extends StatefulWidget {
  final VoidCallback _onTap;
  ToggleAllowRead(this._onTap);

  @override
  _ToggleAllowReadState createState() => _ToggleAllowReadState();
}

class _ToggleAllowReadState extends State<ToggleAllowRead> {
  bool allow_read = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: allow_read,
      onChanged: (value) {
        setState(() {
          allow_read = value;
          widget._onTap();
        });
      },
      activeColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
