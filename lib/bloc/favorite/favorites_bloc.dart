import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/domain/repositories/database_repository.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final DatabaseRepository _databaseRepository;
  FavoritesBloc(this._databaseRepository) : super(FavoritesInitial()) {
    on<AddOrRemoveFavorite>(_addOrRemoveFavorite);
    on<ShowFavoriteList>(_showFavoriteList);
  }

  _addOrRemoveFavorite(AddOrRemoveFavorite event, Emitter emit) async {
    Item? existingItem =
        await _databaseRepository.getItemByTitle(event.item.data!.first.title!);

    if (existingItem == null) {
      await _databaseRepository.insertItem(event.item);
    } else {
      await _databaseRepository.deleteItem(event.item.data!.first.title!);
    }
  }

  _showFavoriteList(ShowFavoriteList evnet, Emitter emit) async {
    emit(FavoritesLoadingData());
    try {
      final items = await _databaseRepository.getItems();
      if (items != null && items.isNotEmpty) {
        emit(FavoritesHasData(nasaData: items));
      } else {
        emit(FavoritesDataEmpty());
      }
    } catch (error) {
      emit(FavoritesDataError(error.toString()));
    }
  }
}
