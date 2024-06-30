import 'package:get/get.dart';

class DecideRouteController extends GetxController {
  RxBool isDriver = true.obs; //based on the authenticated user type
  RxBool onlineCard = false.obs;
  Rx<double> leftPosition = 0.0.obs;
}
