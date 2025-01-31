import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_of/blocs/news/bloc.dart';
import 'package:flutter_of/widgets/news_card.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<NewsBloc>(context);
    bloc.add(const FetchFavourites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourite'),
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state.fetchFavourite is FavouriteFetchLoading ||
              state.fetchFavourite is FavouriteFetchInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.fetchFavourite is FavouriteFetchFailure) {
            return const Center(child: Text('Error fetching news'));
          }

          final articles = state.favourites;

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
