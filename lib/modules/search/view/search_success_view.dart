import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/modules/home/view/listView/home_list_item_view.dart';
import 'package:flutter/material.dart';

class SearchSuccessView extends StatelessWidget {
  const SearchSuccessView({
    Key? key,
  }) : super(key: key);

  final items = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      color: FiicoColors.grayBackground,
      padding: const EdgeInsets.all(FiicoPaddings.thirtyTwo),
      // child: _listItemsView(),
    );
  }

  // Widget _listItemsView() {
  //   return Container(
  //     alignment: Alignment.center,
  //     width: double.maxFinite,
  //     padding: const EdgeInsets.symmetric(
  //       vertical: FiicoPaddings.sixteen,
  //     ),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(FiicoPaddings.sixteen),
  //       boxShadow: const [
  //         BoxShadow(
  //           color: FiicoColors.grayLite,
  //           blurRadius: 5,
  //           spreadRadius: 20,
  //         )
  //       ],
  //     ),
  //     child: ListView.builder(
  //       itemCount: 10,
  //       itemBuilder: (context, index) {
  //         return HomeListItemView(index: index);
  //       },
  //     ),
  //   );
  // }
}
