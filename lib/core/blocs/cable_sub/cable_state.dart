part of 'cable_bloc.dart';

abstract class CableState extends Equatable {
  const CableState();
}

class InitialCableState extends CableState {
  @override
  List<Object> get props => [];
}

class InitialGetCableListState extends CableState {
  @override
  List<Object> get props => [];
}

class LoadingGetCableListState extends CableState {
  @override
  List<Object> get props => [];
}

class LoadedGetCableListState extends CableState {
  final List<CablePlanListModel> dataList;

  LoadedGetCableListState(this.dataList);
  @override
  List<Object> get props => [];
}

class ErrorGetCableListState extends CableState {
  final String message;

  ErrorGetCableListState(this.message);
  @override
  List<Object> get props => [];
}

class InitialBuyCableState extends CableState {
  @override
  List<Object> get props => [];
}

class LoadingBuyCableState extends CableState {
  @override
  List<Object> get props => [];
}

class LoadedBuyCableState extends CableState {
  final String message;

  LoadedBuyCableState(this.message);
  @override
  List<Object> get props => [];
}

class ErrorBuyCableState extends CableState {
  final String message;

  ErrorBuyCableState(this.message);
  @override
  List<Object> get props => [];
}
