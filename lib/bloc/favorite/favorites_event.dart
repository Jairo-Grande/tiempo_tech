part of 'favorites_bloc.dart';

abstract class FavoritesEvent {
  const FavoritesEvent();
}

class AddOrRemoveFavorite extends FavoritesEvent {
  final Item item;
  AddOrRemoveFavorite({required this.item});
}

class ShowFavoriteList extends FavoritesEvent {}
