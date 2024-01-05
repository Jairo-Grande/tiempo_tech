import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempo_tech/bloc/favorite/favorites_bloc.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/ui/widgets/custom_card.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

List<Item?> items = [];

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();

    context.read<FavoritesBloc>().add(ShowFavoriteList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          BlocConsumer<FavoritesBloc, FavoritesState>(
            listener: (context, state) {
              if (state is FavoritesHasData) {
                items = [];
                items = state.nasaData;
              }
            },
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return MyCard(
                      item: items[index],
                      like: true,
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
