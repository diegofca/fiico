import 'package:control/models/fiico_notification.dart';
import 'package:control/modules/budgetDetail/view/budget_detail_page.dart';
import 'package:control/modules/notificationDetail/bloc/notification_detail_bloc.dart';
import 'package:control/modules/notificationDetail/view/notification_detail_success_view.dart';
import 'package:control/modules/notifications/repository/notifications_repository.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationDetailPage extends StatelessWidget {
  const NotificationDetailPage({
    Key? key,
    this.notification,
  }) : super(key: key);

  final FiicoNotification? notification;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationDetailBloc(
        NotificationsRepository(),
      )..add(NotificationsReadedRequest(notification: notification)),
      child: NotificationDetailPageView(
        notification: notification,
      ),
    );
  }
}

class NotificationDetailPageView extends StatelessWidget {
  const NotificationDetailPageView({
    Key? key,
    this.notification,
  }) : super(key: key);

  final FiicoNotification? notification;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationDetailBloc, NotificationDetailState>(
      builder: (context, state) {
        switch (state.status) {
          case NotificationDetailStatus.waiting:
            return NotificationDetailSuccessView(
              notification: notification,
            );
        }
      },
      listener: (context, state) {
        if (state.loadBudget) {
          FiicoRoute.send(context, BudgetDetailPage(budget: state.budget!));
        }
      },
    );
  }
}
