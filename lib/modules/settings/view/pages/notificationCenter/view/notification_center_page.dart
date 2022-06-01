import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/notification_center_option.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/notificationCenter/bloc/notification_center_bloc.dart';
import 'package:control/modules/settings/view/pages/notificationCenter/repository/notification_center_repository.dart';
import 'package:control/modules/settings/view/pages/notificationCenter/view/notification_center_success_view.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCenterPage extends StatelessWidget {
  const NotificationCenterPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().notificationCenter,
        textColor: FiicoColors.black,
      ),
      body: BlocProvider(
        create: (context) => NotificationCenterBloc(
          NotificationCenterRepository(),
        )..add(const NotificationInitOptionRequest()),
        child: NotificationCenterView(user: user),
      ),
    );
  }
}

class NotificationCenterView extends StatelessWidget {
  const NotificationCenterView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCenterBloc, NotificationCenterState>(
      builder: (context, state) {
        return NotificationCenterSuccessView(
          options: state.options,
          onUpdateOption: (option) =>
              _updateNotificatioOptionValue(context, option),
        );
      },
      listener: (context, state) {
        switch (state.status) {
          case NotificationCenterStatus.loading:
            FiicoRoute.showLoader(context);
            break;
          default:
            FiicoRoute.hideLoader(context);
        }
      },
    );
  }

  void _updateNotificatioOptionValue(
    BuildContext context,
    NotificationCenterOption? option,
  ) {
    context
        .read<NotificationCenterBloc>()
        .add(NotificationOptionChangeRequest(option: option));
  }
}
