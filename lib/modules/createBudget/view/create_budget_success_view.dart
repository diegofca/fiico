import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/extension/shadow.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/border_container.dart';
import 'package:control/helpers/genericViews/fiico_button.dart';
import 'package:control/modules/createBudget/view/headerView/create_budget_header_view.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateBudgetSuccessView extends StatelessWidget {
  const CreateBudgetSuccessView({
    Key? key,
    required this.budgetName,
  }) : super(key: key);

  final String budgetName;

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
      child: CreateBudgetHeaderView(name: budgetName),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _entryMoneyView(context),
                  _entryDateView(),
                  _entrysView(),
                  _entrysDebtsView(),
                  _infoView(),
                  _shareButtonView(),
                  _separatorLineView(),
                  _createButtonView(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _entryMoneyView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: FiicoPaddings.sixteen,
          ),
          child: Text(
            'Moneda',
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
                  padding: const EdgeInsets.only(
                    left: FiicoPaddings.sixteen,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "COP",
                    textAlign: TextAlign.left,
                    style: Style.subtitle.copyWith(
                      color: FiicoColors.grayNeutral,
                      fontSize: FiicoFontSize.sm,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _showCurrencyPicker(context),
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
    );
  }

  Widget _entryDateView() {
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
                      'Ej: Viernes, Abril 20, 2021',
                      textAlign: TextAlign.left,
                      style: Style.subtitle.copyWith(
                        color: FiicoColors.graySoft,
                        fontSize: FiicoFontSize.sm,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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

  Widget _entrysView() {
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _separatorLineView(),
          Container(
            alignment: Alignment.center,
            height: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ingresos',
                  textAlign: TextAlign.start,
                  style: Style.subtitle.copyWith(
                    fontSize: FiicoFontSize.sm,
                  ),
                ),
                IconButton(
                  onPressed: () {},
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

  Widget _entrysDebtsView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _separatorLineView(),
        Container(
          alignment: Alignment.center,
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Gastos',
                textAlign: TextAlign.start,
                style: Style.subtitle.copyWith(
                  fontSize: FiicoFontSize.sm,
                ),
              ),
              IconButton(
                onPressed: () {},
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
    );
  }

  Widget _infoView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _separatorLineView(),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(top: FiicoPaddings.sixteen),
          height: 90,
          child: Text(
            'Puedes crear tus tableros y compartirlos con tus amigos y familiares, si estan tregistrados en Fiico podrán modificar tu tablero en cualquier momento.',
            textAlign: TextAlign.start,
            style: Style.desc.copyWith(
              fontSize: FiicoFontSize.xm,
              color: FiicoColors.grayNeutral,
            ),
          ),
        ),
      ],
    );
  }

  Widget _shareButtonView() {
    return GestureDetector(
      onTap: () {
        print("share button");
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: FiicoPaddings.sixteen,
          bottom: FiicoPaddings.thirtyTwo,
        ),
        child: SizedBox(
          child: Container(
            alignment: Alignment.center,
            height: 40,
            // width: 130,
            child: Padding(
              padding: const EdgeInsets.all(
                FiicoPaddings.eight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.ios_share,
                    size: 20,
                    color: FiicoColors.purpleSoft,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: FiicoPaddings.eight,
                    ),
                    child: Text(
                      'Share',
                      textAlign: TextAlign.start,
                      style: Style.desc.copyWith(
                        fontSize: FiicoFontSize.xm,
                        color: FiicoColors.purpleSoft,
                      ),
                    ),
                  )
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: FiicoColors.purpleSoft,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createButtonView() {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        top: FiicoPaddings.eight,
      ),
      child: FiicoButton.green(
        title: 'Crear ingreso',
        ontap: () {},
      ),
    );
  }

  Widget _separatorLineView() {
    return Container(
      color: FiicoColors.graySoft,
      height: 1,
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    showCurrencyPicker(
      context: context,
      showFlag: true,
      showCurrencyName: true,
      showCurrencyCode: true,
      onSelect: (Currency currency) {
        print('Select currency: ${currency.name}');
        print(currency.code);
        print(currency.symbol);
      },
      theme: CurrencyPickerThemeData(
        titleTextStyle: Style.subtitle.copyWith(
          color: FiicoColors.grayDark,
          fontSize: FiicoFontSize.sm,
        ),
        subtitleTextStyle: Style.subtitle.copyWith(
          color: FiicoColors.grayNeutral,
          fontSize: FiicoFontSize.xs,
        ),
      ),
    );
  }
}
