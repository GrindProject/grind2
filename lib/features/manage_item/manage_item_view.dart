import 'package:automated_inventory/framework/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'manage_item_viewevents.dart';
import 'manage_item_viewmodel.dart';

class ManageItemView extends View<ManageItemViewModel, ManageItemViewEvents> {

  /*
  DateTime _date = DateTime.now();
  Future<Null> selectDate(BuildContext context) async
  {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(1970),
        lastDate: DateTime(2030)
    );
  }
   */

  ManageItemView({required ManageItemViewModel viewModel, required ManageItemViewEvents viewEvents}) : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {
    _checkIfThereIsResponseForSavingItem(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(this.viewModel.screenTitle),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                this.viewEvents.saveItem(this.viewModel);
              }),
        ],
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: this.viewModel.descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Description',
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: this.viewModel.expirationDateController,
            onTap: () {}, // showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.now()),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Expiration Date',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: this.viewModel.measureController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Measure',
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: this.viewModel.upcNumberController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'UPC Number',
            ),
          ),
        ),

      ]),
      /*
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          /// this.viewActions.addItem();
        },
      ),
       */
    );
  }

  void _checkIfThereIsResponseForSavingItem(BuildContext context) {
    if (this.viewModel.responseToSaveItem != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (this.viewModel.responseToSaveItem!.code == 1)
          _showAlertDialogItemSavedOK(context);
        else
          _showAlertDialogItemSaveError(context, this.viewModel.responseToSaveItem!.message);
      });
    }
  }

  void _showAlertDialogItemSavedOK(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Success!'),
        content: Text('Your item was saved!'),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              this.viewModel.responseToSaveItem = null;
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.of(context).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialogItemSaveError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Error!'),
        content: Text('There were errors while saving your item! ' + errorMessage),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              this.viewModel.responseToSaveItem = null;
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }
}
