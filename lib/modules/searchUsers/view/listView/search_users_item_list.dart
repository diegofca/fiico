// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_profile_image.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/bloc/search_users_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SearchUserListItemView extends StatefulWidget {
  SearchUserListItemView({
    Key? key,
    required this.user,
    required this.isSelected,
    this.isClickeable = true,
  }) : super(key: key);

  final bool isClickeable;
  final bool isSelected;
  FiicoUser user;

  @override
  State<SearchUserListItemView> createState() => SearchUserListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class SearchUserListItemViewState extends State<SearchUserListItemView> {
  final _segmentOptions = {
    0: FiicoLocale().readOnly,
    1: FiicoLocale().readingAndWriting
  };

  var selectedSegment = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isClickeable) {
          context
              .read<SearchUsersBloc>()
              .add(SearchSelectUserRequest(widget.user));
        }
      },
      child: AnimatedContainer(
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
        height: widget.isSelected ? 150 : 90,
        color: Colors.white.withOpacity(0),
        width: double.maxFinite,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            _bodyUser(),
            _onPermissionSelector(),
          ],
        ),
      ),
    );
  }

  Widget _bodyUser() {
    return SizedBox(
      height: 90,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconView(),
          _userDataView(),
          _onSelectedView(),
        ],
      ),
    );
  }

  Widget _iconView() {
    return Padding(
      padding: const EdgeInsets.all(FiicoPaddings.sixteen),
      child: Container(
        width: 60,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            FiicoPaddings.eight,
          ),
          color: FiicoColors.white,
        ),
        child: FiicoProfileNetwork.user(
          url: widget.user.profileImage,
        ),
      ),
    );
  }

  Widget _userDataView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameView(),
          _emailView(),
        ],
      ),
    );
  }

  Widget _nameView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        widget.user.firstName ?? '',
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _emailView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.two),
      child: Wrap(
        children: [
          Text(
            widget.user.email ?? '',
            style: Style.subtitle.copyWith(
              color: FiicoColors.graySoft,
              fontSize: FiicoFontSize.xm,
            ),
          ),
        ],
      ),
    );
  }

  Widget _onPermissionSelector() {
    selectedSegment = widget.user.getPermission();
    return Visibility(
      visible: widget.isSelected,
      child: Padding(
        padding: const EdgeInsets.only(top: FiicoPaddings.eight),
        child: CupertinoSlidingSegmentedControl<int>(
          groupValue: selectedSegment,
          backgroundColor: FiicoColors.white,
          thumbColor: FiicoColors.pink,
          children: {
            0: _generateSegmentView(selectedSegment, 0),
            1: _generateSegmentView(selectedSegment, 1),
          },
          onValueChanged: (index) {
            context.read<SearchUsersBloc>().add(SearchSelectSegment(
                  user: widget.user.copyWith(
                    budgetPermission: index == 0 ? 'READ' : 'WRITE',
                  ),
                ));
          },
        ),
      ),
    );
  }

  Widget _generateSegmentView(int? selectedSegment, int index) {
    final key = _segmentOptions.keys.elementAt(index);
    return Text(
      _segmentOptions.values.elementAt(index),
      textAlign: TextAlign.center,
      style: Style.subtitle.copyWith(
        color: key == selectedSegment
            ? FiicoColors.black
            : FiicoColors.grayNeutral,
      ),
    );
  }

  Widget _onSelectedView() {
    return Visibility(
      visible: widget.isSelected,
      child: Container(
        width: 60,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            FiicoPaddings.eight,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(FiicoPaddings.sixteen),
          child: Icon(
            MdiIcons.check,
            color: FiicoColors.greenNeutral,
          ),
        ),
      ),
    );
  }
}
