import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class SelectItems extends StatefulWidget {
  final cards;
  SelectItems(this.cards);
  @override
  _SelectItemsState createState() => _SelectItemsState(cards);
}

class _SelectItemsState extends State<SelectItems> {
  final _formKey = GlobalKey<FormState>();

  List _myProducts = [];
  List _init;
  final cards;
  _SelectItemsState(this.cards) {
    for (var i in cards) {
      _myProducts.add({
        "display": i.data()['text'],
        "value": i.data()['text'],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiSelectFormField(
      autovalidate: false,
      title: Text('Select all the products that you sell'),
      validator: (value) {
        if (value == null || value.length == 0) {
          return 'Please select one or more options';
        }
      },
      fillColor: Colors.transparent,
      chipBackGroundColor: Colors.black,
      chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
      checkBoxActiveColor: Colors.red,
      checkBoxCheckColor: Colors.green,
      dialogShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      dataSource: _myProducts,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      hintWidget: Text('Please choose one or more'),
      initialValue: _init,
      onSaved: (value) {
        if (value == null || value.length == 0) return;
        setState(() {
          _init = value;
        });
      },
    );
  }
}
