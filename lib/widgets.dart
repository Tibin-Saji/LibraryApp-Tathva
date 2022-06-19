import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextMedium extends StatelessWidget {
  // const TextSmall({Key? key}) : super(key: key);

  String text;
  TextAlign align;
  Color color;

  TextMedium(this.text,
      {Key? key, this.align = TextAlign.left, this.color = Colors.black54})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
          fontSize: 24,
          color: color,
          fontFamily: 'Montserrat',
        ));
  }
}

class TextSmall extends StatelessWidget {
  // const TextSmall({Key? key}) : super(key: key);

  String text;
  TextAlign align;
  Color color;

  TextSmall(this.text,
      {Key? key, this.align = TextAlign.left, this.color = Colors.black54})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontFamily: 'Montserrat',
        ));
  }
}

class TextCustom extends StatelessWidget {
  // const TextSmall({Key? key}) : super(key: key);

  String text;
  TextAlign align;
  Color color;
  double size;
  FontWeight weight;

  TextCustom(this.text,
      {Key? key,
      this.align = TextAlign.left,
      this.color = Colors.black54,
      this.size = 20,
      this.weight = FontWeight.w500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
          fontSize: 24,
          color: color,
          fontFamily: 'Montserrat',
        ));
  }
}
