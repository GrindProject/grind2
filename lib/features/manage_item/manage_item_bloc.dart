import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_blocevent.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'manage_item_blocevent.dart';
import 'manage_item_viewmodel.dart';

class ManageItemBloc extends Bloc<ManageItemViewModel, ManageItemBlocEvent> {
  @override
  void onReceiveEvent(ManageItemBlocEvent event) {
    if (event is ManageItemBlocEventOnInitializeView) _onInitializeView(event);
    if (event is ManageItemBlocEventSaveItem) _onSaveItem(event);
  }

  void _onInitializeView(ManageItemBlocEvent event) {
    _getItemFromRepository(event.viewModel.id).then((ManageItemViewModelItemModel item) {
      event.viewModel.screenTitle = item.description;
      event.viewModel.descriptionController.text = item.description;
      event.viewModel.expirationDateController.text = item.expirationDate;
      event.viewModel.measureController.text = item.measure;

      this.pipeOut.send(event.viewModel);
    });
  }

  Future<ManageItemViewModelItemModel> _getItemFromRepository(String id) async {
    ProductBusinessModel? product = await _getProductBusinessModelFromRepository(id);
    if (product == null)
      return ManageItemViewModelItemModel(
        id: id,
        description: '',
        expirationDate: '',
        measure: '',
      );
    else
      return ManageItemViewModelItemModel(
        id: product.id,
        description: product.description,
        expirationDate: product.expirationDate,
        measure: product.measure,
      );
  }

  Future<ProductBusinessModel?> _getProductBusinessModelFromRepository(String id) async {
    ProductProvider productProvider = ProductProvider();
    ProductBusinessModel? product = await productProvider.get(id);
    return product;
  }

  void _onSaveItem(ManageItemBlocEventSaveItem event) {
    _setItemToRepository(
      id: event.viewModel.id,
      description: event.viewModel.descriptionController.text,
      expirationDate: event.viewModel.expirationDateController.text,
      measure: event.viewModel.measureController.text,
    );
  }

  Future<bool> _setItemToRepository({required String id, required String description, required String expirationDate, required String measure}) async {
    ProductBusinessModel product = ProductBusinessModel(id: id, description: description, expirationDate: expirationDate, measure: measure);
    ProductProvider productProvider = ProductProvider();
    productProvider.put(product);
    return true;
  }
}
