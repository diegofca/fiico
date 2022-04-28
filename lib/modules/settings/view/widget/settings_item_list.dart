import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/separator_view.dart';
import 'package:control/models/setting.dart';
import 'package:flutter/material.dart';

class SettingsListItemView extends StatefulWidget {
  const SettingsListItemView({
    Key? key,
    required this.settingGroup,
  }) : super(key: key);

  final SettingGroup settingGroup;

  @override
  State<SettingsListItemView> createState() => SettingsListItemViewState();
}

class SettingsListItemViewState extends State<SettingsListItemView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(FiicoPaddings.eight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _nameSettingItem(),
          _optionsListSettingItem(),
          _separatorView(),
        ],
      ),
    );
  }

  Widget _nameSettingItem() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: FiicoPaddings.sixteen,
      ),
      child: Text(
        widget.settingGroup.name,
        style: Style.subtitle.copyWith(
          fontSize: FiicoFontSize.xxs,
          color: FiicoColors.grayNeutral,
        ),
      ),
    );
  }

  Widget _optionsListSettingItem() {
    return SizedBox(
      height: (widget.settingGroup.items?.length ?? 0) * 40,
      child: ListView.builder(
        itemCount: widget.settingGroup.items?.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = widget.settingGroup.items?[index];
          return SizedBox(
            height: 40,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item?.name ?? '',
                    style: Style.subtitle.copyWith(
                      fontSize: FiicoFontSize.xm,
                      color: FiicoColors.grayDark,
                    ),
                  ),
                ),
                item?.icon ?? Container(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _separatorView() {
    return const Padding(
      padding: EdgeInsets.only(
        top: FiicoPaddings.sixteen,
        bottom: FiicoPaddings.sixteen,
      ),
      child: SeparatorView(
        color: FiicoColors.grayLite,
      ),
    );
  }
}
