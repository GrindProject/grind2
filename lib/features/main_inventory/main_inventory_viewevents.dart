import 'package:automated_inventory/features/main_inventory/main_inventory_bloc.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/features/manage_item/manage_item_presenter.dart';
import 'package:automated_inventory/framework/viewevents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_inventory_blocevent.dart';

class MainInventoryViewEvents extends ViewEvents<MainInventoryBloc> {
  MainInventoryViewEvents(MainInventoryBloc bloc) : super(bloc);

  void manageItem(BuildContext context, MainInventoryViewModel viewModel, int itemIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManageItemPresenter.withDefaultConstructors(viewModel.items[itemIndex].id)),
    ).then((value) {
      this.refreshScreen(context, viewModel);
    });
  }

  void addItem(BuildContext context, MainInventoryViewModel viewModel) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManageItemPresenter.withDefaultConstructors('')),
    ).then((value) {
      this.refreshScreen(context, viewModel);
    });
  }

  void deleteItem(BuildContext context, MainInventoryViewModel viewModel, int index) {
    MainInventoryBlocEventDeleteItem blocEvent = MainInventoryBlocEventDeleteItem(viewModel, index);
    this.bloc.pipeIn.send(blocEvent);
  }

  void refreshScreen(BuildContext context, MainInventoryViewModel viewModel) {
    MainInventoryBlocEventRefreshData blocEvent = MainInventoryBlocEventRefreshData(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }
}
