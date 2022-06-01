import 'package:cached_network_image/cached_network_image.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/models/fiico_notification.dart';
import 'package:control/modules/notificationDetail/bloc/notification_detail_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationDetailSuccessView extends StatelessWidget {
  const NotificationDetailSuccessView({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final FiicoNotification? notification;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(
          FiicoPaddings.thirtyTwo,
        ),
        padding: const EdgeInsets.all(
          FiicoPaddings.four,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(
            FiicoPaddings.thirtyTwo,
          )),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _bodyNotification(),
            _buttonsActionView(context),
          ],
        ),
      ),
    );
  }

  Widget _bodyNotification() {
    switch (notification?.getType()) {
      case FiicoNotificationType.BANNER:
        return _bodyImage();
      default:
        return _body();
    }
  }

  Widget _bodyImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        FiicoPaddings.twelve,
      ),
      child: CachedNetworkImage(
        imageUrl: notification!.imageUrl!,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        _titleView(),
        _messageView(),
        _separatorLineView(),
      ],
    );
  }

  Widget _titleView() {
    return Padding(
      padding: const EdgeInsets.all(
        FiicoPaddings.thirtyTwo,
      ),
      child: Text(
        notification?.title ?? '',
        style: Style.title.copyWith(
          fontSize: FiicoFontSize.md,
        ),
        maxLines: FiicoMaxLines.two,
      ),
    );
  }

  Widget _messageView() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.thirtyTwo,
        right: FiicoPaddings.sixteen,
        left: FiicoPaddings.sixteen,
      ),
      child: Text(
        notification?.message ?? '',
        maxLines: FiicoMaxLines.ten,
        style: Style.subtitle.copyWith(
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _separatorLineView() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
      ),
      child: SeparatorView(),
    );
  }

  Widget _buttonsActionView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: FiicoPaddings.eight,
          ),
          child: FiicoButton(
            title: ' Cancelar ',
            color: FiicoColors.white,
            borderColor: FiicoColors.purpleDark,
            textColor: FiicoColors.purpleDark,
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: FiicoPaddings.eight,
          ),
          child: FiicoButton(
            title: notification?.getAcceptButtonText() ?? '',
            color: FiicoColors.purpleNeutral,
            onTap: () => _onAcceptClicked(context),
          ),
        ),
      ],
    );
  }

  void _onAcceptClicked(BuildContext context) async {
    switch (notification?.getType()) {
      case FiicoNotificationType.INVITE:
        Navigator.of(context).pop();
        context.read<NotificationDetailBloc>().add(
            NotificationGetBudgetRequest(budgetID: notification?.budgetID));
        break;
      default:
    }
  }
}
