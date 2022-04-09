import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:flutter/material.dart';
import 'emptyView/notifications_empty_view.dart';
import 'listView/notifications_list_item.dart';

class NotificationsSuccessView extends StatelessWidget {
  const NotificationsSuccessView({
    Key? key,
    required this.notifications,
  }) : super(key: key);

  final List<FiicoNotification> notifications;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Stack(
        children: [
          _emptyView(),
          _notificationsList(),
        ],
      ),
    );
  }

  Widget _emptyView() {
    return Visibility(
      visible: notifications.isEmpty,
      child: NotificationsEmptyView(
        onTapNewItem: () {
          print("new item");
        },
      ),
    );
  }

  Widget _notificationsList() {
    return Visibility(
      visible: notifications.isNotEmpty,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
          boxShadow: const [
            BoxShadow(
              color: FiicoColors.grayLite,
              blurRadius: 5,
              spreadRadius: 20,
            )
          ],
        ),
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final not = notifications[index];
            return NotificationsListItemView(notification: not);
          },
        ),
      ),
    );
  }
}
