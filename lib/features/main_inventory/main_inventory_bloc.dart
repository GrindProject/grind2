import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_blocevent.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:flutter/material.dart';

class MainInventoryBloc extends Bloc<MainInventoryViewModel, MainInventoryBlocEvent> {
  @override
  void onReceiveEvent(MainInventoryBlocEvent event) {
    if (event is MainInventoryBlocEventOnInitializeView) _onInitializeView(event);
    if (event is MainInventoryBlocEventAddItem) _addItem(event);
    if (event is MainInventoryBlocEventDeleteItem) _deleteItem(event);
  }

  void _onInitializeView(MainInventoryBlocEvent event) {
    _getItemsFromRepository().then((List<MainInventoryViewModelItemModel> items) {
      event.viewModel.items.clear();
      event.viewModel.items.addAll(items);
      this.pipeOut.send(event.viewModel);
    });
  }

  void _addItem(MainInventoryBlocEventAddItem event) {
    event.viewModel.items.add(MainInventoryViewModelItemModel(
      event.viewModel.nameController.text,
      event.viewModel.expController.text,
      event.viewModel.measureController.text,
      event.viewModel.colorController,
    ));
    this.pipeOut.send(event.viewModel);
  }

  void _deleteItem(MainInventoryBlocEventDeleteItem event) {
    /// ???
  }

  Future<List<MainInventoryViewModelItemModel>> _getItemsFromRepository() async {

    List<MainInventoryViewModelItemModel> listItems = List.empty(growable: true);

    List<ProductBusinessModel> products = await _getProductBusinessModelFromRepository();

    products.forEach((product) {

      listItems.add(

          MainInventoryViewModelItemModel(
            product.description,
            product.expirationDate,
            product.measure,
            Colors.blue,
          ));

    });

    return listItems;


  }

  Future<List<ProductBusinessModel>> _getProductBusinessModelFromRepository() async {
    ProductProvider productProvider = ProductProvider();
    List<ProductBusinessModel> products = await productProvider.getAll();
    return products;
  }
}

/*
    final List<String> names = ;
  final List<String> expiration = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<String> measure = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<String> addedOn = <String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline'];
  final List<int> msgCount = <int>[2, 0, 10, 6, 52, 4, 0, 2];
  final Color nameColor = Colors.blue;
     */
