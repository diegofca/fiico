import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'emptyView/notifications_empty_view.dart';
import 'listView/notifications_list_item.dart';

class NotificationsSuccessView extends StatelessWidget {
  const NotificationsSuccessView({
    Key? key,
  }) : super(key: key);

  final items = 0;

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
      visible: items == 0,
      child: NotificationsEmptyView(
        onTapNewItem: () {
          print("new item");
        },
      ),
    );
  }

  Widget _notificationsList() {
    return Visibility(
      visible: items > 0,
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
          itemCount: 10,
          itemBuilder: (context, index) {
            return NotificationsListItemView(index: index);
          },
        ),
      ),
    );
  }
}
