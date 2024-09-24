enum ORDER_STATUS {
  PENDING_CONFIRMATION, // Xác nhận đang hàng
  SHIPPING, // Đang vận chuyển
  OUT_FOR_DELIVERY, // Đang giao
  DELIVERED, // Đã giao hàng
  CANCELED  // Bị hủy
}

class Order {
  int id;
  int userId;
  int addressId;
  int orderItemId;
  double totalPrice;
  String time;
  String status;

  Order(
      {required this.id,
      required this.userId,
      required this.addressId,
      required this.orderItemId,
      required this.totalPrice,
      required this.time,
      required this.status});
}
