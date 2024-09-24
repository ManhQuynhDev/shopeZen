class Review {
  int id;
  int productId;
  int userId;
  String title;
  String content;
  double star;
  String time;

  Review(
      {required this.id,
      required this.productId,
      required this.userId,
      required this.title,
      required this.content,
      required this.star,
      required this.time});
}
