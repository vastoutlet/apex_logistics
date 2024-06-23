import 'package:apex_logistics/models/my_ride_detail_model.dart';
import 'package:get/get.dart';

class MyRideController extends GetxController {
  List<String> deliveryMessage = [
    "Delivered",
    "Ongoing Ride",
    "Cancelled Ride",
    "Pending Ride"
  ];

  MyRideDetailModel myRideDetailModel = MyRideDetailModel(
    id: "70382344444",
    address: "6 Tudun wada Street, Bauchi",
    timePrice: "18 Jun, 10:45am",
    deliveryMessage: "Cancelled",
    status: false,
  );

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // get my-ride detail for backend
    // update myRideDetailModel above (might be a list)
  }
}
