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
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: Image.network(
                  article.urlToImage,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              article.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            Text(
              article.description,
              style: const TextStyle(color: Colors.black45, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
