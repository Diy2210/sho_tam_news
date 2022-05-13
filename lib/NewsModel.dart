class NewsModel {
  String title;
  // String description;
  // String image;
  String publishedAt;

  NewsModel({
    this.title = '',
    // this.description = '',
    // this.image = '',
    this.publishedAt = ''
  });

  NewsModel.fromJson(Map<dynamic, dynamic> json)
      : title = json['title'],
        // description = json['description'],
        // image = json['urlToImage'],
        publishedAt = json['publishedAt'];
}