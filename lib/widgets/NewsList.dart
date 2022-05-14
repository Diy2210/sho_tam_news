import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import '../models/NewsModel.dart';
import '../ShoTamAPI.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>?>(
        future: ShoTamAPI().getNews(),
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
                    showDialog(
                        context: context,
                        builder: (BuildContext bc) {
                          return AlertDialog(
                            insetPadding: const EdgeInsets.fromLTRB(10, 80, 10, 80),
                            content: snapshot.data![index].description.isNotEmpty
                              ? Text(snapshot.data![index].description, style: const TextStyle(fontSize: 20))
                              : const Text('Подробностей, как и потерь нет!', style: TextStyle(fontSize: 20)),
                            actions: <Widget>[
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: TextButton(
                                  child: const Text('Ясно, понятно', style: TextStyle(fontSize: 18)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          );
                        });
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
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ///Published at
                          SizedBox(
                            height: 20,
                            width: double.infinity,
                            child: Text(
                              // DateTime.parse(snapshot.data![index].publishedAt).day.toString()+"."+
                              // DateTime.parse(snapshot.data![index].publishedAt).month.toString()+"."+
                              // DateTime.parse(snapshot.data![index].publishedAt).year.toString(),
                              DateTime.parse(snapshot.data![index].publishedAt)
                                  .toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.indigoAccent,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              snapshot.data![index].title,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold
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
}
