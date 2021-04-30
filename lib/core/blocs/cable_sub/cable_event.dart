part of 'cable_bloc.dart';

abstract class CableEvent extends Equatable {
  const CableEvent();
}

class GetCableListEvent extends CableEvent {
  final String cableType;

  GetCableListEvent(this.cableType);
  @override
  List<Object> get props => [];
}

class BuyCableEvent extends CableEvent {
  // final BuyCableModel buyCableModel;

  // BuyCableEvent(this.buyCableModel);
  @override
  List<Object> get props => [];
}
