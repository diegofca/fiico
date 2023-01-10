import 'package:control/helpers/pages_names.dart';
import 'package:control/modules/connectivity/view/connectivity_builder.dart';
import 'package:control/modules/deleteAccount/bloc/delete_account_bloc.dart';
import 'package:control/modules/deleteAccount/view/delete_account_pending_view.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/repository/send_suggestion_repository.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_account_success_view.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => DeleteAccountBloc(
        SendSuggestionRepository(),
      )..add(const IsPendingRemoveAccountRequest()),
      child: ConnectivityBuilder.noConnection(
        pageName: PageNames.deleteAccountPage,
        child: const DeleteAccountView(),
      ),
    );
  }
}

class DeleteAccountView extends StatelessWidget {
  const DeleteAccountView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
      builder: (context, state) {
        switch (state.status) {
          case DeleteAccountStatus.removePending:
            return DeleteAccountPendingView(suggestion: state.suggestion);
          default:
            return DeleteAccountSuccessView();
        }
      },
      listener: (context, state) {
        switch (state.status) {
          case DeleteAccountStatus.loading:
            FiicoRoute.showLoader(context);
            break;
          default:
            FiicoRoute.hideLoader(context);
        }
        if (state.isSendSuggestion) {
          //FiicoRoute.back(context);
        }
      },
    );
  }
}
