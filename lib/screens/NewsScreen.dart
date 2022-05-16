import 'package:flutter/material.dart';
import 'package:sho_tam/widgets/NewsList.dart';
import '../api/ShoTamAPI.dart';

class NewsScreen extends StatelessWidget {
  static const routeName = '/news_screen';

  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Шо там?')),
      ),
      body: RefreshIndicator(
        onRefresh: () => getNews(context),
        child: SizedBox(
            width: WidgetsBinding.instance.window.physicalSize.width,
            height: WidgetsBinding.instance.window.physicalSize.height,
            child: NewsList()
        ),
      ),
    );
  }

  ///Pull to refresh news
  getNews(BuildContext context) async {
    try {
      await ShoTamAPI().getNews();
    } catch (error) {
      print('Error');
    }
    Navigator.of(context).pushReplacementNamed(NewsScreen.routeName);
  }
}