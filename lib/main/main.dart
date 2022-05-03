import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/remote_config.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/modules/connectivity/bloc%20/connectivity_bloc.dart';
import 'package:control/modules/connectivity/repository/connectivity_repository.dart';
import 'package:control/modules/splash/view/splash_page.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initFacebook();
  await initFirebase();
  runApp(const ValiuApp());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp();
  FiicoRemoteConfig.fetch();
  FirebaseFirestore.instance.settings =
      const Settings(sslEnabled: false, persistenceEnabled: false);
}

void initFacebook() {
  FacebookAudienceNetwork.init(iOSAdvertiserTrackingEnabled: true);
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
      child: const GlobalLoaderOverlay(
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
    );
  }
}
