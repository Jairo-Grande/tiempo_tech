part of 'favorites_bloc.dart';

abstract class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoadingData extends FavoritesState {}

final class FavoritesDataError extends FavoritesState {
  String? message;
  FavoritesDataError(this.message);
}

final class FavoritesDataEmpty extends FavoritesState {}

final class FavoritesHasData extends FavoritesState {
  final List<Item> nasaData;
  FavoritesHasData({required this.nasaData});
}
