import 'package:automated_inventory/framework/view.dart';
import 'package:expandable/expandable.dart';
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
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(4),
        itemCount: this.viewModel.items.length,
        itemBuilder: (BuildContext context, int index) {
          return ItemCardView(viewModel: this.viewModel, viewEvents: this.viewEvents, item: this.viewModel.items[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          this.viewEvents.manageItem(context, this.viewModel, '', '');
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

class ItemCardView extends StatelessWidget {
  ItemCardView({
    Key? key,
    required this.item,
    required this.viewModel,
    required this.viewEvents,

  });

  final MainInventoryViewModelItemModel item;
  final MainInventoryViewEvents viewEvents;
  final MainInventoryViewModel viewModel;


  Widget build(BuildContext buildContext) {
    return Padding(
      padding: EdgeInsets.only(bottom: 0.0),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: item.color, width: 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5.0),
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),
        //margin: EdgeInsets.all(20.0),
        child: ExpandableNotifier(
          child: ExpandablePanel(
            key: ValueKey("ExpandablePanel_" + item.id),
            header: _getHeader(buildContext),
            collapsed: SizedBox.shrink(),
            expanded: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: _getSubItems(buildContext),
              ),
            ),
            theme: ExpandableThemeData(
              tapHeaderToExpand: true,
              headerAlignment: ExpandablePanelHeaderAlignment.center,
              hasIcon: true,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getHeader(BuildContext context) {
    return ListTile(
      dense: true,
      //leading: UserProfileAvatar(userProfileData: this.userProfileData),
      contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
      title: Text(
        this.item.name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        this.item.measure,
        style: const TextStyle(fontSize: 12),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }


  List<Widget> _getSubItems(BuildContext context) {
    List<Widget> list = List.empty(growable: true);
    print("_getSubItems " + this.item.subItems.length.toString());
    this.item.subItems.forEach((subitem) {
      list.add(
          Card(
            color: Colors.blue,
            child: InkWell(
              onTap: () {
                this.viewEvents.manageItem(context, this.viewModel, subitem.id, item.id);
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
                            'Qty: ' + subitem.qty.toString(),
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                              'Exp.Date: ' + subitem.expirationDate,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        this.viewEvents.addQtyToInventoryItem(context, this.viewModel, subitem.id);
                      },
                      icon: Icon(Icons.add_circle, color: Colors.white),
                    ),

                    IconButton(
                      onPressed: () {
                        this.viewEvents.subtractQtyToInventoryItem(context, this.viewModel, subitem.id);
                      },
                      icon: Icon(Icons.remove_circle, color: Colors.white),
                    ),

                    Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          )


      );


    });

    list.add(
        Card(
          color: Colors.blue,
          child: InkWell(
            onTap: () {
              this.viewEvents.manageItem(context, this.viewModel, '', item.id);
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
                          'Add new Inventory Item' ,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
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
        )


    );


    return list;


  }
}
