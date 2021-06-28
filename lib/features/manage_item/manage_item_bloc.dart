import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:automated_inventory/framework/codemessage.dart';

import 'manage_item_blocevent.dart';
import 'manage_item_viewmodel.dart';

class ManageItemBloc extends Bloc<ManageItemViewModel, ManageItemBlocEvent> {
  @override
  void onReceiveEvent(ManageItemBlocEvent event) {
    if (event is ManageItemBlocEventOnInitializeView) _onInitializeView(event);
    if (event is ManageItemBlocEventSaveItem) _onSaveItem(event);
  }

  void _onInitializeView(ManageItemBlocEvent event) {
    if (event.viewModel.id.isNotEmpty) {
      _getItemFromRepository(event.viewModel.id).then((ManageItemViewModelItemModel item) {
        event.viewModel.screenTitle = item.description;
        event.viewModel.descriptionController.text = item.description;
        event.viewModel.expirationDateController.text = item.expirationDate;
        event.viewModel.measureController.text = item.measure;

        this.pipeOut.send(event.viewModel);
      });
    } else {
      event.viewModel.screenTitle = "New Item";
      event.viewModel.descriptionController.text = '';
      event.viewModel.expirationDateController.text = '';
      event.viewModel.measureController.text = '';

      this.pipeOut.send(event.viewModel);
    }
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

  void _onSaveItem(ManageItemBlocEventSaveItem event) async {
    CodeMessage codeMessage = await _setItemToRepository(
      id: event.viewModel.id,
      description: event.viewModel.descriptionController.text,
      expirationDate: event.viewModel.expirationDateController.text,
      measure: event.viewModel.measureController.text,
      upcNumber: event.viewModel.upcNumberController.text,
    );

    event.viewModel.responseToSaveItem = codeMessage;
    this.pipeOut.send(event.viewModel);
  }

  Future<CodeMessage> _setItemToRepository({required String id, required String description, required String expirationDate, required String measure, required String upcNumber}) async {
    CodeMessage? codeMessage = _checkIfAllRequiredFieldsAreFilled(description: description, measure: measure);
    if (codeMessage != null) return codeMessage;

    ProductBusinessModel product = ProductBusinessModel(id: id, description: description, expirationDate: expirationDate, measure: measure, upcNumber: upcNumber);
    ProductProvider productProvider = ProductProvider();
    if (product.id.isEmpty)
      return productProvider.create(product);
    else
      return productProvider.put(product);
  }

  CodeMessage? _checkIfAllRequiredFieldsAreFilled({required String description, required String measure}) {
    if (description.isEmpty) return CodeMessage(400, "Description is Required!");
    if (measure.isEmpty) return CodeMessage(400, "Measure is Required!");
    return null;
  }
}
