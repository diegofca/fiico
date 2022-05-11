import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/fiico_selector_icon.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/alert/view/alert_selector_view.dart';
import 'package:control/modules/editMovement/bloc/edit_movement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditMovementDetailHeaderView extends StatefulWidget {
  const EditMovementDetailHeaderView({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  final Movement? movement;
  final Budget? budget;

  @override
  State<EditMovementDetailHeaderView> createState() =>
      EditMovementDetailHeaderViewState();
}

class EditMovementDetailHeaderViewState
    extends State<EditMovementDetailHeaderView> {
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
            .read<EditMovementBloc>()
            .add(EditMovementInfoRequest(icon: icon));
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
          child: widget.movement?.getIcon(),
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
          _statusAndDate(),
        ],
      ),
    );
  }

  Widget _nameItemView() {
    return SizedBox(
      width: 190,
      child: Text(
        widget.movement?.name ?? '',
        maxLines: FiicoMaxLines.two,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
      ),
    );
  }

  Widget _bellIconView() {
    return GestureDetector(
      onTap: () {
        final bloc = context.read<EditMovementBloc>();
        AlertSelectorView().show(
          context,
          movement: widget.movement,
          budget: widget.budget,
          onSelected: (alert) =>
              bloc.add(EditMovementInfoRequest(alert: alert)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          right: FiicoPaddings.sixteen,
          bottom: FiicoPaddings.eight,
        ),
        child: Icon(
          MdiIcons.bell,
          color: widget.movement?.getBellColor(),
          size: 20,
        ),
      ),
    );
  }

  Widget _statusAndDate() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: FiicoPaddings.eight),
            child: Icon(
              Icons.circle,
              color: widget.movement?.getTypeColor(),
              size: 12,
            ),
          ),
          Text(
            "Activo: ${widget.movement?.getAlertDate()}",
            style: Style.subtitle.copyWith(
              color: FiicoColors.graySoft,
              fontSize: FiicoFontSize.xs,
            ),
          ),
        ],
      ),
    );
  }
}
