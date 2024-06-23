import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';

class DefaultRideCards extends StatelessWidget {
  final String? address;
  final String? timePrice;
  final String? deliveryMessage;
  final bool? status;
  final Function()? onTap;

  const DefaultRideCards({
    required this.address,
    required this.timePrice,
    required this.deliveryMessage,
    this.onTap,
    this.status,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 15),
      color: Constants.whiteNormal,
      shadowColor: Constants.whiteNormal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: const CircleAvatar(
          backgroundColor: Constants.whiteDark,
          child: ClipOval(
            child: Icon(
              Icons.delivery_dining_outlined,
              color: Constants.blackNormal,
            ),
          ),
        ),
        title: DefaultText(
          text: address,
          size: 15,
          weight: FontWeight.bold,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DefaultText(
              text: timePrice,
              size: 13,
            ),
            DefaultText(
              text: deliveryMessage,
              size: 13,
              fontColor: (status == null)
                  ? Constants.blackNormal
                  : (status == true)
                      ? Constants.primarydark
                      : Constants.errorDark,
            ),
          ],
        ),
      ),
    );
  }
}
