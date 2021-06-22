import 'package:automated_inventory/framework/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'manage_item_viewevents.dart';
import 'manage_item_viewmodel.dart';

class ManageItemView extends View<ManageItemViewModel, ManageItemViewEvents> {
  ManageItemView({required ManageItemViewModel viewModel, required ManageItemViewEvents viewEvents}) : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {
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
}
