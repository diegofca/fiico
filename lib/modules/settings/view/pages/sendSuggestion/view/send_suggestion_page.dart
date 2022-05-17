import 'package:control/helpers/pages_names.dart';
import 'package:control/modules/connectivity/view/connectivity_builder.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/bloc/send_suggestion_bloc.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/repository/send_suggestion_repository.dart';
import 'package:control/modules/settings/view/pages/sendSuggestion/view/send_suggestion_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SendSuggestionPage extends StatelessWidget {
  const SendSuggestionPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (blocContext) => SendSuggestionBloc(
        SendSuggestionRepository(),
      ),
      child: ConnectivityBuilder.noConnection(
        pageName: PageNames.budgetPage,
        child: const SendSuggestionView(),
      ),
    );
  }
}

class SendSuggestionView extends StatelessWidget {
  const SendSuggestionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendSuggestionBloc, SendSuggestionState>(
      builder: (context, state) {
        return SendSuggestionSuccessView();
      },
      listener: (context, state) {
        switch (state.status) {
          case SendSuggestionStatus.loading:
            FiicoRoute.showLoader(context);
            break;
          default:
            FiicoRoute.hideLoader(context);
        }

        if (state.isSendSuggestion) {
          FiicoRoute.back(context);
        }
      },
    );
  }
}
