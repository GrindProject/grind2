import 'package:automated_inventory/features/main_inventory/main_inventory_bloc.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_blocevent.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/viewevents.dart';

class MainInventoryViewEvents extends ViewEvents<MainInventoryBloc> {

  MainInventoryViewEvents(MainInventoryBloc bloc) : super(bloc);



  void addItemToList(MainInventoryViewModel viewModel) {
    MainInventoryBlocEventAddItem blocEvent = MainInventoryBlocEventAddItem(viewModel, viewModel.nameController.text);
    this.bloc.pipeIn.send(blocEvent);
  }

  void deleteItemToList(MainInventoryViewModel viewModel) {
    MainInventoryBlocEventDeleteItem blocEvent = MainInventoryBlocEventDeleteItem(viewModel);
    this.bloc.pipeIn.send(blocEvent);
  }

}