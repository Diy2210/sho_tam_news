class NewsModel {
  String title;
  String description;
  String image;
  String url;
  String publishedAt;

  NewsModel({
    this.title = '',
    this.description = '',
    this.image = '',
    this.url = '',
    this.publishedAt = ''
  });

  NewsModel.fromJson(Map<dynamic, dynamic> json)
      : title = json['title'],
        description = json['description'] ?? '',
        image = json['urlToImage'] ?? '',
        url = json['url'],
        publishedAt = json['publishedAt'];
}