import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_profile_image.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/searchUsers/bloc/search_users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SearchUserListItemView extends StatefulWidget {
  const SearchUserListItemView({
    Key? key,
    required this.user,
    required this.isSelected,
  }) : super(key: key);

  final bool isSelected;
  final User user;

  @override
  State<SearchUserListItemView> createState() => SearchUserListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class SearchUserListItemViewState extends State<SearchUserListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<SearchUsersBloc>()
          .add(SearchSelectUserRequest(widget.user)),
      child: Container(
        color: Colors.white.withOpacity(0),
        child: SizedBox(
          height: 90,
          width: double.maxFinite,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _iconView(),
              _userDataView(),
              _onSelectedView(),
            ],
          ),
        ),
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
