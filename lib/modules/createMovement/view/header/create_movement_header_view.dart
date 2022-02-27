import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_image.dart';
import 'package:control/helpers/genericViews/fiico_selector_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/alert/view/alert_selector_view.dart';
import 'package:control/modules/createMovement/bloc/create_movement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class CreateMovementHeaderView extends StatefulWidget {
  const CreateMovementHeaderView({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement movement;

  @override
  State<CreateMovementHeaderView> createState() =>
      CreateMovementHeaderViewState();
}

class CreateMovementHeaderViewState extends State<CreateMovementHeaderView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _iconItem(),
          _bodyView(),
        ],
      ),
    );
  }

  Widget _iconItem() {
    return GestureDetector(
      onTap: () async {
        final icon = await FiicoSelectorIcon.select(context);
        context
            .read<CreateMovementBloc>()
            .add(CreateMovementInfoRequest(icon: icon));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.sixteen,
          bottom: FiicoPaddings.sixteen,
          right: FiicoPaddings.twenyFour,
          left: FiicoPaddings.twenyFour,
        ),
        child: Container(
          width: 75,
          height: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(FiicoPaddings.eight),
            color: FiicoColors.grayLite,
          ),
          child: widget.movement.getType() == MovementType.ENTRY
              ? FiicoImageNetwork.entry(
                  iconData: widget.movement.icon?.getIcon(),
                )
              : FiicoImageNetwork.debt(
                  iconData: widget.movement.icon?.getIcon(),
                ),
        ),
      ),
    );
  }

  Widget _bodyView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _nameItemView()),
              _bellIconView(),
            ],
          ),
          _dateView(),
        ],
      ),
    );
  }

  Widget _nameItemView() {
    return Text(
      widget.movement.name ?? '',
      maxLines: FiicoMaxLines.two,
      style: Style.title.copyWith(
        color: FiicoColors.grayDark,
        fontSize: FiicoFontSize.sm,
      ),
    );
  }

  Widget _dateView() {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(right: FiicoPaddings.eight),
              child: Icon(
                MdiIcons.calendar,
                color: FiicoColors.black,
                size: 20,
              ),
            ),
            Text(
              widget.movement.getAlertDate(),
              style: Style.subtitle.copyWith(
                color: FiicoColors.graySoft,
                fontSize: FiicoFontSize.xs,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bellIconView() {
    return GestureDetector(
      onTap: () {
        final bloc = context.read<CreateMovementBloc>();
        AlertSelectorView().show(
          context,
          alert: widget.movement.alert,
          onSelected: (alert) =>
              bloc.add(CreateMovementInfoRequest(alert: alert)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: FiicoPaddings.sixteen,
          bottom: FiicoPaddings.eight,
        ),
        child: Icon(
          MdiIcons.bell,
          color: widget.movement.getBellColor(),
          size: 20,
        ),
      ),
    );
  }
}
