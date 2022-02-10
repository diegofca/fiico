import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'entry_detail_success_view.dart';

class EntryDetailPage extends StatelessWidget {
  const EntryDetailPage({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: movement.budgetName,
        textColor: FiicoColors.graySoft,
        actions: [_dotsButton()],
      ),
      body: BlocProvider(
        create: (context) => MenuBloc(),
        child: EntryDetailPageView(movement: movement),
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

class EntryDetailPageView extends StatelessWidget {
  const EntryDetailPageView({
    Key? key,
    required this.movement,
  }) : super(key: key);

  final Movement movement;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        switch (state.status) {
          case MenuStatus.success:
            return EntryDetailSuccessView(
              movement: movement,
            );
        }
      },
    );
  }
}
