import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/credentials_manager.dart';
import 'package:control/helpers/manager/firebase_manager.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:control/helpers/manager/purchase_manager.dart';
import 'package:control/modules/connectivity/bloc%20/connectivity_bloc.dart';
import 'package:control/modules/connectivity/repository/connectivity_repository.dart';
import 'package:control/modules/menu/menu.dart';
import 'package:control/modules/settings/view/pages/changeLanguage/repository/languages_list.dart';
import 'package:control/modules/splash/view/splash_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';

void main() async {
  initApp();
  initFacebook();
  initPurchase();
  initSmartLook();
  await initEasyLocation();
  await initFirebase();
  runApp(EasyLocalization(
    path: 'assets/locales',
    supportedLocales: Languages().items.map((e) => e.locale).toList(),
    saveLocale: true,
    child: const ValiuApp(),
  ));
}

void initApp() {
  WidgetsFlutterBinding.ensureInitialized();
}

Future<void> initEasyLocation() async {
  return EasyLocalization.ensureInitialized();
}

Future<void> initFirebase() async {
  return FirebaseManager.init();
}

void initFacebook() {
  FacebookAudienceNetwork.init(iOSAdvertiserTrackingEnabled: true);
}

void initPurchase() {
  PurchaseManager.get.configureStore();
}

void initSmartLook() {
  final SetupOptions options = (SetupOptionsBuilder(
    CredentialsManager.smartLook,
  )..StartNewSession = true)
      .build();
  Smartlook.setup(options);
  Smartlook.enableCrashlytics(true);
}

class ValiuApp extends StatelessWidget {
  const ValiuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FiicoLocale.locale = context.locale;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ConnectivityBloc(
            connectivityRepository: ConnectivityRepository(),
          )..add(const ConnectivityStartListening()),
        ),
        BlocProvider(
          create: (_) => MenuBloc(),
        )
      ],
      child: OverlaySupport.global(
        child: GlobalLoaderOverlay(
          overlayColor: FiicoColors.black,
          useDefaultLoading: false,
          overlayWidget: const LoadingView(
            backgroundColor: FiicoColors.purpleDark,
          ),
          child: SmartlookHelperWidget(
            child: MaterialApp(
              title: 'FinUp',
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              home: const SplashPage(),
            ),
          ),
        ),
      ),
    );
  }
}
