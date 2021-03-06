// ignore_for_file: must_be_immutable

import 'package:control/helpers/SVGImages.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_top_title_textfield.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/modules/login/bloc/login_bloc.dart';
import 'package:control/modules/login/model/login_validator_email_model.dart';
import 'package:control/modules/login/model/login_validator_password_model.dart';
import 'package:control/modules/login/view/login_social_buttons_view.dart';
import 'package:control/modules/register/view/sign_up_page.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/languages_list.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/view/change_language_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class LoginSuccesView extends StatefulWidget {
  LoginSuccesView({
    Key? key,
    this.state,
    required this.lang,
  }) : super(key: key);

  final LoginState? state;
  Language? lang;

  @override
  State<LoginSuccesView> createState() => LoginSuccesViewState();
}

class LoginSuccesViewState extends State<LoginSuccesView> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  final TextEditingController _emailRecoverEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar(
        bgColor: FiicoColors.clear,
        isShowBack: false,
        actions: [_flagHeaderView(context)],
      ),
      extendBodyBehindAppBar: true,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _headerView(context),
          _bodyContainer(context),
        ],
      ),
    );
  }

  Widget _headerView(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            SVGImages.loginTopBg2,
            fit: BoxFit.cover,
          ),
          _titleHeaderView(),
        ],
      ),
    );
  }

  Widget _flagHeaderView(BuildContext context) {
    return GestureDetector(
      onTap: () => _showlanguagePicker(context),
      child: Container(
        padding: const EdgeInsets.only(
          right: FiicoPaddings.sixteen,
        ),
        child: FlagIcon(widget.lang?.flag),
      ),
    );
  }

  Widget _titleHeaderView() {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            SVGImages.valiuIcon,
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: FiicoPaddings.thirtyTwo,
              left: FiicoPaddings.thirtyTwo,
              top: FiicoPaddings.thirtyTwo,
            ),
            child: Text(
              FiicoLocale().youWillAbleControlMoney,
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
    return Column(
      children: [
        _emailTextfieldView(context),
        _passwordTextfieldView(context),
        _forgotPasswordView(),
        _logInButton(),
        _socialLoginButtons(),
        _orSeparateView(),
        _signUpButton(),
      ],
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
        labelText: FiicoLocale().email,
        errorText: FiicoLocale().invalidEmailFormat,
        prefixIcon: widget.state?.email?.getStatusIcon,
        suffixIcon: widget.state?.email?.getRigthStatusIcon,
        onChanged: (text) {
          var email = EmailValidatorModel(text);
          context.read<LoginBloc>().add(LoginValidateEmailRequest(email));
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
      labelText: FiicoLocale().password,
      errorText: FiicoLocale().invalidPasswordFormat,
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

  Widget _forgotPasswordView() {
    return GestureDetector(
      onTap: () {
        FiicoAlertDialog.showCustom(
          context,
          title: FiicoLocale().enterEmail,
          body: FiicoTopStyleTextfield(
            labelText: '',
            keyboardType: TextInputType.emailAddress,
            textEditingController: _emailRecoverEditingController,
          ),
          onOkAction: () {
            final email = _emailRecoverEditingController.text;
            context.read<LoginBloc>().add(LoginForgotPasswordRequest(email));
          },
        );
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(
          FiicoPaddings.sixteen,
        ),
        alignment: Alignment.centerRight,
        child: Text(
          FiicoLocale().forgotPassword,
          style: Style.subtitle.copyWith(
            color: FiicoColors.purpleDark,
          ),
        ),
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
        title: FiicoLocale().logIn,
        color: FiicoColors.purpleDark,
        onTap: () => context.read<LoginBloc>().add(
              const LoginIntentRequest(
                LoginIntentProvider.email,
              ),
            ),
      ),
    );
  }

  Widget _socialLoginButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
        vertical: FiicoPaddings.sixteen,
      ),
      width: double.maxFinite,
      child: const SocialLoginButtonsView(),
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
        children: [
          const Expanded(child: SeparatorView()),
          Expanded(
            child: Text(
              FiicoLocale().or,
              textAlign: TextAlign.center,
            ),
          ),
          const Expanded(child: SeparatorView()),
        ],
      ),
    );
  }

  Widget _signUpButton() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
      ),
      width: double.maxFinite,
      child: FiicoButton(
        title: FiicoLocale().signUp,
        color: FiicoColors.white,
        textColor: FiicoColors.grayDark,
        borderColor: FiicoColors.grayDark,
        onTap: () async => FiicoRoute.send(
          context,
          const SignUpPage(),
        ),
      ),
    );
  }

  void _showlanguagePicker(BuildContext context) {
    FiicoRoute.send(
      context,
      ChangeLanguagePage(onSelectLanguage: (lang) {
        widget.lang = lang;
        setState(() {});
      }),
    );
  }
}
