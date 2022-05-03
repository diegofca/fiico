import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';

class SecurityCodeSuccessView extends StatefulWidget {
  const SecurityCodeSuccessView({
    Key? key,
  }) : super(key: key);

  @override
  State<SecurityCodeSuccessView> createState() =>
      SecurityCodeSuccessViewState();
}

class SecurityCodeSuccessViewState extends State<SecurityCodeSuccessView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: _settingsItemsList(context),
    );
  }

  Widget _settingsItemsList(BuildContext context) {
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
      ),
    );
  }
}
