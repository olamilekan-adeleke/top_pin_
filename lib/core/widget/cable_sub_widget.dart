import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_pin_/core/blocs/cable_sub/cable_bloc.dart';
import 'package:top_pin_/core/model/cable_plan_list.dart';
import 'package:top_pin_/core/shared_widget/custom_dialog.dart';

class CableSubBody extends StatefulWidget {
  final Size size;

  CableSubBody({Key key, this.size}) : super(key: key);

  @override
  _CableSubBodyState createState() => _CableSubBodyState();
}

class _CableSubBodyState extends State<CableSubBody> {
  final ValueNotifier<String> selectedNetwork = ValueNotifier<String>('');
  final ValueNotifier<CablePlanListModel> selectedPlan =
      ValueNotifier<CablePlanListModel>(
          CablePlanListModel(name: 'Select Plan', variation_amount: ''));

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<CablePlanListModel> cablePlanList = [];
  CablePlanListModel selectedCablePlanModel;

  void validate() {
    final formState = formKey.currentState;

    if (formState.validate() && selectedNetwork.value != '') {
      String network = selectedNetwork.value;
      int phoneNumber = int.parse(phoneNumberController.text.trim());
      int amount = int.parse(amountController.text.trim());

      print(network);
      print(phoneNumber);
      print(amount);
    }
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
                '   Select Cable Operator',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              networkImageList(),
              SizedBox(height: 10.0),
              Text(
                '   Enter Smart Card Number',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textField(phoneNumberController, 'Card Number', 10),
              SizedBox(height: 10.0),
              Text(
                '   Plan',
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

  Widget dropDown() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      width: widget.size.width,
      child: BlocConsumer<CableBloc, CableState>(
        listener: (context, state) {
          if (state is ErrorGetCableListState) {
            CustomWarningDialog.showCustomDialog(
              context: context,
              title: 'Error',
              message: 'Opps, An error Occurred. ${state.message}',
            );
          }
        },
        builder: (context, state) {
          print('state: $state');
          if (state is LoadingGetCableListState) {
            return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
          } else if (state is InitialGetCableListState) {
            return Container(
              child: Text('Select Network'),
            );
          } else if (state is LoadedGetCableListState) {
            cablePlanList = state.dataList;
            cablePlanList.add(
                CablePlanListModel(name: 'Select Plan', variation_amount: ''));

            return ValueListenableBuilder(
              valueListenable: selectedPlan,
              builder: (_, CablePlanListModel value, child) {
                return DropdownButton(
                  isExpanded: true,
                  hint: Text("${value.name} - NGN ${value.variation_amount}"),
                  items: cablePlanList
                      .map((e) => DropdownMenuItem(
                            child:
                                Text('${e.name} - NGN ${e.variation_amount}'),
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

  Widget button(BuildContext context) {
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
          networkImage('dstv.png'),
          networkImage('gotv.png'),
          networkImage('startimes.jpg'),
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
            selectedPlan.value =
                CablePlanListModel(name: 'Select Plan', variation_amount: '');
            BlocProvider.of<CableBloc>(context)
                .add(GetCableListEvent(name.split('.')[0]));
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
