import 'package:apex_logistics/models/my_ride_detail_model.dart';
import 'package:get/get.dart';

class MyRideController extends GetxController {
  var deliveryMessage =
      <String>["Delivered", "Ongoing", "Cancelled", "Pending"].obs;

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
