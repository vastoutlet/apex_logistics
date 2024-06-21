import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Constants.primaryNormal,
      foregroundColor: Constants.whiteNormal,
      title: const DefaultText(
        text: "My Ride",
        size: 20,
        fontColor: Constants.whiteNormal,
        weight: FontWeight.bold,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.filter_alt,
            color: Constants.whiteNormal,
          ),
        ),
      ],
    );
  }
}
