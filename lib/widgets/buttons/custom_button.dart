import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final ButtonStyle? style;
  final TextStyle? textStyle;
  final Color? iconColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.style,
    this.textStyle,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final child = Text(label, style: textStyle);

    return icon != null
        ? ElevatedButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, color: iconColor),
          label: child,
          style: style,
        )
        : ElevatedButton(onPressed: onPressed, style: style, child: child);
  }
}
