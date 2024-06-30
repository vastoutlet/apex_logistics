import 'package:get/get.dart';

class DecideRouteController extends GetxController {
  RxBool isDriver = true.obs;
  RxBool onlineCard = false.obs;
  Rx<double> leftPosition = 0.0.obs;
}
