class Item {
  final String title;
  final String imageUrl;

  Item({this.title, this.imageUrl});

  Item.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        imageUrl = json['image_url'];
}
