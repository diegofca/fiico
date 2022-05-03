import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/settings/view/pages/security/view/security_success_view.dart';
import 'package:flutter/material.dart';

class SecurityPage extends StatelessWidget {
  const SecurityPage({
    Key? key,
    this.user,
  }) : super(key: key);

  final FiicoUser? user;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: 'Seguridad',
        textColor: FiicoColors.black,
      ),
      body: SecurityCodeSuccessView(),
    );
  }
}
