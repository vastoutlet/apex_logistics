import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget icon;
  const DefaultAppBar({
    super.key,
    required this.title,
    this.icon = const SizedBox.shrink(),
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.primaryNormal,
      foregroundColor: Constants.whiteNormal,
      title: DefaultText(
        text: title,
        size: 20,
        fontColor: Constants.whiteNormal,
        weight: FontWeight.bold,
      ),
      actions: [icon!],
    );
  }
}
