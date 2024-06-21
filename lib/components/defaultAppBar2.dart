import 'package:flutter/material.dart';

class DefaultAppBar2 extends StatelessWidget {
  final Color? backgroundColor;
  final Color iconColor;
  final IconData? icon;
  final void Function()? onPressed;

  const DefaultAppBar2({
    this.backgroundColor,
    required this.iconColor,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
       return Container(
      width: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
