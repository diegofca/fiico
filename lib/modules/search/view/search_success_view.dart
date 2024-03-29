import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/budget.dart';
import 'package:control/models/invite_friend.dart';
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
    required this.friendStream,
    required this.budgetsStream,
    required this.movementsStream,
    required this.invitesStream,
    required this.requestInvitesStream,
  }) : super(key: key);

  final items = 10;

  final Stream<List<FiicoUser>>? usersStream;
  final Stream<List<FiicoUser>>? friendStream;
  final Stream<List<Budget>>? budgetsStream;
  final Stream<List<Movement>>? movementsStream;
  final Stream<List<InviteFriend>>? invitesStream;
  final Stream<List<InviteFriend>>? requestInvitesStream;

  final _segmentOptions = {
    0: ' ${FiicoLocale().all} ',
    1: ' ${FiicoLocale().users} ',
    2: ' ${FiicoLocale().myBudgets} '
  };

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
    return Center(
      child: Text(
        FiicoLocale().thereNoResultsForYourSearch,
        style: Style.subtitle,
        maxLines: FiicoMaxLines.ten,
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
    return StreamBuilder<List<FiicoUser>>(
      stream: usersStream,
      builder: (context, snapshot) {
        return StreamBuilder<List<InviteFriend>>(
          stream: invitesStream,
          builder: (context, inviteSnapshot) {
            return StreamBuilder<List<InviteFriend>>(
              stream: requestInvitesStream,
              builder: (context, rInviteSnapshot) {
                return StreamBuilder<List<FiicoUser>>(
                  stream: friendStream,
                  builder: (context, friendsSnapshot) {
                    return SearchUsersListView(
                      users: state.showUsers ? snapshot.data ?? [] : [],
                      invites: inviteSnapshot.data ?? [],
                      requestInvites: rInviteSnapshot.data ?? [],
                      friends: friendsSnapshot.data ?? [],
                    );
                  },
                );
              },
            );
          },
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
