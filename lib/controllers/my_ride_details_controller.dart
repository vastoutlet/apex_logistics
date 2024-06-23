import 'package:apex_logistics/components/defaultText.dart';
import 'package:apex_logistics/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyRideDetailController extends GetxController {
  var data;

  var timelineItems = <TimelineItem>[].obs;

  addTimelineItem(TimelineItem item) {
    timelineItems.add(item);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    data = Get.arguments;

    if (data['deliveryMessage'] == "Cancelled Ride") {
      addTimelineItem(TimelineItem(
          title: "Pick Up", subtitle: DefaultText(text: data["address"])));
      addTimelineItem(
        TimelineItem(
          title: "Destination",
          subtitle: const Column(
            children: [
              DefaultText(
                text: "Wada Street, Bauchi North",
                size: 14,
              ),
              SizedBox(
                height: 10,
              ),
              MapFrame()
            ],
          ),
          parcelIndicator: Constants.errorDark,
        ),
      );
    } else if (data['deliveryMessage'] == "Delivered") {
      addTimelineItem(TimelineItem(
          title: "Pick Up", subtitle: DefaultText(text: data["address"])));
      addTimelineItem(
        TimelineItem(
          title: "Current Location",
          subtitle: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultText(
                text: "Wada Street, Bauchi North",
              ),
              SizedBox(height: 10.0),
              MapFrame()
            ],
          ),
        ),
      );
      addTimelineItem(
        TimelineItem(
            title: "Destination",
            subtitle: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultText(
                  text: "Wada Street, Bauchi North",
                ),
                DefaultText(
                  text: "Delivered",
                  fontColor: Constants.primaryNormal,
                ),
              ],
            )),
      );
    } else if (data['deliveryMessage'] == "Ongoing Ride") {
      // 2 different scenarios for ongoing ride
      // 1st scenario - current location tile before any destination
      // 2nd scenario - current location in between the destinations based on where the rider is
      // check for multiple destination, add number of destination in my_ride model
      // calculate the difference between rider's location and distance

      // gats be later - lol
    }
  }
}

class MapFrame extends StatelessWidget {
  const MapFrame({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 70,
        decoration: BoxDecoration(
            border: Border.all(color: Constants.primaryNormal, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(30.0))),
        child: const DefaultText(
          text: "Map Frame",
          align: TextAlign.center,
        ));
  }
}

class CustomTimeline extends StatelessWidget {
  final TimelineItem item;
  final bool isFirst;
  final bool isLast;
  final Color parcelIndicator;

  const CustomTimeline({
    super.key,
    required this.item,
    this.isFirst = false,
    this.isLast = false,
    this.parcelIndicator = Constants.primaryNormal,
  });

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
          width: 20,
          color: Constants.primaryNormal,
          padding: const EdgeInsets.all(6),
          indicator: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: parcelIndicator, width: 5),
                color: Colors.white),
          )),
      endChild: _RightChild(
        title: item.title,
        message: item.subtitle,
      ),
      beforeLineStyle:
          const LineStyle(color: Constants.primaryNormal, thickness: 1),
    );
  }
}

class TimelineItem {
  final String title;
  final Widget subtitle;
  final bool isFirst;
  final bool isLast;
  final Color parcelIndicator;

  TimelineItem({
    required this.title,
    required this.subtitle,
    this.isFirst = false,
    this.isLast = false,
    this.parcelIndicator = Constants.primaryNormal,
  });
}

class _RightChild extends StatelessWidget {
  final String title;
  final Widget message;
  final Widget? mapFrame;
  final bool disabled;

  const _RightChild({
    super.key,
    required this.title,
    required this.message,
    this.disabled = false,
    this.mapFrame,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DefaultText(
                text: title,
                fontColor:
                    disabled ? const Color(0xFFBABABA) : Constants.blackNormal,
                size: 18,
                weight: FontWeight.bold,
              ),
              const SizedBox(height: 6),
              message,
            ],
          ),
        ],
      ),
    );
  }
}
