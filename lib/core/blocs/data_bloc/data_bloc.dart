import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_pin_/core/model/buy_data_model.dart';
import 'package:top_pin_/core/model/data_list_model.dart';
import 'package:top_pin_/core/repo/service_repo.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(InitialGetDataListState());

  @override
  Stream<DataState> mapEventToState(
    DataEvent event,
  ) async* {
    if(event is GetDataListEvent){
      try{
        yield LoadingGetDataListState();
        List<DataListModel> dataList = await ServiceRepo().getDataList(event.dataType);
        yield LoadedGetDataListState(dataList);
      }catch(e, s){
        print(e);
        print(s);
        yield ErrorGetDataListState(e?.message.toString());
      }
    }else if(event is BuyDataEvent){
      try{
        yield LoadingBuyDataState();
        String message = await ServiceRepo().buyData(event.buyDataModel);
        yield LoadedBuyDataState(message);
      }catch(e, s){
        print(e);
        print(s);
        yield ErrorBuyDataState(e?.message.toString());
      }
    }
  }
}
