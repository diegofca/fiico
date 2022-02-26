// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FiicoTextfield extends Container {
  FiicoTextfield({
    this.textEditingController,
    this.textColor = FiicoColors.grayNeutral,
    this.hintColor = FiicoColors.graySoft,
    this.keyboardType,
    this.hintText,
    this.focusNode,
    this.textStyle,
    this.textInputAction = TextInputAction.done,
    this.inputFormatters,
    this.onChanged,
    this.onSubmitted,
    Key? key,
  }) : super(key: key);

  final String? hintText;
  final Color? textColor;
  final Color? hintColor;
  final TextInputType? keyboardType;
  final TextEditingController? textEditingController;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: FiicoPaddings.four,
      ),
      child: TextField(
        maxLines: FiicoMaxLines.ten,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        controller: textEditingController,
        focusNode: focusNode,
        autocorrect: false,
        enableSuggestions: false,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(
            left: FiicoPaddings.sixteen,
            top: FiicoPaddings.sixteen,
          ),
          border: InputBorder.none,
          hintText: hintText,
          isDense: true,
          hintStyle: textStyle ??
              Style.subtitle.copyWith(
                color: hintColor,
                fontSize: FiicoFontSize.sm,
              ),
        ),
        style: textStyle ??
            Style.subtitle.copyWith(
              color: textColor,
              fontSize: FiicoFontSize.sm,
            ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
