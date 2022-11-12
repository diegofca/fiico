import 'package:control/helpers/manager/localizable_manager.dart';

abstract class IntroRepositoryAbs {}

class IntroRepository extends IntroRepositoryAbs {
  List<String> texts = [
    FiicoLocale().createBudgetsAndControl,
    FiicoLocale().nowYouWontHaveProblems,
    FiicoLocale().shareYourQuotesWithFriends,
    FiicoLocale().financialSupportThatWillHelp,
    FiicoLocale().moreThanTwoDifferentLanguages,
    FiicoLocale().newBenefitsWithoutHavingToPayMore,
    FiicoLocale().reviewTheHistoryOfEachCycle,
  ];
}
