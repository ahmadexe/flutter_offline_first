import 'package:flutter/material.dart';
import 'package:flutter_of/models/article.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  const NewsCard({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
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
