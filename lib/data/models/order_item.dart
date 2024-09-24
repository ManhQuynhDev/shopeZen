class OrderItem {
  int id;
  int productId;
  int userId;
  int quantity;
  String size;

  OrderItem(
      {required this.id,
      required this.productId,
      required this.userId,
      required this.quantity,
      required this.size});
}
