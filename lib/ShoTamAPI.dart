import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:sho_tam/models/NewsModel.dart';

class ShoTamAPI {
  Future<List<NewsModel>?> getNews() async {
    final List<NewsModel> newsModel = [];
    try {
      var resp = await http.Client().get(
        Uri.parse('https://newsapi.org/v2/top-headlines?country=ua&apiKey=80e5ac83eba84a0fa0e35cacd91a6253'),
      );
      if(resp.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(resp.body);
        var c = jsonResponse['articles'];
        c.forEach((news) {
          newsModel.add(NewsModel.fromJson(news));
        });
      }
      return newsModel;
    } catch(error){
      print(error);
    }
  }
}