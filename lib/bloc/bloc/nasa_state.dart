part of 'nasa_bloc.dart';

abstract class NasaState {}

final class NasaInitial extends NasaState {}

final class NasaLoadingData extends NasaState {}

final class NasaDataError extends NasaState {
  String? message;
  NasaDataError(this.message);
}

final class NasaDataEmpty extends NasaState {}

final class NasaHasData extends NasaState {
  final NasaData nasaData;
  NasaHasData({required this.nasaData});
}

final class ShowNasaItemDetails extends NasaState {
  final Item? item;
  ShowNasaItemDetails({required this.item});
}
