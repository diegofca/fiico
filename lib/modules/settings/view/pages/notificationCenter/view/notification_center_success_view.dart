import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/notification_center_option.dart';
import 'package:control/modules/settings/view/pages/notificationCenter/repository/notification_center_repository.dart';
import 'package:control/modules/settings/view/pages/notificationCenter/view/itemList/notification_center_item_list.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class NotificationCenterSuccessView extends StatefulWidget {
  const NotificationCenterSuccessView({
    Key? key,
    required this.options,
    required this.onUpdateOption,
  }) : super(key: key);

  final List<NotificationCenterOption>? options;
  final Function(NotificationCenterOption?) onUpdateOption;
  @override
  State<NotificationCenterSuccessView> createState() =>
      NotificationCenterSuccessViewState();
}

class NotificationCenterSuccessViewState
    extends State<NotificationCenterSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: _languagesItemsList(context),
    );
  }

  Widget _languagesItemsList(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: const [
          BoxShadow(
            color: FiicoColors.grayLite,
            blurRadius: 5,
            spreadRadius: 20,
          )
        ],
      ),
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(
          top: FiicoPaddings.thirtyTwo,
          right: FiicoPaddings.sixteen,
          left: FiicoPaddings.sixteen,
        ),
        child: ListView.builder(
          itemCount: widget.options?.length,
          itemBuilder: (context, index) {
            final option = widget.options?[index];
            final _option = NotificationCenterRepository()
                .options
                .firstWhereOrNull((e) => e.id == option?.id);

            return NotificationCenterListItemView(
              onUpdateOption: widget.onUpdateOption,
              option: _option?.copyWith(enable: option?.enable),
            );
          },
        ),
      ),
    );
  }
}
