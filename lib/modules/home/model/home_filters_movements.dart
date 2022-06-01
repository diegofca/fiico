import 'package:control/helpers/manager/localizable_manager.dart';

class HomeFilterMovement {
  final itemsFilter = {
    0: FiicoLocale().mostRecent,
    1: FiicoLocale().fromSmallestToLargest,
    2: FiicoLocale().fromLargesttToSmallest,
    3: FiicoLocale().incomes,
    4: FiicoLocale().outcomes,
    5: FiicoLocale().pendingExpenses,
    6: FiicoLocale().paidExpenses,
  };
}
