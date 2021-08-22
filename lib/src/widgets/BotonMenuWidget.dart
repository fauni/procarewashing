import 'package:flutter/material.dart';

class BotonMenuWidget extends StatelessWidget {
  const BotonMenuWidget(
      {Key? key,
      @required this.color,
      @required this.icono,
      @required this.text,
      @required this.onPressed})
      : super(key: key);

  final Color? color;
  final Icon? icono;
  final Text? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: this.color!.withOpacity(0.4),
              blurRadius: 40,
              offset: Offset(0, 15)),
          BoxShadow(
              color: this.color!.withOpacity(0.4),
              blurRadius: 13,
              offset: Offset(0, 3))
        ],
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: FlatButton(
        onPressed: this.onPressed,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        color: this.color,
        shape: StadiumBorder(),
        child: this.text!,
      ),
    );
  }
}
