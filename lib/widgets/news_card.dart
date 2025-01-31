import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_of/blocs/news/bloc.dart';
import 'package:flutter_of/models/article.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  const NewsCard({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    final newsBloc = BlocProvider.of<NewsBloc>(context);
    return GestureDetector(
      onTap: () async {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    article.title,
                    style: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      newsBloc.add(MarkFavourite(article: article));
                    },
                    child: const Text('Favourite'))
              ],
            ),
            Text(
              article.description,
              style: const TextStyle(color: Colors.black45, fontSize: 15),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
