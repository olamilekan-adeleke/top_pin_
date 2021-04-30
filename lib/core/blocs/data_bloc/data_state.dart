part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();
}

class InitialGetDataListState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadingGetDataListState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadedGetDataListState extends DataState {
  final List<DataListModel> dataList;

  LoadedGetDataListState(this.dataList);
  @override
  List<Object> get props => [];
}

class ErrorGetDataListState extends DataState {
  final String message;

  ErrorGetDataListState(this.message);
  @override
  List<Object> get props => [];
}

class InitialBuyDataState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadingBuyDataState extends DataState {
  @override
  List<Object> get props => [];
}

class LoadedBuyDataState extends DataState {
  final String message;

  LoadedBuyDataState(this.message);
  @override
  List<Object> get props => [];
}

class ErrorBuyDataState extends DataState {
  final String message;

  ErrorBuyDataState(this.message);
  @override
  List<Object> get props => [];
}
