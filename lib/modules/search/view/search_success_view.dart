import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/movement.dart';
import 'package:control/models/user.dart';
import 'package:control/modules/search/bloc/search_bloc.dart';
import 'package:control/modules/search/view/widgets/search_budgets_result_list.dart';
import 'package:control/modules/search/view/widgets/search_movements_result_list.dart';
import 'package:control/modules/search/view/widgets/search_users_result_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class SearchSuccessView extends StatelessWidget {
  SearchSuccessView({
    Key? key,
    required this.usersStream,
    required this.budgetsStream,
    required this.movementsStream,
  }) : super(key: key);

  final items = 10;

  final Stream<List<User>>? usersStream;
  final Stream<List<Budget>>? budgetsStream;
  final Stream<List<Movement>>? movementsStream;

  final _segmentOptions = {0: ' Todo ', 1: ' Usuarios ', 2: ' Presupuesto '};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _emptySearchView(),
        SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _segmentSearchView(context),
              _bodySearchView(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _emptySearchView() {
    return const Center(
      child: Text(
        'No se encontraron resultados en la busqueda.',
        style: Style.subtitle,
        maxLines: 2,
      ),
    );
  }

  Widget _bodySearchView(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: FiicoColors.grayBackground,
        padding: const EdgeInsets.only(
          bottom: FiicoPaddings.thirtyTwo,
        ),
        child: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraint.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    _searchUsersListView(context),
                    _searcBudgetsListView(context),
                    _searcMovementsListView(context),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _segmentSearchView(BuildContext context) {
    final selectedSegment = context.read<SearchBloc>().state.index;
    return Padding(
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
        bottom: FiicoPaddings.sixteen,
      ),
      child: CupertinoSlidingSegmentedControl<int>(
        groupValue: selectedSegment,
        backgroundColor: FiicoColors.white,
        thumbColor: FiicoColors.pink,
        children: {
          0: _generateSegmentView(selectedSegment, 0),
          1: _generateSegmentView(selectedSegment, 1),
          2: _generateSegmentView(selectedSegment, 2),
        },
        onValueChanged: (index) =>
            context.read<SearchBloc>().add(SearchSelectSegment(index: index)),
      ),
    );
  }

  Widget _generateSegmentView(int? selectedSegment, int index) {
    final key = _segmentOptions.keys.elementAt(index);
    return Text(
      _segmentOptions.values.elementAt(index),
      textAlign: TextAlign.center,
      style: Style.subtitle.copyWith(
        color: key == selectedSegment
            ? FiicoColors.black
            : FiicoColors.grayNeutral,
      ),
    );
  }

  Widget _searchUsersListView(BuildContext context) {
    final state = context.read<SearchBloc>().state;
    return StreamBuilder<List<User>>(
      stream: usersStream,
      builder: (context, snapshot) {
        return SearchUsersListView(
          users: state.showUsers ? snapshot.data ?? [] : [],
        );
      },
    );
  }

  Widget _searcBudgetsListView(BuildContext context) {
    final state = context.read<SearchBloc>().state;
    return StreamBuilder<List<Budget>>(
      stream: budgetsStream,
      builder: (context, snapshot) {
        return SearchBudgetsListView(
          budgets: state.showBudgets ? snapshot.data ?? [] : [],
        );
      },
    );
  }

  Widget _searcMovementsListView(BuildContext context) {
    final state = context.read<SearchBloc>().state;
    return StreamBuilder<List<Movement>>(
      stream: movementsStream,
      builder: (context, snapshot) {
        return SearchMovementsListView(
          movements: state.showBudgets ? snapshot.data ?? [] : [],
        );
      },
    );
  }
}
