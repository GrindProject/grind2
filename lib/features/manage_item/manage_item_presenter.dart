import 'package:automated_inventory/features/manage_item/manage_item_view.dart';
import 'package:automated_inventory/framework/presenter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'manage_item_bloc.dart';
import 'manage_item_blocevent.dart';
import 'manage_item_viewevents.dart';
import 'manage_item_viewmodel.dart';


class ManageItemPresenter extends Presenter<ManageItemView, ManageItemViewModel, ManageItemViewEvents, ManageItemBloc> {
  ManageItemPresenter(ManageItemViewEvents viewEvents, ManageItemBloc bloc, ManageItemViewModel viewModel)
      : super(viewEvents: viewEvents, bloc: bloc, viewModel: viewModel);

  ManageItemPresenter.withDefaultsViewModelViewActions(ManageItemBloc bloc, String id)
      : super(viewEvents: ManageItemViewEvents(bloc), bloc: bloc, viewModel: ManageItemViewModel(id));

  ManageItemPresenter.withDefaultConstructors(String id) : this.withDefaultsViewModelViewActions(ManageItemBloc(), id);

  @override
  Widget buildLoadingView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Center(
        child: Text("Loading..."),
      ),
    );
  }

  @override
  ManageItemView buildView(BuildContext context, ManageItemViewModel viewModel) {
    return ManageItemView(viewModel: viewModel, viewEvents: this.viewEvents);
  }

  @override
  Stream<ManageItemViewModel> getViewModelStream() {
    bloc.pipeIn.send(ManageItemBlocEventOnInitializeView(this.viewModel));
    return bloc.pipeOut.receive;
  }
}
