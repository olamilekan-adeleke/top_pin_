import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_pin_/core/blocs/data_bloc/data_bloc.dart';
import 'package:top_pin_/core/model/buy_data_model.dart';
import 'package:top_pin_/core/model/data_list_model.dart';
import 'package:top_pin_/core/shared_widget/custom_dialog.dart';

class BuyDataBody extends StatefulWidget {
  final Size size;

  BuyDataBody({Key key, this.size}) : super(key: key);

  @override
  _BuyDataBodyState createState() => _BuyDataBodyState();
}

class _BuyDataBodyState extends State<BuyDataBody> {
  final ValueNotifier<String> selectedNetwork = ValueNotifier<String>('');
  final ValueNotifier<DataListModel> selectedPlan =
      ValueNotifier<DataListModel>(
          DataListModel(name: 'Select Plan', price: ''));
  final TextEditingController phoneNumberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<DataListModel> dataList = [];
  DataListModel selectedDataModel;

  void validate() {
    final formState = formKey.currentState;

    if (formState.validate() && selectedNetwork.value != '') {
      String network = selectedNetwork.value;
      int phoneNumber = int.parse(phoneNumberController.text.trim());
      DataListModel dataPlan = selectedPlan.value;

      print(network);
      print(phoneNumber);
      print(dataPlan.toMap());

      BuyDataModel buyDataModel = BuyDataModel(
        Data_Type: selectedNetwork.value.split('.')[0],
        Data_Price: dataPlan.price,
        Data_Plan: dataPlan.name,
        Data_Reciever: phoneNumber.toString(),
      );

      BlocProvider.of<DataBloc>(context).add(BuyDataEvent(buyDataModel));
    }
  }

  @override
  void dispose() {
    dataList = [];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        width: widget.size.width,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text(
                '   Select Mobile Operator',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              networkImageList(),
              SizedBox(height: 10.0),
              Text(
                '   Enter Phone Number',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textField(phoneNumberController, 'Phone Number', 10),
              SizedBox(height: 10.0),
              Text(
                '   Select Plan',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              dropDown(),
              SizedBox(height: 30.0),
              button(context),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return BlocConsumer<DataBloc, DataState>(
      listener: (context, state) {
        if (state is ErrorBuyDataState) {
          CustomWarningDialog.showCustomDialog(
            context: context,
            title: 'Error',
            message: 'Opps, An error Occurred. ${state.message}',
          );
        } else if (state is LoadedBuyDataState) {
          CustomWarningDialog.showCustomDialog(
            context: context,
            title: 'Done',
            message: '${state.message}',
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingBuyDataState) {
          return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
        }

        return InkWell(
          onTap: () => validate(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            width: widget.size.width,
            height: 40.0,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Center(
              child: Text(
                'Procced',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget dropDown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: widget.size.width,
      child: BlocConsumer<DataBloc, DataState>(
        listener: (context, state) {
          if (state is ErrorGetDataListState) {
            CustomWarningDialog.showCustomDialog(
              context: context,
              title: 'Error',
              message: 'Opps, An error Occurred. ${state.message}',
            );
          }
        },
        builder: (context, state) {
          print('state: $state');
          if (state is LoadingGetDataListState) {
            return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
          } else if (state is InitialGetDataListState) {
            return Container(
              child: Text('Select Network'),
            );
          } else if (state is LoadedGetDataListState) {
            dataList = state.dataList;
            dataList.add(DataListModel(name: 'Select Plan', price: ''));

            return ValueListenableBuilder(
              valueListenable: selectedPlan,
              builder: (_, DataListModel value, child) {
                return DropdownButton(
                  isExpanded: true,
                  hint: Text("${value.name} - NGN ${value.price}"),
                  items: dataList
                      .map((e) => DropdownMenuItem(
                            child: Text('${e.name} - NGN ${e.price}'),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    print(val);
                    selectedPlan.value = val;
                  },
                );
              },
            );
          }

          return Container(
            child: Text('Select Network'),
          );
        },
      ),
    );
  }

  Widget textField(
      TextEditingController controller, String title, int minLength) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.trim().isEmpty) {
            return '$title Can\'t Be Empty';
          } else if (value.trim().length < minLength) {
            return '$title Can\'t Be Less Than 10 digits';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: '$title',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget networkImageList() {
    return Container(
      height: widget.size.height * 0.12,
      width: widget.size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          networkImage('mtn.png'),
          networkImage('airtel.png'),
          networkImage('glo.jpg'),
          networkImage('9mobile.png'),
        ],
      ),
    );
  }

  Widget networkImage(String name) {
    return ValueListenableBuilder(
      valueListenable: selectedNetwork,
      builder: (_, String value, child) {
        return InkWell(
          onTap: () {
            selectedNetwork.value = name;
            selectedPlan.value = DataListModel(name: 'Select Plan', price: '');
            BlocProvider.of<DataBloc>(context)
                .add(GetDataListEvent(name.split('.')[0]));
          },
          child: Container(
            color: value == name ? Colors.red : Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            width: 80.0,
            height: 50.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('asset/$name', fit: BoxFit.fill),
            ),
          ),
        );
      },
    );
  }
}
