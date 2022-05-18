import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/date.dart';
import 'package:control/helpers/extension/num.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createBudget/bloc/create_budget_bloc.dart';
import 'package:control/modules/editMovement/view/edit_movement_page.dart';
import 'package:control/navigation/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateBudgetMovementListItemView extends StatefulWidget {
  const CreateBudgetMovementListItemView({
    Key? key,
    required this.movement,
    required this.budget,
  }) : super(key: key);

  final Movement movement;
  final Budget budget;

  @override
  State<CreateBudgetMovementListItemView> createState() =>
      CreateBudgetMovementListItemViewState();

  Size get preferredSize => throw UnimplementedError();
}

class CreateBudgetMovementListItemViewState
    extends State<CreateBudgetMovementListItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDetailViewed(),
      child: Container(
        color: Colors.white,
        height: 75,
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _icon(),
            _nameAndDateView(),
            _priceAndDescView(),
          ],
        ),
      ),
    );
  }

  Widget _icon() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
        bottom: FiicoPaddings.eight,
        right: FiicoPaddings.sixteen,
      ),
      child: Container(
        width: 60,
        height: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FiicoPaddings.eight),
          color: FiicoColors.grayLite,
        ),
        child: Padding(
          padding: const EdgeInsets.all(FiicoPaddings.four),
          child: widget.movement.getIcon(),
        ),
      ),
    );
  }

  Widget _nameAndDateView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameView(),
          _dateView(),
        ],
      ),
    );
  }

  Widget _nameView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        widget.movement.name ?? '',
        maxLines: 1,
        style: Style.title.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.xm,
        ),
      ),
    );
  }

  Widget _dateView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.four),
      child: Text(
        widget.movement.createdAt?.toDate().toDateFormat1() ?? '',
        style: Style.subtitle.copyWith(
          color: FiicoColors.graySoft,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  Widget _priceAndDescView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _priceView(),
        _descriptionView(),
      ],
    );
  }

  Widget _priceView() {
    return Padding(
      padding: const EdgeInsets.only(bottom: FiicoPaddings.eight),
      child: Text(
        widget.movement.getValue()?.toCurrencyCompat() ?? '',
        style: TextStyle(
          color: widget.movement.getTypeColor(),
          fontWeight: FontWeight.bold,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  Widget _descriptionView() {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.four),
      child: Text(
        widget.movement.typeDescription ?? '',
        style: Style.desc.copyWith(
          color: FiicoColors.graySoft,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }

  void _onDetailViewed() async {
    final bloc = context.read<CreateBudgetBloc>();
    final movement = await FiicoRoute.send(
      context,
      EditMovementPage(
        movementToEdit: widget.movement,
        budget: widget.budget,
        addedinBudget: true,
      ),
    );
    if (movement != null) {
      bloc.add(CreateBudgetRemovedMovement(movement: widget.movement));
      bloc.add(CreateBudgetAddedmovement(movement: movement));
    }
  }
}
