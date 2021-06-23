import 'package:automated_inventory/features/main_inventory/main_inventory_viewmodel.dart';
import 'package:automated_inventory/framework/blocevent.dart';

abstract class MainInventoryBlocEvent extends BlocEvent<MainInventoryViewModel> {
  MainInventoryBlocEvent(MainInventoryViewModel viewModel) : super(viewModel);
}

/// base events

class MainInventoryBlocEventOnInitializeView extends MainInventoryBlocEvent {
  MainInventoryBlocEventOnInitializeView(MainInventoryViewModel viewModel) : super(viewModel);
}

/// custom events

//class MainInventoryBlocEventAddItem extends MainInventoryBlocEvent {
//  MainInventoryBlocEventAddItem(MainInventoryViewModel viewModel) : super(viewModel);
//}

//class MainInventoryBlocEventDeleteItem extends MainInventoryBlocEvent {
//  MainInventoryBlocEventDeleteItem(MainInventoryViewModel viewModel) : super(viewModel);
//}

class MainInventoryBlocEventRefreshData extends MainInventoryBlocEvent {
  MainInventoryBlocEventRefreshData(MainInventoryViewModel viewModel) : super(viewModel);
}

class MainInventoryBlocEventDeleteItem extends MainInventoryBlocEvent {
  final int itemIndex;

  MainInventoryBlocEventDeleteItem(MainInventoryViewModel viewModel, this.itemIndex) : super(viewModel);
}
