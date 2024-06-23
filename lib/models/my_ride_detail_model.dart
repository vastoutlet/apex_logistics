class MyRideDetailModel {
  String? address;
  String? id;
  String? timePrice;
  String? deliveryMessage;
  bool? status;
  int? destinationNumber;
  MyRideDetailModel(
      {this.id,
      this.address,
      this.timePrice,
      this.deliveryMessage,
      this.status, this.destinationNumber});
}
