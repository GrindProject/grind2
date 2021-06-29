import 'package:automated_inventory/businessmodels/inventory/inventory_businessmodel.dart';
import 'package:automated_inventory/businessmodels/inventory/inventory_provider.dart';
import 'package:automated_inventory/businessmodels/product/product_businessmodel.dart';
import 'package:automated_inventory/businessmodels/product/product_provider.dart';
import 'package:automated_inventory/framework/bloc.dart';
import 'package:automated_inventory/framework/codemessage.dart';
import 'package:uuid/uuid.dart' as uuid;
import 'manage_item_blocevent.dart';
import 'manage_item_viewmodel.dart';

class ManageItemBloc extends Bloc<ManageItemViewModel, ManageItemBlocEvent> {
  @override
  void onReceiveEvent(ManageItemBlocEvent event) {
    if (event is ManageItemBlocEventOnInitializeView) _onInitializeView(event);
    if (event is ManageItemBlocEventSaveItem) _onSaveItem(event);
  }

  void _onInitializeView(ManageItemBlocEvent event) async {

    ProductProvider productProvider = ProductProvider();
    ProductBusinessModel? product = await productProvider.get(event.viewModel.productId);
    if (product != null) {

      /// product information
      event.viewModel.nameController.text = product.description;
      event.viewModel.measureController.text = product.measure;
      event.viewModel.upcNumberController.text = product.upcNumber;

      InventoryProvider inventoryProvider = InventoryProvider();
      InventoryBusinessModel? inventory = await inventoryProvider.get(event.viewModel.inventoryId);
      if (inventory != null) {
        /// inventory information
        event.viewModel.expirationDateController.text = inventory.expirationDate;
        event.viewModel.qty = inventory.qty;
      } else {
        event.viewModel.expirationDateController.text = '';
        event.viewModel.qty = 1;
      }

    } else {
      event.viewModel.nameController.text = '';
      event.viewModel.measureController.text = '';
      event.viewModel.upcNumberController.text = '';
      event.viewModel.expirationDateController.text = '';
      event.viewModel.qty = 1;
    }

    if (event.viewModel.nameController.text.isEmpty)
      event.viewModel.screenTitle = 'New Item';
    else
      event.viewModel.screenTitle = event.viewModel.nameController.text;

    this.pipeOut.send(event.viewModel);

  }




  void _onSaveItem(ManageItemBlocEventSaveItem event) async {

    CodeMessage codeMessage = await _saveDataToRepository(
      productId: event.viewModel.productId,
      productDescription: event.viewModel.nameController.text,
      productMeasure: event.viewModel.measureController.text,
      productUpcNumber: event.viewModel.upcNumberController.text,
      inventoryId: event.viewModel.inventoryId,
      inventoryExpirationDate: event.viewModel.expirationDateController.text,
      inventoryQty: event.viewModel.qty,

    );

    event.viewModel.responseToSaveItem = codeMessage;
    this.pipeOut.send(event.viewModel);

  }

  Future<CodeMessage> _saveDataToRepository({
    required String productId,
    required String productDescription,
    required String productMeasure,
    required String productUpcNumber,
    required String inventoryId,
    required String inventoryExpirationDate,
    required int inventoryQty,
  }) async {

    if (productDescription.isEmpty) return CodeMessage(400, "Description is Required!");
    if (productMeasure.isEmpty) return CodeMessage(400, "Measure is Required!");

    if (productId.isEmpty) {
      productId = uuid.Uuid().v4().toString();
    }

    if (inventoryId.isEmpty) {
      inventoryId = uuid.Uuid().v4().toString();
    }

    ProductBusinessModel product = ProductBusinessModel(id: productId, description: productDescription, measure: productMeasure, upcNumber: productUpcNumber);
    ProductProvider productProvider = ProductProvider();
    var responseForSavingProduct = await productProvider.put(product);


    InventoryBusinessModel inventory = InventoryBusinessModel(id: inventoryId, expirationDate: inventoryExpirationDate, qty: inventoryQty, productId: productId);
    InventoryProvider inventoryProvider = InventoryProvider();
    var responseForSavingInventory = await inventoryProvider.put(inventory);

    return responseForSavingInventory;
  }




}
