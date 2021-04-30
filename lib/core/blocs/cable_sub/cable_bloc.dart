import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_pin_/core/model/cable_plan_list.dart';
import 'package:top_pin_/core/repo/service_repo.dart';

part 'cable_event.dart';
part 'cable_state.dart';

class CableBloc extends Bloc<CableEvent, CableState> {
  CableBloc() : super(InitialCableState());

  @override
  Stream<CableState> mapEventToState(
    CableEvent event,
  ) async* {

    if(event is GetCableListEvent){
      try{
        yield LoadingGetCableListState();
        List<CablePlanListModel> dataList = await ServiceRepo().getCablePlanList(event.cableType);
        yield LoadedGetCableListState(dataList);
      }catch(e, s){
        print(e);
        print(s);
        yield ErrorGetCableListState(e?.message.toString());
      }
    }else if(event is BuyCableEvent){
      // try{
      //   yield LoadingBuyCableState();
      //   String message = await ServiceRepo().buyCable(event.buyCableModel);
      //   yield LoadedBuyCableState(message);
      // }catch(e, s){
      //   print(e);
      //   print(s);
      //   yield ErrorBuyCableState(e?.message.toString());
      // }
    }

  }
}
