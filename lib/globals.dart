class Books {
  String name;
  String id;
  String authorName;
  String desc;
  String imgUrl;
  double rating; //out of 5
  List feedbacks;
  List tags;
  Books(
      {required this.name,
      required this.id,
      required this.authorName,
      required this.desc,
      required this.imgUrl,
      required this.feedbacks,
      required this.rating,
      required this.tags});
}
