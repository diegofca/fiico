// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_top_title_textfield.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/modules/login/model/login_validator_email_model.dart';
import 'package:control/modules/login/model/login_validator_password_model.dart';
import 'package:control/modules/register/bloc/sign_bloc.dart';
import 'package:control/modules/register/model/last_name_validator_model.dart';
import 'package:control/modules/register/model/name_validator_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class SignSuccesView extends StatefulWidget {
  const SignSuccesView({
    Key? key,
    this.state,
  }) : super(key: key);

  final SignState? state;

  @override
  State<SignSuccesView> createState() => SignSuccesViewState();
}

class SignSuccesViewState extends State<SignSuccesView> {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _lastNameEditingController =
      TextEditingController();
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
        textColor: FiicoColors.purpleDark,
        bgColor: FiicoColors.clear,
        text: 'Sign Up',
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: SingleChildScrollView(
        physics: const RangeMaintainingScrollPhysics(),
        child: _bodyContainer(context),
      ),
    );
  }

  Widget _bodyContainer(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _nameTextfieldView(context),
          _lastnameTextfieldView(context),
          _emailTextfieldView(context),
          _passwordTextfieldView(context),
          _signUpButton(),
          _socialSignUpButtons(),
          _orSeparateView(),
          _logInButton(),
        ],
      ),
    );
  }

  Widget _nameTextfieldView(BuildContext context) {
    final name = widget.state?.name?.name ?? '';
    final containtError = widget.state?.name?.isError ?? false;
    _nameEditingController.text = name;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.eight,
        top: FiicoPaddings.sixteen,
      ),
      child: FiicoTopStyleTextfield(
        textEditingController: _nameEditingController
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: name.length),
          ),
        labelText: 'Name',
        errorText: 'Invalidate name format.',
        prefixIcon: widget.state?.name?.getStatusIcon,
        onChanged: (text) {
          var name = NameValidatorModel(text);
          context.read<SignBloc>().add(SignUpInfoRequest(name: name));
        },
        containError: containtError,
      ),
    );
  }

  Widget _lastnameTextfieldView(BuildContext context) {
    final lastName = widget.state?.lastName?.lastName ?? '';
    final containtError = widget.state?.lastName?.isError ?? false;
    _lastNameEditingController.text = lastName;

    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: FiicoTopStyleTextfield(
        textEditingController: _lastNameEditingController
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: lastName.length),
          ),
        labelText: 'Last name',
        errorText: 'Invalidate last name format.',
        prefixIcon: widget.state?.lastName?.getStatusIcon,
        onChanged: (text) {
          var lastName = LastNameValidatorModel(text);
          context.read<SignBloc>().add(SignUpInfoRequest(lastName: lastName));
        },
        containError: containtError,
      ),
    );
  }

  Widget _emailTextfieldView(BuildContext context) {
    final email = widget.state?.email?.email ?? '';
    final containtError = widget.state?.email?.isError ?? false;
    _emailEditingController.text = email;

    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: FiicoTopStyleTextfield(
        textEditingController: _emailEditingController
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: email.length),
          ),
        labelText: 'Email',
        errorText: 'Invalidate email format.',
        prefixIcon: widget.state?.email?.getStatusIcon,
        onChanged: (text) {
          var email = EmailValidatorModel(text);
          context.read<SignBloc>().add(SignUpInfoRequest(email: email));
        },
        containError: containtError,
      ),
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
              .read<SignBloc>()
              .add(SignUpPasswordIsShowRequest(!isShowPassword));
        },
        icon: Icon(
          isShowPassword ? MdiIcons.eyeOff : MdiIcons.eye,
          color: statusColor,
        ),
      ),
      onChanged: (text) {
        var pass = PasswordValidatorModel(text);
        context.read<SignBloc>().add(SignUpInfoRequest(password: pass));
      },
      containError: containtError,
    );
  }

  Widget _signUpButton() {
    return Container(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.oneHundredTwenty,
        right: FiicoPaddings.sixteen,
        left: FiicoPaddings.sixteen,
      ),
      width: double.maxFinite,
      child: FiicoButton(
        title: 'Sign Up',
        color: FiicoColors.purpleDark,
        onTap: () => context.read<SignBloc>().add(const SignUpIntentRequest()),
      ),
    );
  }

  Widget _socialSignUpButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
        vertical: FiicoPaddings.sixteen,
      ),
      width: double.maxFinite,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SvgPicture.asset(
              SVGImages.facebookIcon,
              width: 40,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SvgPicture.asset(
              SVGImages.googleIcon,
              width: 40,
            ),
          ),
          if (Platform.isIOS)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SvgPicture.asset(
                SVGImages.appleIcon,
                width: 40,
              ),
            )
        ],
      ),
    );
  }

  Widget _orSeparateView() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.twenyFour,
      ),
      height: 30,
      width: double.maxFinite,
      child: Row(
        children: const [
          Expanded(child: SeparatorView()),
          Expanded(
            child: Text(
              'or',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: SeparatorView()),
        ],
      ),
    );
  }

  Widget _logInButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
      ),
      width: double.maxFinite,
      child: FiicoButton(
        title: 'Log In',
        color: FiicoColors.white,
        textColor: FiicoColors.grayDark,
        borderColor: FiicoColors.grayDark,
        onTap: () async => Navigator.of(context).pop(),
      ),
    );
  }
}
