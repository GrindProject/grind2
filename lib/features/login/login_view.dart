import 'package:automated_inventory/framework/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'login_viewevents.dart';
import 'login_viewmodel.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends View<LoginViewModel, LoginViewEvents> {
  bool isSwitched = false;

  LoginView(
      {required LoginViewModel viewModel, required LoginViewEvents viewEvents})
      : super(viewModel: viewModel, viewEvents: viewEvents);

  @override
  Widget build(BuildContext context) {
    _checkIfThereIsResponseForSigningIn(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login View'),
      ),
      body: Center(
        child: Column(
          children: [

            /// login/out button
            ElevatedButton(
              onPressed: () {
                this.viewEvents.startLogin(context, viewModel);
              },
              child: Text("Login"),
            ),

            /// user's email
            (this.viewModel.userEmail != null)
            ? Text(this.viewModel.userEmail!)
            : SizedBox.shrink(),



          ],
        ),
      ),
    );
  }

  void _checkIfThereIsResponseForSigningIn(BuildContext context) {
    if (this.viewModel.userEmail != null) {
      Future.delayed(Duration(milliseconds: 300), () {
        this.viewEvents.navigateToTheMainInventoryScreen(context, this.viewModel);
      });
    }
  }

}
