import 'package:automated_inventory/features/main_inventory/main_inventory_blocevent.dart';
import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/bloc.dart';

class MainInventoryBloc extends Bloc<MainInventoryViewModel, MainInventoryBlocEvent> {


  @override
  void onReceiveEvent(MainInventoryBlocEvent event) {
    if (event is MainInventoryBlocEventOnInitializeView) _onInitializeView(event);
    if (event is MainInventoryBlocEventAddItem) _addItem(event);
    if (event is MainInventoryBlocEventDeleteItem) _deleteItem(event);
  }

  void _onInitializeView(MainInventoryBlocEvent event) {
    event.viewModel.names.addAll(<String>['Aby', 'Aish', 'Ayan', 'Ben', 'Bob', 'Charlie', 'Cook', 'Carline']);
    this.pipeOut.send(event.viewModel);
  }

  void _addItem(MainInventoryBlocEventAddItem event) {
    event.viewModel.flgProcesing = true;
    this.pipeOut.send(event.viewModel);

    /// ???
    /// asdfadsf
    /// asdfasdf
    /// asdfasfd

    event.viewModel.flgProcesing = false;
    this.pipeOut.send(event.viewModel);

  }

  void _deleteItem(MainInventoryBlocEventDeleteItem event) {
    /// ???
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
