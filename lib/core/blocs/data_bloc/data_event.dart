part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
}

class GetDataListEvent extends DataEvent {
  final String dataType;

  GetDataListEvent(this.dataType);
  @override
  List<Object> get props => [];
}

class BuyDataEvent extends DataEvent {
  final BuyDataModel buyDataModel;

  BuyDataEvent(this.buyDataModel);
  @override
  List<Object> get props => [];
}
