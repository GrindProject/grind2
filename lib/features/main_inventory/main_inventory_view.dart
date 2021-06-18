import 'package:automated_inventory/framework/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'main_inventory_viewevents.dart';
import 'main_inventory_viewmodel.dart';

class MainInventoryView extends View<MainInventoryViewModel, MainInventoryViewEvents> {
  MainInventoryView({required MainInventoryViewModel viewModel, required MainInventoryViewEvents viewEvents})
      : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter Tutorial - googleflutter.com'),
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: this.viewModel.nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: this.viewModel.expController,
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
          ElevatedButton(
            child: Text('Add'),
            onPressed: () {
              this.viewEvents.addItemToList(this.viewModel);
            },
          ),
          Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: this.viewModel.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.blue,
                      child: InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: Text(this.viewModel.items[index].name),
                          subtitle: Text(this.viewModel.items[index].measure),
                          trailing: Icon(Icons.chevron_right),
                        ),
                      ),
                    );
                    /*
                    return Container(
                      height: 50,
                      margin: EdgeInsets.all(2),
                      color: this.viewModel.items[index].color, // msgCount[index]>=10? Colors.blue[400]: msgCount[index]>3? Colors.blue[100]: Colors.grey,
                      child: Center(
                          child: Text(
                        this.viewModel.items[index].toString(),
                        style: TextStyle(fontSize: 18),
                      )),
                    );
                     */
                  }))
        ]));
  }
}
