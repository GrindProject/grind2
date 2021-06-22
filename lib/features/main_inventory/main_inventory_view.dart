import 'package:automated_inventory/framework/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'main_inventory_viewevents.dart';
import 'main_inventory_viewmodel.dart';

class MainInventoryView extends View<MainInventoryViewModel, MainInventoryViewEvents> {
  MainInventoryView({required MainInventoryViewModel viewModel, required MainInventoryViewEvents viewEvents})
      : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Inventory'),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                /// this.viewActions.searchItem();
              }),
          IconButton(
              icon: Icon(MdiIcons.barcodeScan),
              onPressed: () {
                /// this.viewActions.scanItem();
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
                /// this.viewActions.editItem();
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
          /// this.viewActions.addItem();
        },
      ),
    );
  }
}
