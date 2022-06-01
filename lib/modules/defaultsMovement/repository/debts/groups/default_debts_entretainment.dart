import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/fiico_icons.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/models/fiico_icon.dart';
import 'package:control/models/movement.dart';
import 'package:control/modules/defaultsMovement/repository/default_movements_list.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:uuid/uuid.dart';

class EntretaimentDebtsMovements implements MovementGroup {
  @override
  final name = FiicoLocale().entretainment;

  @override
  final id = 2;

  @override
  MovementType get type => MovementType.DEBT;

  @override
  final items = [
    _netflix,
    _disneyPlus,
    _amazonPrime,
    _spotify,
    _hbo,
    _youtube,
    _appleMusic,
    _xboxGamePass,
    _psPlus,
    _magazine,
    _amazon,
    _rappiPrime,
    _deezer,
    _dropbox,
    _iCloud,
    _slack,
    _tMobile
  ];

  // Tarjeta de credito default
  static final _netflix = Movement(
    id: const Uuid().v1(),
    name: 'Netflix',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.netflix),
    type: MovementType.DEBT.name,
    description: FiicoLocale().netflixDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // Disney plus default
  static final _disneyPlus = Movement(
    id: const Uuid().v1(),
    name: 'Disney Plus',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(AppIcon.disneyPlus),
    type: MovementType.DEBT.name,
    description: FiicoLocale().disneyDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // Prime Video default
  static final _amazonPrime = Movement(
    id: const Uuid().v1(),
    name: 'Amazon Prime',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.amazon),
    type: MovementType.DEBT.name,
    description: FiicoLocale().amazonPrimeDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // Spotify default
  static final _spotify = Movement(
    id: const Uuid().v1(),
    name: 'Spotify',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.spotify),
    type: MovementType.DEBT.name,
    description: FiicoLocale().spotifyDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  // HBO default
  static final _hbo = Movement(
    id: const Uuid().v1(),
    name: 'HBO',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.hbo),
    type: MovementType.DEBT.name,
    description: FiicoLocale().hboDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _youtube = Movement(
    id: const Uuid().v1(),
    name: 'Youtube Music',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.youtube),
    type: MovementType.DEBT.name,
    description: FiicoLocale().youtubeDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _appleMusic = Movement(
    id: const Uuid().v1(),
    name: 'Apple Music',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.applemusic),
    type: MovementType.DEBT.name,
    description: FiicoLocale().appleMusicDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _xboxGamePass = Movement(
    id: const Uuid().v1(),
    name: 'Xbox Game Pass',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.xbox),
    type: MovementType.DEBT.name,
    description: FiicoLocale().xboxDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _psPlus = Movement(
    id: const Uuid().v1(),
    name: 'PlayStation Plus',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.playstation),
    type: MovementType.DEBT.name,
    description: FiicoLocale().psplusDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _magazine = Movement(
    id: const Uuid().v1(),
    name: FiicoLocale().magazine,
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.magazinePistol),
    type: MovementType.DEBT.name,
    description: FiicoLocale().magazineDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _amazon = Movement(
    id: const Uuid().v1(),
    name: 'Amazon AWS',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.amazonaws),
    type: MovementType.DEBT.name,
    description: FiicoLocale().amazonAwsDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _rappiPrime = Movement(
    id: const Uuid().v1(),
    name: 'Rappi Prime',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(MdiIcons.truckDelivery),
    type: MovementType.DEBT.name,
    description: FiicoLocale().rappiPrimeDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _deezer = Movement(
    id: const Uuid().v1(),
    name: 'Deezer',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.deezer),
    type: MovementType.DEBT.name,
    description: 'Saldo de suscripción en Deezer Premium',
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _dropbox = Movement(
    id: const Uuid().v1(),
    name: 'DropBox',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.dropbox),
    type: MovementType.DEBT.name,
    description: FiicoLocale().dropboxDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _iCloud = Movement(
    id: const Uuid().v1(),
    name: 'iCloud',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.icloud),
    type: MovementType.DEBT.name,
    description: FiicoLocale().icloudDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _slack = Movement(
    id: const Uuid().v1(),
    name: 'Slack',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.slack),
    type: MovementType.DEBT.name,
    description: FiicoLocale().slackDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );

  static final _tMobile = Movement(
    id: const Uuid().v1(),
    name: 'T-Mobile',
    value: null,
    createdAt: Timestamp.now(),
    recurrencyAt: null,
    icon: FiicoIcon.fromIcon(SimpleIcons.tmobile),
    type: MovementType.DEBT.name,
    description: FiicoLocale().tMobileDescription,
    typeDescription: null,
    currency: null,
    budgetName: null,
    alert: null,
    paymentStatus: 'Pending',
  );
}
