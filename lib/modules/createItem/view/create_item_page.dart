import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/createItem/view/create_item_success_view.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateItemPage extends StatelessWidget {
  const CreateItemPage({
    Key? key,
    required this.inBudget,
    required this.type,
  }) : super(key: key);

  final Budget inBudget;
  final MovementType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: inBudget.name,
        textColor: FiicoColors.black,
        actions: [_dotsButton()],
      ),
      body: BlocProvider(
        create: (context) => MenuBloc(),
        child: const CreateItemPageView(),
      ),
    );
  }

  Widget _dotsButton() {
    return Padding(
      padding: const EdgeInsets.only(
        right: FiicoPaddings.sixteen,
      ),
      child: IconButton(
        highlightColor: Colors.transparent,
        onPressed: () {
          print("dost button");
        },
        icon: const Icon(
          MdiIcons.dotsHorizontal,
          color: Colors.black,
        ),
      ),
    );
  }
}

class CreateItemPageView extends StatelessWidget {
  const CreateItemPageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        switch (state.status) {
          case MenuStatus.success:
            return const CreateItemSuccessView();
        }
      },
    );
  }
}
