import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'NewsModel.dart';
import 'ShoTamAPI.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<NewsModel>?>(
          future: ShoTamAPI().getNews(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text('Новостей нет!'),
              );
            }
            // if (snapshot.data == null) {
            //   return const Center(
            //     child: Text('Шо то не то!'),
            //   );
            // }
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: Platform.isIOS ? 0 : 2,
                  child: Text(snapshot.data![index].title,
                      style: const TextStyle(fontSize: 20)
                  ),
                );
              },
            );
          }),
    );
  }
}