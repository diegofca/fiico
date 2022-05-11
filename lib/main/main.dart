import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/helpers/manager/firebase_manager.dart';
import 'package:control/helpers/manager/purchase_manager.dart';
import 'package:control/modules/connectivity/bloc%20/connectivity_bloc.dart';
import 'package:control/modules/connectivity/repository/connectivity_repository.dart';
import 'package:control/modules/splash/view/splash_page.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initFacebook();
  initPurchase();
  await initFirebase();
  runApp(const ValiuApp());
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

class ValiuApp extends StatelessWidget {
  const ValiuApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ConnectivityBloc(
            connectivityRepository: ConnectivityRepository(),
          )..add(const ConnectivityStartListening()),
        )
      ],
      child: const OverlaySupport.global(
        child: GlobalLoaderOverlay(
          overlayColor: FiicoColors.black,
          useDefaultLoading: false,
          overlayWidget: LoadingView(
            backgroundColor: FiicoColors.purpleDark,
          ),
          child: MaterialApp(
            title: 'Valiu',
            home: SplashPage(),
          ),
        ),
      ),
    );
  }
}
