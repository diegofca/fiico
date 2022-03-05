// ignore_for_file: must_be_immutable

import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_top_title_textfield.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/modules/login/bloc/login_bloc.dart';
import 'package:control/modules/login/model/login_validator_email_model.dart';
import 'package:control/modules/login/model/login_validator_password_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginSuccesView extends StatefulWidget {
  const LoginSuccesView({
    Key? key,
    this.state,
  }) : super(key: key);

  final LoginState? state;

  @override
  State<LoginSuccesView> createState() => LoginSuccesViewState();
}

class LoginSuccesViewState extends State<LoginSuccesView> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GenericAppBar(
        bgColor: FiicoColors.clear,
        backColor: Colors.white,
        isShowBack: false,
      ),
      extendBodyBehindAppBar: true,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _headerView(),
            _bodyContainer(context),
          ],
        ),
      ),
    );
  }

  Widget _headerView() {
    return AspectRatio(
      aspectRatio: 3 / 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            SVGImages.loginTopBg,
            fit: BoxFit.cover,
          ),
          _titleHeaderView(),
        ],
      ),
    );
  }

  Widget _titleHeaderView() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Fiico',
            style: Style.title.copyWith(
              color: Colors.white,
              fontSize: 64,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: FiicoPaddings.thirtyTwo,
              left: FiicoPaddings.thirtyTwo,
              top: FiicoPaddings.thirtyTwo,
            ),
            child: Text(
              'Tu podrás manejar de la mejor manera tu dinero, controlar tus gastos y deudas e iniciar tus ahorros.',
              maxLines: FiicoMaxLines.ten,
              textAlign: TextAlign.center,
              style: Style.subtitle.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyContainer(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          _emailTextfieldView(context),
          const SizedBox(height: 20),
          _passwordTextfieldView(context),
        ],
      ),
    );
  }

  Widget _emailTextfieldView(BuildContext context) {
    final email = widget.state?.email?.email ?? '';
    final containtError = widget.state?.email?.isError ?? false;
    _emailEditingController.text = email;

    return FiicoTopStyleTextfield(
      textEditingController: _emailEditingController
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: email.length),
        ),
      labelText: 'Email',
      errorText: 'Invalidate email format.',
      prefixIcon: widget.state?.email?.getStatusIcon,
      suffixIcon: widget.state?.email?.getRigthStatusIcon,
      onChanged: (text) {
        var email = EmailValidatorModel(text);
        context.read<LoginBloc>().add(LoginValidateEmailRequest(email));
      },
      containError: containtError,
    );
  }

  Widget _passwordTextfieldView(BuildContext context) {
    final password = widget.state?.password?.password ?? '';
    final containtError = widget.state?.password?.isError ?? false;
    final isShowPassword = widget.state?.isShowPassword ?? false;
    final statusColor = widget.state?.password?.getStatusColor;

    _passwordEditingController.text = password;

    return FiicoTopStyleTextfield(
      textEditingController: _passwordEditingController
        ..selection = TextSelection.fromPosition(
          TextPosition(offset: password.length),
        ),
      labelText: 'Password',
      errorText:
          'Invalidate password format. La contraseña debe contener una mayuscula, numeros y un caracter especial.',
      maxLines: 1,
      obscureText: !isShowPassword,
      prefixIcon: widget.state?.password?.getStatusIcon,
      suffixIcon: IconButton(
        focusColor: FiicoColors.clear,
        highlightColor: FiicoColors.clear,
        hoverColor: FiicoColors.clear,
        onPressed: () {
          context
              .read<LoginBloc>()
              .add(LoginPasswordIsShowRequest(!isShowPassword));
        },
        icon: Icon(
          isShowPassword ? MdiIcons.eyeOff : MdiIcons.eye,
          color: statusColor,
        ),
      ),
      onChanged: (text) {
        var pass = PasswordValidatorModel(text);
        context.read<LoginBloc>().add(LoginValidatePasswordRequest(pass));
      },
      containError: containtError,
    );
  }
}
