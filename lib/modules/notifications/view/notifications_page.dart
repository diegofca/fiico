import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/notifications/bloc/notifications_bloc.dart';
import 'package:control/modules/notifications/repository/notifications_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_success_view.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().notifications,
        textColor: FiicoColors.black,
        isShowBack: false,
      ),
      body: BlocProvider(
        create: (context) => NotificationsBloc(
          NotificationsRepository(),
        )..add(NotificationssFetchRequest(uID: user?.id)),
        child: const NotificationsPageView(),
      ),
    );
  }
}

class NotificationsPageView extends StatelessWidget {
  const NotificationsPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsBloc, NotificationState>(
      builder: (context, state) {
        switch (state.status) {
          case NotificationsStatus.waiting:
            return StreamBuilder<List<FiicoNotification>>(
              stream: state.notifications,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return NotificationsSuccessView(
                    notifications: snapshot.requireData,
                  );
                }
                return const LoadingView(
                  backgroundColor: FiicoColors.white,
                );
              },
            );
        }
      },
    );
  }
}
