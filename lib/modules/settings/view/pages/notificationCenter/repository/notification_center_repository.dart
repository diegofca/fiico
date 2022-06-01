import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/notification_center_option.dart';
import 'package:control/models/user.dart';
import 'package:control/network/firestore_path.dart';

abstract class NotificationCenterRepositoryAbs {
  Future<void> updateUser(
      FiicoUser? user, List<NotificationCenterOption>? options);
}

class NotificationCenterRepository extends NotificationCenterRepositoryAbs {
  final options = [
    NotificationCenterOption(
      id: 1,
      name: FiicoLocale().myMovements,
      key: 'movement',
      generic: false,
    ),
    NotificationCenterOption(
      id: 2,
      name: FiicoLocale().inviteToBudget,
      key: 'invite',
      generic: false,
    ),
    NotificationCenterOption(
      id: 3,
      name: FiicoLocale().deleteToBudget,
      key: 'delete',
      generic: false,
    ),
    NotificationCenterOption(
      id: 4,
      name: FiicoLocale().cycleCompletion,
      key: 'endcycle',
      generic: true,
    ),
    NotificationCenterOption(
      id: 5,
      name: FiicoLocale().budgetCompletion,
      key: 'endbudget',
      generic: true,
    ),
    NotificationCenterOption(
      id: 6,
      name: FiicoLocale().newsPremiumPlan,
      key: 'premium',
      generic: false,
    ),
    NotificationCenterOption(
      id: 7,
      name: FiicoLocale().helpCenterMessages,
      key: 'helpcenter',
      generic: false,
    ),
    NotificationCenterOption(
      id: 8,
      name: FiicoLocale().news,
      key: 'news',
      generic: true,
    ),
  ];

  final usersollections =
      FirebaseFirestore.instance.collection(Firestore.usersField);

  //Generic ----------------------------------------------------------
  @override
  Future<void> updateUser(
      FiicoUser? user, List<NotificationCenterOption>? options) {
    final updateUser = user?.copyWith(notificationsOptions: options);
    return usersollections.doc(user?.id).update(updateUser?.toJson() ?? {});
  }
}
