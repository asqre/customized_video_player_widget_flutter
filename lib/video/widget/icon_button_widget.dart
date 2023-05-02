import 'package:flutter/material.dart';

class IconButtonWidget extends StatefulWidget {
  final String toolTip;
  final Icon icon;
  final void Function()? onPressed;
  const IconButtonWidget(
      {required this.toolTip,
      required this.icon,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return TooltipTheme(
      data: TooltipThemeData(
        textStyle: const TextStyle(fontSize: 15, color: Colors.white),
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: IconButton(
        tooltip: widget.toolTip,
        color: Colors.white,
        splashRadius: 20,
        icon: widget.icon,
        onPressed: widget.onPressed,
      ),
    );
  }
}
