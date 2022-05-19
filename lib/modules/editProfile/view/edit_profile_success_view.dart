import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/editProfile/bloc/edit_profile_bloc.dart';
import 'package:control/modules/editProfile/view/widget/edit_profile_header_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileSuccessView extends StatefulWidget {
  const EditProfileSuccessView({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  State<EditProfileSuccessView> createState() => _EditProfileSuccessViewState();
}

class _EditProfileSuccessViewState extends State<EditProfileSuccessView> {
  //Vars
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user?.firstName ?? '';
    _lastNameController.text = widget.user?.lastName ?? '';
    _userNameController.text = widget.user?.userName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _headerView(context),
          _bodyView(context),
        ],
      ),
    );
  }

  Widget _headerView(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 110,
      decoration: BoxDecoration(
        color: FiicoColors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.cardShadow],
      ),
      child: EditProfileHeaderView(user: widget.user),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: FiicoPaddings.fourtySix),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
          boxShadow: [FiicoShadow.cardShadow],
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: FiicoPaddings.twenyFour,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FiicoPaddings.twenyFour,
              ),
              child: _inputsListView(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputsListView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      children: [
        _entryNameView(context),
        _entryLastNameView(context),
        _entryUserNameView(context),
        _saveProfileInfo(context),
      ],
    );
  }

  Widget _entryNameView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.sixteen,
            ),
            child: Text(
              FiicoLocale().name,
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          BorderContainer(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: FiicoTextfield(
                hintText: FiicoLocale().enterName,
                textEditingController: _nameController,
                onChanged: (name) {
                  context
                      .read<EditProfileBloc>()
                      .add(EditProfileInfoRequest(name: name));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryLastNameView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.sixteen,
            ),
            child: Text(
              FiicoLocale().lastName,
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          BorderContainer(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: FiicoTextfield(
                hintText: FiicoLocale().enterName,
                textEditingController: _lastNameController,
                onChanged: (lastName) {
                  context
                      .read<EditProfileBloc>()
                      .add(EditProfileInfoRequest(lastName: lastName));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryUserNameView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.sixteen,
            ),
            child: Text(
              FiicoLocale().userName,
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          BorderContainer(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: FiicoTextfield(
                hintText: FiicoLocale().enterName,
                textEditingController: _userNameController,
                onChanged: (userName) {
                  context
                      .read<EditProfileBloc>()
                      .add(EditProfileInfoRequest(userName: userName));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _saveProfileInfo(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: FiicoButton(
        title: FiicoLocale().saveChanges,
        color: FiicoColors.pink,
        onTap: () => context.read<EditProfileBloc>().add(
              const EditProfileRequest(),
            ),
      ),
    );
  }
}
