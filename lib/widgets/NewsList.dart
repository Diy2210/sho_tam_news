import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/NewsModel.dart';
import '../api/API.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>?>(
        future: API().getNews(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Потерь нет, новостей нет!'),
            );
          }
          if (snapshot.data == null) {
            return const Center(
              child: Text('Шо то не то!'),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                onTap: () {
                  ///Open news in browser
                  openNewsUrl(snapshot.data![index].url);
                },
                child: Card(
                  elevation: Platform.isIOS ? 0 : 2,
                  child: Row(children: [
                    ///Image
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: snapshot.data![index].image == ''
                            ? const Image(
                                image: AssetImage('assets/images/no_img.png'),
                                fit: BoxFit.cover)
                            : FadeInImage.assetNetwork(
                                placeholder: 'assets/images/no_img.png',
                                image: snapshot.data![index].image,
                                fit: BoxFit.cover,
                                height: 100,
                              ),
                      ),
                    ),

                    ///News info
                    Expanded(
                      flex: 3,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            ///Published at
                            SizedBox(
                              height: 20,
                              width: double.infinity,
                              child: Text(
                                DateTime.parse(
                                    snapshot.data![index].publishedAt)
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.indigoAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),

                            ///Title
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                snapshot.data![index].title,
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ]),
                    ),
                  ]),
                ),
              );
            },
          );
        });
  }

  ///Open news in browser
  void openNewsUrl(String url) async {
    final Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}
