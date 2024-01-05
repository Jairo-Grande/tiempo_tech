part of 'nasa_bloc.dart';

abstract class NasaEvent {}

class SearchNasaDataByParameter extends NasaEvent {
  final String? query;
  SearchNasaDataByParameter({this.query});
}

class ShowFullDetails extends NasaEvent {
  final Item? item;
  ShowFullDetails({required this.item});
}
