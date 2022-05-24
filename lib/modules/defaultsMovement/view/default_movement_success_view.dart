// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/bloc/default_movement_bloc.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:control/modules/defaultsMovement/view/widgets/default_movement_item_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultMovementSuccessView extends StatelessWidget {
  DefaultMovementSuccessView({
    Key? key,
    required this.movementList,
    required this.onMovementSelected,
  }) : super(key: key);

  final MovementsList movementList;
  final Function(Movement) onMovementSelected;
  final _scrollController = ScrollController(initialScrollOffset: 0.0);

  int selectedSegment = 0;
  final Map<int, Widget> _segmentOptions = {};

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      width: double.maxFinite,
      child: Column(
        children: [
          _segmentTabsView(context),
          _movementGridView(
            movementList,
            onMovementSelected,
          ),
        ],
      ),
    );
  }

  Widget _segmentTabsView(BuildContext context) {
    selectedSegment = context.read<DefaultMovementBloc>().state.index ?? 0;
    for (var e in movementList.items) {
      _segmentOptions.addAll({e.id: _generateSegmentView(e)});
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
        bottom: FiicoPaddings.thirtyTwo,
      ),
      child: CupertinoSlidingSegmentedControl<int>(
        groupValue: selectedSegment,
        backgroundColor: FiicoColors.white,
        thumbColor: FiicoColors.pink,
        children: _segmentOptions,
        onValueChanged: (index) => context
            .read<DefaultMovementBloc>()
            .add(DefaultMovementSelectSegment(index: index)),
      ),
    );
  }

  Widget _generateSegmentView(MovementGroup group) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: FiicoPaddings.sixteen,
      ),
      child: Text(
        group.name,
        textAlign: TextAlign.center,
        style: Style.subtitle.copyWith(
          color: group.id == selectedSegment
              ? FiicoColors.black
              : FiicoColors.grayNeutral,
        ),
      ),
    );
  }

  Widget _movementGridView(
    MovementsList movementList,
    Function(Movement) onMovementSelected,
  ) {
    return Expanded(
      child: RawScrollbar(
        isAlwaysShown: true,
        controller: _scrollController,
        thickness: 3,
        child: Padding(
          padding: const EdgeInsets.only(bottom: FiicoPaddings.sixteen),
          child: GridView.builder(
            itemCount: movementList.items[selectedSegment].items.length,
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(),
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 1 / 5.7,
            ),
            itemBuilder: (context, index) {
              Movement movement =
                  movementList.items[selectedSegment].items[index];
              return Container(
                margin: const EdgeInsets.only(bottom: FiicoPaddings.eight),
                child: DefaultMovementListItemView(
                  movement: movement,
                  onSelected: (movement) {
                    Navigator.of(context).pop();
                    onMovementSelected.call(movement);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
