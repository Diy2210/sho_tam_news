import 'package:sho_tam/NewsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ShoTamAPI {
  Future<List<NewsModel>?> getNews() async {
    final List<NewsModel> newsModel = [];
    try {
      var resp = await http.Client().get(
        Uri.parse('https://newsapi.org/v2/top-headlines?country=ua&apiKey=80e5ac83eba84a0fa0e35cacd91a6253'),
      );
      if(resp.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(resp.body);
        // for (int i = 0; i < jsonResponse['data'].length; i++) {
        //   final item = jsonResponse['data'][i];
        //   newsModel.add(
        //     NewsModel(
        //       title: item['title'],
        //     ),
        //   );
        // }
        // newsModel.add(
        //   NewsModel(
        //     title: jsonResponse['articles'][0]['title'],
        //   ),
        // );
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