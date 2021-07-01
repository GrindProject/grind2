import 'package:automated_inventory/features/main_inventory/main_inventory_bloc.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/features/manage_item/manage_item_presenter.dart';
import 'package:automated_inventory/features/scan_item_in/scan_item_in_presenter.dart';
import 'package:automated_inventory/framework/viewevents.dart';
import 'package:automated_inventory/modules/upc_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_inventory_blocevent.dart';

class MainInventoryViewEvents extends ViewEvents<MainInventoryBloc> {
  MainInventoryViewEvents(MainInventoryBloc bloc) : super(bloc);

  void manageItem(BuildContext context, MainInventoryViewModel viewModel, String inventoryId, String productId) {

    String initialUpcNumber = '';
    if (inventoryId.isEmpty && productId.isEmpty) {
      UPCValidation upcValidation = UPCValidation(viewModel.searchController.text);
      if (upcValidation.isUPCNumberValid()) {
        initialUpcNumber = upcValidation.upcNumber;
      }
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManageItemPresenter.withDefaultConstructors(inventoryId, productId, initialUpcNumber)),
    ).then((value) {
      this.refreshScreen(context, viewModel);
    });
  }

  void refreshScreen(BuildContext context, MainInventoryViewModel viewModel) {
    MainInventoryBlocEventRefreshData blocEvent = MainInventoryBlocEventRefreshData(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }

  void addQtyToInventoryItem(BuildContext context, MainInventoryViewModel viewModel, String inventoryItemId) {
    MainInventoryBlocEventAddQtyToInventoryItem blocEvent = MainInventoryBlocEventAddQtyToInventoryItem(viewModel, inventoryItemId);
    this.bloc.pipeIn.send(blocEvent);
  }

  void subtractQtyToInventoryItem(BuildContext context, MainInventoryViewModel viewModel, String inventoryItemId) {
    MainInventoryBlocEventSubtractQtyToInventoryItem blocEvent = MainInventoryBlocEventSubtractQtyToInventoryItem(viewModel, inventoryItemId);
    this.bloc.pipeIn.send(blocEvent);
  }

  void searchItem(BuildContext context, MainInventoryViewModel viewModel) {
    MainInventoryBlocEventSearchItem blocEvent = MainInventoryBlocEventSearchItem(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }

}


