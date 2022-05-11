import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_alert_dialog.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/genericViews/tags_view.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createMovement/view/widgets/create_movement_day_selector.dart';
import 'package:control/modules/editMovement/bloc/edit_movement_bloc.dart';
import 'package:control/modules/editMovement/view/widgets/edit_movement_item_header.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class EditMovementSuccessView extends StatefulWidget {
  const EditMovementSuccessView({
    Key? key,
    required this.movement,
    this.budget,
  }) : super(key: key);

  final Movement movement;
  final Budget? budget;

  @override
  State<EditMovementSuccessView> createState() =>
      EditMovementSuccessViewState();
}

class EditMovementSuccessViewState extends State<EditMovementSuccessView> {
  //Vars
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  final _categoriesController = TextEditingController();
  final _currencyFormarted = CurrencyTextInputFormatter(
    decimalDigits: 0,
    symbol: '',
  );

  @override
  void initState() {
    super.initState();
    setState(() {
      _nameController.text = widget.movement.name ?? '';
      _descController.text = widget.movement.description ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      child: Column(
        children: [
          _headerView(),
          _bodyView(context),
        ],
      ),
    );
  }

  Widget _headerView() {
    return Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      height: 110,
      decoration: BoxDecoration(
        color: FiicoColors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: [FiicoShadow.cardShadow],
      ),
      child: EditMovementDetailHeaderView(
        movement: widget.movement,
        budget: widget.budget,
      ),
    );
  }

  Widget _bodyView(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.topCenter,
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: FiicoPaddings.fourtySix),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
          boxShadow: [FiicoShadow.cardShadow],
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: FiicoPaddings.twenyFour,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: FiicoPaddings.twenyFour,
              ),
              child: _inputsListView(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputsListView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _entryPriceView(context),
        _entryNameView(context),
        _entryDescriptionView(context),
        _entryDateView(context),
        _entryCategoryView(context),
        _categoriesList(context),
        // _createButtonView(context),
      ],
    );
  }

  Widget _entryPriceView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: FiicoPaddings.four,
      ),
      child: BorderContainer(
        padding: const EdgeInsets.only(left: FiicoPaddings.sixteen),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: FiicoPaddings.four,
                top: FiicoPaddings.four,
              ),
              child: Text(
                widget.movement.currency ?? '',
                style: Style.subtitle.copyWith(
                  color: widget.movement.getTypeColor(),
                  fontSize: FiicoFontSize.lg,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                child: FiicoTextfield(
                  keyboardType: TextInputType.number,
                  hintText: 'Ingresa el valor',
                  textColor: widget.movement.getTypeColor(),
                  inputFormatters: <TextInputFormatter>[_currencyFormarted],
                  onChanged: (value) {
                    final value = _currencyFormarted.getUnformattedValue();
                    context
                        .read<EditMovementBloc>()
                        .add(EditMovementInfoRequest(value: value));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryNameView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.sixteen,
            ),
            child: Text(
              'Nombre',
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          BorderContainer(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: FiicoTextfield(
                hintText: 'Ingresa el nombre',
                textEditingController: _nameController,
                onChanged: (name) {
                  context
                      .read<EditMovementBloc>()
                      .add(EditMovementInfoRequest(name: name));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryDescriptionView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.sixteen,
            ),
            child: Text(
              'Descripción',
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          BorderContainer(
            heigth: 100,
            child: FiicoTextfield(
              hintText: 'Ingresa una descripción',
              keyboardType: TextInputType.multiline,
              textEditingController: _descController,
              onChanged: (description) {
                context
                    .read<EditMovementBloc>()
                    .add(EditMovementInfoRequest(description: description));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryDateView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.sixteen,
            ),
            child: Text(
              widget.movement.getDateTitleText(),
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          BorderContainer(
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(
                      left: FiicoPaddings.sixteen,
                    ),
                    child: Text(
                      widget.movement.getRecurrencyDate(),
                      textAlign: TextAlign.left,
                      style: Style.subtitle.copyWith(
                        color: FiicoColors.graySoft,
                        fontSize: FiicoFontSize.sm,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => CreateMovementDaySelectorView().show(
                    context,
                    budget: widget.budget,
                    selectedDays: widget.movement.recurrencyAt,
                    onDaySelected: (days) {
                      context
                          .read<EditMovementBloc>()
                          .add(EditMovementInfoRequest(markDays: days));
                    },
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: FiicoColors.pink,
                    size: 34,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryCategoryView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: FiicoPaddings.sixteen,
            ),
            child: Text(
              'Categorias',
              textAlign: TextAlign.start,
              style: Style.subtitle.copyWith(
                fontSize: FiicoFontSize.sm,
              ),
            ),
          ),
          BorderContainer(
            alignment: Alignment.center,
            child: Row(
              children: [
                Expanded(
                  child: FiicoTextfield(
                    textEditingController: _categoriesController,
                    hintText: 'Ej: Arriendo, auto',
                    onSubmitted: (text) => _addedTagCategory(context),
                  ),
                ),
                IconButton(
                  onPressed: () => _addedTagCategory(context),
                  icon: const Icon(
                    MdiIcons.plusCircleOutline,
                    color: FiicoColors.pink,
                    size: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _categoriesList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
      child: FiicoTagsView(
        tags: widget.movement.tags,
        isDeleteTag: true,
        onDeleteTag: (int index) => _removedTagCategory(context, index),
      ),
    );
  }

  Widget _createButtonView(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        top: FiicoPaddings.sixteen,
      ),
      child: FiicoButton(
        title: widget.movement.getType() == MovementType.ENTRY
            ? 'Modificar ingreso'
            : 'Modificar gasto',
        color: widget.movement.getTypeColor(),
        onTap: () => _editMovement(context),
      ),
    );
  }

  void _editMovement(BuildContext context) {
    if (widget.movement.isCompleteByCreate()) {
      if (widget.movement.isAddedWithBudget) {
        Navigator.of(context).pop(widget.movement);
      } else {
        context.read<EditMovementBloc>().add(EditMovementAddedRequest(
            newMovement: widget.movement, budget: widget.budget));
      }
    } else {
      FiicoAlertDialog.showWarnning(context,
          title: 'Campos vacios',
          message:
              'Completa los campos faltantes para poder agregar tu movimiento a tu presupuesto.');
    }
  }

  void _addedTagCategory(BuildContext context) {
    if (_categoriesController.text.length > 2) {
      final category = _categoriesController.text;
      widget.movement.tags.add(category);
      context
          .read<EditMovementBloc>()
          .add(EditMovementInfoRequest(tags: widget.movement.tags));
    }
  }

  void _removedTagCategory(BuildContext context, int index) {
    widget.movement.tags.removeAt(index);
    context
        .read<EditMovementBloc>()
        .add(EditMovementInfoRequest(tags: widget.movement.tags));
  }
}
