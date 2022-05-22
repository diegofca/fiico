import 'dart:io';

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
          // FiicoRoute.back(context);
          // RateMyApp rateMyApp = RateMyApp(
          //   preferencesPrefix: 'rateMyApp_',
          //   minDays: 7,
          //   minLaunches: 10,
          //   remindDays: 7,
          //   remindLaunches: 10,
          //   googlePlayIdentifier: 'com.fiico.app',
          //   appStoreIdentifier: '1622746856',
          // );
          // rateMyApp.showStarRateDialog(
          //   context,
          //   title: 'Rate this app', // The dialog title.
          //   message:
          //       'You like this app ? Then take a little bit of your time to leave a rating :', // The dialog message.
          //   // contentBuilder: (context, defaultContent) => content, // This one allows you to change the default dialog content.
          //   actionsBuilder: (context, stars) {
          //     // Triggered when the user updates the star rating.
          //     return [
          //       // Return a list of actions (that will be shown at the bottom of the dialog).
          //       FlatButton(
          //         child: Text('OK'),
          //         onPressed: () async {
          //           print('Thanks for the ' +
          //               (stars == null ? '0' : stars.round().toString()) +
          //               ' star(s) !');
          //           // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
          //           // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
          //           await rateMyApp
          //               .callEvent(RateMyAppEventType.rateButtonPressed);
          //           Navigator.pop<RateMyAppDialogButton>(
          //               context, RateMyAppDialogButton.rate);
          //         },
          //       ),
          //     ];
          //   },
          //   ignoreNativeDialog: Platform
          //       .isAndroid, // Set to false if you want to show the Apple's native app rating dialog on iOS or Google's native app rating dialog (depends on the current Platform).
          //   dialogStyle: const DialogStyle(
          //     // Custom dialog styles.
          //     titleAlign: TextAlign.center,
          //     messageAlign: TextAlign.center,
          //     messagePadding: EdgeInsets.only(bottom: 20),
          //   ),
          //   starRatingOptions:
          //       const StarRatingOptions(), // Custom star bar rating options.
          //   onDismissed: () => rateMyApp.callEvent(RateMyAppEventType
          //       .laterButtonPressed), // Called when the user dismissed the dialog (either by taping outside or by pressing the "back" button).
          // );
        }
      },
    );
  }
}
