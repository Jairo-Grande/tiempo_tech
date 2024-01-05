import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tiempo_tech/data/model/nasa_result_model.dart';
import 'package:tiempo_tech/domain/use_cases/get_nasa_api.dart';

part 'nasa_event.dart';
part 'nasa_state.dart';

class NasaBloc extends Bloc<NasaEvent, NasaState> {
  final GetNasaApi _getNasaApi;
  NasaBloc(this._getNasaApi) : super(NasaInitial()) {
    on<SearchNasaDataByParameter>(_searchDataByParameter);
    on<ShowFullDetails>(_showFullDetails);
  }

  _searchDataByParameter(SearchNasaDataByParameter event, Emitter emit) async {
    emit(NasaLoadingData());
    final response = await _getNasaApi.getNasaResult(query: event.query ?? '');
    response.fold(
      (failure) {
        emit(NasaDataError(failure.message));
      },
      (data) {
        emit(NasaHasData(nasaData: data));
      },
    );
  }

  _showFullDetails(ShowFullDetails event, Emitter emit) async {
    emit(ShowNasaItemDetails(item: event.item));
  }
}
