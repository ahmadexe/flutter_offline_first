import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_of/blocs/news/bloc.dart';
import 'package:flutter_of/widgets/news_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(const FetchNewsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline News App'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.fetch is NewsFetchLoading ||
              state.fetch is NewsFetchInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.fetch is NewsFetchFailure) {
            return const Center(child: Text('Error fetching news'));
          }

          final articles = state.articles;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: articles!.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return NewsCard(
                article: article,
              );
            },
          );
        },
      ),
    );
  }
}
