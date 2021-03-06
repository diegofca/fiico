import 'package:control/helpers/database/shared_preference.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/profile_image.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/profile/view/profile_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';

class HomeTitleAppBar extends StatefulWidget {
  const HomeTitleAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.user,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final FiicoUser? user;

  @override
  State<HomeTitleAppBar> createState() => HomeTitleAppBarState();

  Size get preferredSize => throw UnimplementedError();
}

class HomeTitleAppBarState extends State<HomeTitleAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _columnTexts(),
        _profileImage(context, widget.user),
      ],
    );
  }

  Widget _columnTexts() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.sixteen,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _title(widget.title),
            _subtitle(widget.subtitle),
          ],
        ),
      ),
    );
  }

  //  Titulo del navigation bar
  Widget _title(String textTitle) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.eight,
        left: FiicoPaddings.eight,
      ),
      child: Text(
        textTitle,
        style: Style.title.copyWith(
          color: FiicoColors.white,
        ),
      ),
    );
  }

  //  Subtitulo del navigation bar
  Widget _subtitle(String textSubtitle) {
    return Padding(
      padding: const EdgeInsets.only(
        left: FiicoPaddings.eight,
      ),
      child: Text(
        textSubtitle,
        style: Style.subtitle.copyWith(
          color: FiicoColors.purpleSoft,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  //  Imagen de perfil del navigation bar
  Widget _profileImage(BuildContext context, FiicoUser? user) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: ProfileImage(
        user: user,
        onProfileTap: () async {
          final user = await Preferences.get.getUser();
          FiicoRoute.send(context, ProfilePage(user: user));
        },
      ),
    );
  }
}
