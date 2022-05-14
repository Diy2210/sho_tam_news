import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import '../models/NewsModel.dart';
import '../ShoTamAPI.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  bool _isLoadMoreRunning = false;
  dynamic data;
  dynamic news;
  int page = 1;
  ScrollController scrollController = ScrollController();
  List<NewsModel> newsList = [];
  String emptyList = '';

  getNews(int pageCount) async {
    setState(() {
      _isLoadMoreRunning = true;
    });

    news = await ShoTamAPI().getNews();
    page++;
    if (news != null) {
      var newNews = await news;
      newsList.addAll(newNews);
    } else {
      emptyList = 'Потерь нет, новостей нет!';
    }

    setState(() {
      _isLoadMoreRunning = false;
    });
  }

  @override
  void initState() {
    super.initState();
    data = getNews(page);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          data = getNews(page);
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    newsList = [];
  }

  @override
  Widget build(BuildContext context) {
    return (emptyList != '')
        ? Center(child: Text(emptyList))
        : (newsList.isEmpty)
        ? const Center(child: CircularProgressIndicator.adaptive())
        : Column(children: [
                Expanded(
                  child: ListView.builder(
                        controller: scrollController,
                        itemCount: newsList.length,
                        itemBuilder: (ctx, index) {
                          return Card(
                            elevation: Platform.isIOS ? 0 : 2,
                            child: Text(newsList[index].title,
                                style: const TextStyle(fontSize: 20)),
                          );
                        },
                      ),
                ),
                Visibility(
                  visible: _isLoadMoreRunning,
                  child: const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              ]);
  }
}
