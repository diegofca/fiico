// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FiicoTopStyleTextfield extends Container {
  FiicoTopStyleTextfield({
    this.textEditingController,
    this.textColor = FiicoColors.grayNeutral,
    this.labelColor = FiicoColors.purpleDark,
    this.keyboardType,
    this.obscureText,
    this.labelText,
    this.focusNode,
    this.textStyle,
    this.textInputAction = TextInputAction.done,
    this.maxLines = FiicoMaxLines.ten,
    this.prefixIcon,
    this.suffixIcon,
    this.containError = false,
    this.errorText,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  final String? labelText;
  final String? errorText;
  final Color? textColor;
  final Color? labelColor;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? containError;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 55,
          padding: const EdgeInsets.symmetric(
            horizontal: FiicoPaddings.sixteen,
          ),
          child: TextField(
            controller: textEditingController,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            inputFormatters: inputFormatters,
            focusNode: focusNode,
            autocorrect: false,
            enableSuggestions: false,
            obscureText: obscureText ?? false,
            maxLines: maxLines,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            scrollPadding: EdgeInsets.zero,
            cursorColor: FiicoColors.purpleDark,
            decoration: InputDecoration(
              filled: true,
              labelText: labelText,
              labelStyle: Style.subtitle.copyWith(
                color: containError ?? false ? FiicoColors.pinkRed : labelColor,
              ),
              fillColor: FiicoColors.clear,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: containError ?? false
                      ? FiicoColors.pinkRed
                      : FiicoColors.purpleDark,
                  width: 2,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(
                  color: containError ?? false
                      ? FiicoColors.pinkRed
                      : FiicoColors.purpleDark,
                  width: 2,
                ),
              ),
            ),
            style: textStyle ??
                Style.subtitle.copyWith(
                  color: textColor,
                ),
          ),
        ),
        Visibility(
          // error messsage
          visible: containError ?? true,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: FiicoPaddings.sixteen,
              vertical: FiicoPaddings.four,
            ),
            child: Text(
              errorText ?? '',
              maxLines: FiicoMaxLines.four,
              style: Style.desc.copyWith(
                color: FiicoColors.pinkRed,
                fontSize: FiicoFontSize.xxs,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
