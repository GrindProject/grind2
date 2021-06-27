import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_blocevent.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:flutter/material.dart';

class MainInventoryBloc extends Bloc<MainInventoryViewModel, MainInventoryBlocEvent> {
  @override
  void onReceiveEvent(MainInventoryBlocEvent event) {
    if (event is MainInventoryBlocEventOnInitializeView) _onInitializeView(event);
    if (event is MainInventoryBlocEventRefreshData) _refreshData(event);
    if (event is MainInventoryBlocEventDeleteItem) _deleteItem(event);
  }

  void _onInitializeView(MainInventoryBlocEvent event) {
    _getItemsFromRepository().then((List<MainInventoryViewModelItemModel> items) {
      event.viewModel.cachedItems.clear();
      event.viewModel.cachedItems.addAll(items);

      event.viewModel.items.clear();
      event.viewModel.items.addAll(event.viewModel.cachedItems);

      this.pipeOut.send(event.viewModel);
    });
  }

  void _refreshData(MainInventoryBlocEventRefreshData event) {
    _refreshViewModelList(event.viewModel);
  }

  void _deleteItem(MainInventoryBlocEventDeleteItem event) async {
    String itemId = event.viewModel.items[event.itemIndex].id;
    ProductProvider productProvider = ProductProvider();
    CodeMessage codeMessage = await productProvider.delete(itemId);

    if (codeMessage.code == 1) {
      event.viewModel.responseToDeleteItem = codeMessage;
      _refreshViewModelList(event.viewModel);
    } else {
      event.viewModel.responseToDeleteItem = codeMessage;
      this.pipeOut.send(event.viewModel);
    }
  }

  void _refreshViewModelList(MainInventoryViewModel viewModel) {
    _getItemsFromRepository().then((List<MainInventoryViewModelItemModel> items) {
      viewModel.cachedItems.clear();
      viewModel.cachedItems.addAll(items);

      viewModel.items.clear();
      viewModel.items.addAll(viewModel.cachedItems);

      this.pipeOut.send(viewModel);
    });
  }

  /*
  void _applySearchArguments(MainInventoryBlocEvent event) {
    String searchArgments = '1'; // event.dasdasfd
    event.viewModel.items.clear();
    event.viewModel.cachedItems.forEach((item) {
      if (item.name.contains(searchArgments)) {
        event.viewModel.items.add(item);
      }
    });
    this.pipeOut.send(event.viewModel);
  }
   */

  Future<List<MainInventoryViewModelItemModel>> _getItemsFromRepository() async {
    List<MainInventoryViewModelItemModel> listItems = List.empty(growable: true);

    List<ProductBusinessModel> products = await _getProductsBusinessModelFromRepository();

    products.forEach((product) {
      listItems.add(MainInventoryViewModelItemModel(product.id, product.description, product.expirationDate, product.measure, Colors.blue, 5));
    });

    return listItems;
  }

  Future<List<ProductBusinessModel>> _getProductsBusinessModelFromRepository() async {
    ProductProvider productProvider = ProductProvider();
    List<ProductBusinessModel> products = await productProvider.getAll();
    return products;
  }
}
