import 'package:automated_inventory/framework/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'main_inventory_viewevents.dart';
import 'main_inventory_viewmodel.dart';


class MainInventoryView extends View<MainInventoryViewModel, MainInventoryViewEvents> {
  bool isSwitched = false;
  MainInventoryView({required MainInventoryViewModel viewModel, required MainInventoryViewEvents viewEvents})
      : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {
    _checkIfThereIsResponseForSavingItem(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Inventory'),
        actions: [


        IconButton(
              icon: Icon(MdiIcons.barcodeScan),
              onPressed: () {
                /// this.viewEvents.scanItem();
              }),

        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: this.viewModel.items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {
                this.viewEvents.manageItem(context, this.viewModel, index);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            this.viewModel.items[index].name,
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            'Exp.Date: ' + this.viewModel.items[index].expirationDate,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Measure: ' + this.viewModel.items[index].measure,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            'Qty: ' + this.viewModel.items[index].qty.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        this.viewEvents.deleteItem(context, this.viewModel, index);
                      },
                      icon: Icon(Icons.delete, color: Colors.white),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          this.viewEvents.addItem(context, this.viewModel);
        },
      ),
    );
  }

  void _checkIfThereIsResponseForSavingItem(BuildContext context) {
    if (this.viewModel.responseToDeleteItem != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        if (this.viewModel.responseToDeleteItem!.code == 1)
          _showAlertDialogItemDeletedOK(context);
        else
          _showAlertDialogItemDeleteError(context, this.viewModel.responseToDeleteItem!.message);
      });
    }
  }

  void _showAlertDialogItemDeletedOK(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Success!'),
        content: Text('Your item was deleted!'),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              this.viewModel.responseToDeleteItem = null;
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAlertDialogItemDeleteError(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Error!'),
        content: Text('There were errors while deleting your item! ' + errorMessage),
        actions: <Widget>[
          new TextButton(
            onPressed: () {
              this.viewModel.responseToDeleteItem = null;
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }
}
