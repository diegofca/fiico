import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/constants.dart';
import 'package:control/helpers/extension/remote_config.dart';
import 'package:control/helpers/genericViews/fiico_giff_dialog.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/createBudget/view/create_budget_bottom_view.dart';
import 'package:control/modules/createBudget/view/create_budget_page.dart';
import 'package:control/modules/home/bloc/home_bloc.dart';
import 'package:control/modules/home/repository/home_repository.dart';
import 'package:control/modules/home/view/home_success_view.dart';
import 'package:control/modules/updateApp/view/update_app_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        HomeRepository()..getListenerUser(),
      )..add(HomeBudgetsFetchRequest(uID: user?.id)),
      child: HomePageView(user: user),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(builder: (context, state) {
      return StreamBuilder<List<Budget>>(
        stream: state.budgets,
        builder: (context, snapshot) {
          return HomeSuccesView(
            budgets: snapshot.data,
            budgetSelected: state.budgetSelected,
            dropdownvalue: state.filter ?? 5,
            user: user,
          );
        },
      );
    }, listener: (context, state) {
      _validateStatusView(context, state);
      _validateIfShowTutorial(context, state);
      _validateIfCanUpdateApp(context, state);
    });
  }

  void _validateStatusView(BuildContext context, HomeState state) {
    switch (state.status) {
      case HomeStatus.loading:
        FiicoRoute.showLoader(context);
        break;
      default:
        FiicoRoute.hideLoader(context);
    }
  }

  void _validateIfShowTutorial(BuildContext context, HomeState state) async {
    final _user = await Preferences.get.getUser();
    final showedUserTutorial = _user?.showTutorial ?? false;

    if (!showedUserTutorial && state.showTutorial == null) {
      context.read<HomeBloc>().add(const HomeShowedTutorial(showed: true));
    } else if (showedUserTutorial && state.status == HomeStatus.init) {
      _showTutorialAlert(context);
    }
  }

  void _validateIfCanUpdateApp(BuildContext context, HomeState state) async {
    switch (state.status) {
      case HomeStatus.loading:
        final isupdate = await FiicoRemoteConfig.isShowUpdateVersion();
        final forceUpdate = FiicoRemoteConfig.isForceUpdateVersion();
        if (isupdate) {
          UpdateAppPage().show(
            context,
            onCancelAction: () => Navigator.of(context).pop(),
            onUpdateAction: () {},
            forceUpdate: forceUpdate,
          );
        }
        break;
      default:
    }
  }

  void _showTutorialAlert(BuildContext context) {
    FiicoGiffAlertDialog.show(
      context: context,
      urlImage: FiicoConstants.tutorialGiffUrl,
      title: FiicoLocale().createNewBudget,
      desc: FiicoLocale().startByCreatingYourFirstBudget,
      okBtnText: FiicoLocale().createBudget,
      voidCallback: () => _addBudgetClickedAction(context),
      touchDissmis: false,
      hideCancelButton: true,
    );
  }

  void _addBudgetClickedAction(BuildContext context) {
    Navigator.pop(context);
    CreateBottomView().show(context, callbackName: (name) {
      FiicoRoute.send(context, CreateBudgetPage(budgetName: name));
    });
  }
}
