import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/editProfile/bloc/edit_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HelpCenterSuccessView extends StatefulWidget {
  const HelpCenterSuccessView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  State<HelpCenterSuccessView> createState() => _HelpCenterSuccessViewState();
}

class _HelpCenterSuccessViewState extends State<HelpCenterSuccessView> {
  //Vars
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _bodyView(context),
        ],
      ),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: FiicoPaddings.eight),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
          boxShadow: [FiicoShadow.cardShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _messageslistView(context),
            _messageFieldView(context),
          ],
        ),
      ),
    );
  }

  Widget _messageslistView(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: FiicoPaddings.twenyFour,
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(
            vertical: FiicoPaddings.twenyFour,
          ),
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: FiicoPaddings.eight,
                  ),
                  child: Icon(
                    Icons.attach_file_outlined,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(bottom: 20),
                    child: FiicoTextfield(
                      hintText: "Enviar mensaje nuevo",
                      maxLines: FiicoMaxLines.one,
                      textEditingController: _messageController,
                      onChanged: (userName) {
                        context
                            .read<EditProfileBloc>()
                            .add(EditProfileInfoRequest(userName: userName));
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: FiicoPaddings.sixteen,
                  ),
                  child: Icon(Icons.send),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
