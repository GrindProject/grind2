import 'package:automated_inventory/businessmodels/inventory/inventory_businessmodel.dart';
import 'package:automated_inventory/businessmodels/inventory/inventory_provider.dart';
import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_blocevent.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:flutter/material.dart';

class MainInventoryBloc
    extends Bloc<MainInventoryViewModel, MainInventoryBlocEvent> {
  @override
  void onReceiveEvent(MainInventoryBlocEvent event) {
    if (event is MainInventoryBlocEventOnInitializeView) _onInitializeView(event);
    if (event is MainInventoryBlocEventRefreshData) _refreshData(event);
    if (event is MainInventoryBlocEventDeleteItem) _deleteItem(event);
    if (event is MainInventoryBlocEventAddQtyToInventoryItem) _addQtyToInventoryItem(event);
    if (event is MainInventoryBlocEventSubtractQtyToInventoryItem) _subtractQtyToInventoryItem(event);
  }

  void _onInitializeView(MainInventoryBlocEvent event) {
    _getItemsFromRepository()
        .then((List<MainInventoryViewModelItemModel> items) {
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
    _getItemsFromRepository()
        .then((List<MainInventoryViewModelItemModel> items) {
      viewModel.cachedItems.clear();
      viewModel.cachedItems.addAll(items);

      viewModel.items.clear();
      viewModel.items.addAll(viewModel.cachedItems);

      this.pipeOut.send(viewModel);
    });
  }



  Future<List<MainInventoryViewModelItemModel>> _getItemsFromRepository() async {
    List<MainInventoryViewModelItemModel> listItems = List.empty(growable: true);
    List<ProductBusinessModel> productList = await _getProductsBusinessModelFromRepository();
    for(ProductBusinessModel product in productList) {
      InventoryProvider inventoryProvider = InventoryProvider();
      List<InventoryBusinessModel> inventoryList = await inventoryProvider.getByProductId(product.id);
      List<MainInventoryViewModelSubItemModel> subItems = List.empty(growable: true);
      inventoryList.forEach((inventory) {
        subItems.add(MainInventoryViewModelSubItemModel(inventory.id, inventory.expirationDate, inventory.qty, Colors.blue));
      });
      listItems.add(MainInventoryViewModelItemModel(
        product.id,
        product.description,
        product.measure,
        subItems,
        Colors.blue,
      ));

    }

    return listItems;
  }

  Future<List<ProductBusinessModel>>
      _getProductsBusinessModelFromRepository() async {
    ProductProvider productProvider = ProductProvider();
    List<ProductBusinessModel> products = await productProvider.getAll();
    return products;
  }

  void _addQtyToInventoryItem(MainInventoryBlocEventAddQtyToInventoryItem event) async {
    InventoryProvider inventoryProvider = InventoryProvider();
    InventoryBusinessModel? inventory = await inventoryProvider.get(event.inventoryItemId);
    if (inventory == null) return;
    inventory.qty++;
    inventoryProvider.put(inventory);
    _refreshViewModelList(event.viewModel);
  }

  void _subtractQtyToInventoryItem(MainInventoryBlocEventSubtractQtyToInventoryItem event) async {
    InventoryProvider inventoryProvider = InventoryProvider();
    InventoryBusinessModel? inventory = await inventoryProvider.get(event.inventoryItemId);
    if (inventory == null) return;
    inventory.qty--;

    if (inventory.qty > 0)
      inventoryProvider.put(inventory);
    else {
      inventoryProvider.delete(inventory.id);

      List<InventoryBusinessModel> list = await inventoryProvider.getByProductId(inventory.productId);
      if (list.isEmpty) {
        ProductProvider productProvider = ProductProvider();
        await productProvider.delete(inventory.productId);
      }
    }

    _refreshViewModelList(event.viewModel);
  }

}
