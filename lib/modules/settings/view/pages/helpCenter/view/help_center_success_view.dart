import 'package:control/helpers/GIFImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/helpCenterConversation.dart';
import 'package:control/models/helpCenterMessage.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/helpCenter/bloc/help_center_bloc.dart';
import 'package:control/modules/settings/view/pages/helpCenter/view/bubbles/help_center_date_bubble_view.dart';
import 'package:control/modules/settings/view/pages/helpCenter/view/bubbles/help_center_text_buble_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class HelpCenterSuccessView extends StatefulWidget {
  const HelpCenterSuccessView({
    Key? key,
    this.user,
    required this.conversation,
  }) : super(key: key);

  final FiicoUser? user;
  final HelpCenterConversation? conversation;

  @override
  State<HelpCenterSuccessView> createState() => _HelpCenterSuccessViewState();
}

class _HelpCenterSuccessViewState extends State<HelpCenterSuccessView> {
  //Vars
  final _messageController = TextEditingController();
  final _messageFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.user?.isPremium() ?? false) {
      _messageFocus.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: _bodyView(context),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: double.maxFinite,
      margin: const EdgeInsets.only(top: FiicoPaddings.eight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.cardShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _messageslistView(context),
          _messageFieldView(context),
        ],
      ),
    );
  }

  Widget _messageslistView(BuildContext context) {
    final messages = widget.conversation?.messages ?? [];

    if (messages.isEmpty) {
      return _emptyMessagesView();
    }

    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: FiicoPaddings.twenyFour,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _getMessagesList(messages),
          ),
        ),
      ),
    );
  }

  Widget _emptyMessagesView() {
    return Expanded(
      child: SingleChildScrollView(
        reverse: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: FiicoPaddings.sixtyTwo,
                left: FiicoPaddings.sixtyTwo,
              ),
              child: Opacity(
                opacity: 0.35,
                child: Image.asset(
                  GIFmages.emptyState,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: FiicoPaddings.sixtyTwo,
                left: FiicoPaddings.sixtyTwo,
              ),
              child: Text(
                FiicoLocale().doYouHaveAnyConcerns,
                style: Style.subtitle.copyWith(color: FiicoColors.grayNeutral),
                maxLines: FiicoMaxLines.ten,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _messageFieldView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(
        FiicoPaddings.eight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BorderContainer(
            child: Row(
              children: [
                const Visibility(
                  visible: false,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: FiicoPaddings.eight,
                    ),
                    child: Icon(
                      Icons.attach_file_outlined,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      bottom: FiicoPaddings.twenty,
                    ),
                    child: FiicoTextfield(
                      hintText: FiicoLocale().sendNewMessage,
                      maxLines: FiicoMaxLines.one,
                      textEditingController: _messageController,
                      focusNode: _messageFocus,
                      textInputAction: TextInputAction.send,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) => _sendNewMessage(context),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: FiicoPaddings.sixteen,
                  ),
                  child: GestureDetector(
                    onTap: () => _sendNewMessage(context),
                    child: Icon(
                      Icons.send,
                      color: _messageController.text.isEmpty
                          ? FiicoColors.graySoft
                          : FiicoColors.grayDark,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _getMessagesList(List<HelpCenterMessage>? messages) {
    List<Widget> messagesViews = [];
    var orderedMessages =
        messages?.groupListsBy((element) => element.sortDate());
    orderedMessages?.forEach((key, value) {
      messagesViews.add(
        HelpCenterDateView(message: HelpCenterMessage().date(key)),
      );
      final messages = value.sorted(
          (a, b) => a.createdAt!.seconds.compareTo(b.createdAt!.seconds));
      for (var message in messages) {
        switch (message.type) {
          case HelpCenterMessage.textType:
            messagesViews.add(HelpCenterTextView(message: message));
            break;
          default:
        }
      }
    });

    return messagesViews;
  }

  void _sendNewMessage(BuildContext context) {
    final text = _messageController.text;
    final isAvailable = widget.user?.isPremium() ?? false;
    if (text.isNotEmpty && isAvailable) {
      context
          .read<HelpCenterBloc>()
          .add(HelpCenterNeMessageFetchRequest(text: text));
      _messageController.clear();
    } else if (!isAvailable) {
      _showErrorUserNotPremium(context);
    }
  }

  void _showErrorUserNotPremium(BuildContext context) {
    FiicoAlertDialog.showWarnning(
      context,
      title: 'Actualiza tu plan a Premium!',
      message:
          'Actualiza tu plan para poder disfrutar de todos los beneficios sin limite',
    );
  }
}
