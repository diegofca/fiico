import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/home/view/listView/home_list_item_view.dart';
import 'package:flutter/material.dart';

class SearchMovementsListView extends StatelessWidget {
  const SearchMovementsListView({
    Key? key,
    required this.movements,
  }) : super(key: key);

  final items = 20;
  final List<Movement> movements;

  final double _heigthCell = 100.0;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: movements.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.only(
          right: FiicoPaddings.thirtyTwo,
          left: FiicoPaddings.thirtyTwo,
          bottom: FiicoPaddings.thirtyTwo,
        ),
        child: Wrap(
          children: [
            _headerView(),
            _listItemsView(),
          ],
        ),
      ),
    );
  }

  Widget _headerView() {
    return Container(
      height: 40,
      alignment: Alignment.topLeft,
      child: Text(
        'Movimientos encontrados (${movements.length})',
        style: Style.subtitle,
      ),
    );
  }

  Widget _listItemsView() {
    return Container(
      height: movements.length * _heigthCell,
      alignment: Alignment.center,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
        boxShadow: const [
          BoxShadow(
            color: FiicoColors.grayLite,
            blurRadius: 5,
            spreadRadius: 20,
          )
        ],
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: movements.length,
        itemBuilder: (context, index) {
          final movement = movements[index];
          return HomeListItemView(
            movement: movement,
            budget: null,
            showValue: false,
          );
        },
      ),
    );
  }
}
