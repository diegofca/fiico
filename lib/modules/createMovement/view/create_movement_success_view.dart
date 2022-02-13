import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/helpers/genericViews/fiico_textfield.dart';
import 'package:control/helpers/genericViews/tags_view.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createMovement/bloc/create_movement_bloc.dart';
import 'package:control/modules/createMovement/view/header/create_movement_header_view.dart';
import 'package:control/modules/createMovement/view/widgets/create_movement_date_selector.dart';
import 'package:control/modules/createMovement/view/widgets/create_movement_recurrency_selector.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:control/helpers/extension/date.dart';

class CreateMovementSuccessView extends StatelessWidget {
  CreateMovementSuccessView({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement movement;

  final _categoriesController = TextEditingController();
  final _currencyFormarted = CurrencyTextInputFormatter(
    decimalDigits: 0,
    symbol: '',
  );

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
      child: CreateMovementHeaderView(type: movement.getType()),
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
        _entryRecurrenceView(context),
        _entryDateView(context),
        _entryCategoryView(context),
        _categoriesList(context),
        _createButtonView(context),
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
                movement.currency ?? '',
                style: Style.subtitle.copyWith(
                  color: FiicoColors.purpleSoft,
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
                  textColor: FiicoColors.purpleSoft,
                  inputFormatters: <TextInputFormatter>[_currencyFormarted],
                  onChanged: (value) {
                    final value = _currencyFormarted.getUnformattedValue();
                    context
                        .read<CreateMovementBloc>()
                        .add(CreateMovementInfoRequest(value: value));
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
                onChanged: (name) {
                  context
                      .read<CreateMovementBloc>()
                      .add(CreateMovementInfoRequest(name: name));
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
            heigth: 150,
            child: FiicoTextfield(
              hintText: 'Ingresa una descripción',
              keyboardType: TextInputType.multiline,
              onChanged: (description) {
                context
                    .read<CreateMovementBloc>()
                    .add(CreateMovementInfoRequest(description: description));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _entryRecurrenceView(BuildContext context) {
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
              'Recurrencia',
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
                      movement.recurrency ?? 'Ej: Cada mes',
                      textAlign: TextAlign.left,
                      style: Style.subtitle.copyWith(
                        color: FiicoColors.graySoft,
                        fontSize: FiicoFontSize.sm,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => CreateMovementRecurrencySelectorView().show(
                    context,
                    onRecurrencySelected: (recurrency) {
                      context.read<CreateMovementBloc>().add(
                          CreateMovementInfoRequest(
                              recurrency: recurrency.name));
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
              'Fecha',
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
                      movement.createdAt?.toDate().toDateFormat2() ?? '',
                      textAlign: TextAlign.left,
                      style: Style.subtitle.copyWith(
                        color: FiicoColors.graySoft,
                        fontSize: FiicoFontSize.sm,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => CreateMovementDateSelectorView().show(
                    context,
                    initalDate: movement.createdAt?.toDate(),
                    onDateSelected: (date) {
                      context
                          .read<CreateMovementBloc>()
                          .add(CreateMovementInfoRequest(date: date));
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
        tags: movement.tags,
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
      child: FiicoButton.green(
        title: 'Crear ingreso',
        ontap: () => _createdMovement(context),
      ),
    );
  }

  void _createdMovement(BuildContext context) {
    if (movement.isAddedWithBudget) {
      Navigator.of(context).pop(movement);
    } else {
      context
          .read<CreateMovementBloc>()
          .add(CreateMovementAddedRequest(newMovement: movement));
    }
  }

  void _addedTagCategory(BuildContext context) {
    if (_categoriesController.text.length > 2) {
      final category = _categoriesController.text;
      movement.tags.add(category);
      context
          .read<CreateMovementBloc>()
          .add(CreateMovementInfoRequest(tags: movement.tags));
    }
  }

  void _removedTagCategory(BuildContext context, int index) {
    movement.tags.removeAt(index);
    context
        .read<CreateMovementBloc>()
        .add(CreateMovementInfoRequest(tags: movement.tags));
  }
}