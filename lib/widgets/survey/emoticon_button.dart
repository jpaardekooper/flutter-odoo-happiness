import 'package:flutter/material.dart';
import 'package:flutter_happiness_poc/models/emoticon.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmoticonButton extends StatefulWidget {
  final TextEditingController? controller;

  EmoticonButton({
    Key? key,
    this.controller,
  }) : super(key: key);

  @override
  _EmoticonButtonState createState() => _EmoticonButtonState();
}

class _EmoticonButtonState extends State<EmoticonButton> {
  static final List<Emoticon> _happyList = [
    Emoticon(1, 'Alarm', 'alarm'),
    Emoticon(2, 'Stressed', 'almost_alarm'),
    Emoticon(3, 'Neutral', 'neutral'),
    Emoticon(4, 'Almost happy', 'almost_happy'),
    Emoticon(5, 'Happy', 'happy'),
  ];

  // Declare this variable
  late Emoticon selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = _happyList[2];
    widget.controller!.text = _happyList[2].value.toString();
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(Emoticon val) {
    setState(() {
      selectedRadio = val;
      widget.controller!.text = val.value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width / 5,
          childAspectRatio: 1 / 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5),
      itemCount: _happyList.length,
      itemBuilder: (BuildContext ctx, index) {
        return Material(
          child: InkWell(
            onTap: () => setSelectedRadio(_happyList[index]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                    'assets/images/${_happyList[index].image_name}.svg',
                    height: MediaQuery.of(context).size.width / 10,
                    color: _happyList[index] == selectedRadio
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey[400]),
                Text(
                  _happyList[index].value.toString(),
                  style: TextStyle(
                      color: _happyList[index] == selectedRadio
                          ? Theme.of(context).colorScheme.secondary
                          : Colors.grey[800]),
                ),
                Icon(
                  _happyList[index] == selectedRadio
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: _happyList[index] == selectedRadio
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.grey[800],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
