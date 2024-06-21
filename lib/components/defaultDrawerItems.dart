import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultDrawerItems extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  const DefaultDrawerItems({
    required this.icon,
    required this.text,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Constants.blackNormal,
      ),
      title: DefaultText(
        text: text,
        size: 18,
      ),
    );
  }
}
