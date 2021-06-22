import 'package:automated_inventory/features/main_inventory/main_inventory_bloc.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/features/manage_item/manage_item_presenter.dart';
import 'package:automated_inventory/framework/viewevents.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainInventoryViewEvents extends ViewEvents<MainInventoryBloc> {
  MainInventoryViewEvents(MainInventoryBloc bloc) : super(bloc);

  void manageItem(BuildContext context, MainInventoryViewModelItemModel viewModel) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ManageItemPresenter.withDefaultConstructors(viewModel.id)),
    ).then((value) {
      /// bloc???
    });
  }
}
