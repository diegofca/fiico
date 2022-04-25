import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/remote_config.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/modules/splash/view/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  runApp(const MyApp());
}

Future<void> initFirebase() async {
  await Firebase.initializeApp();
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  FiicoRemoteConfig.fetch();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GlobalLoaderOverlay(
      overlayColor: FiicoColors.black,
      useDefaultLoading: false,
      overlayWidget: LoadingView(
        backgroundColor: FiicoColors.purpleDark,
      ),
      child: MaterialApp(
        title: 'Fiiqo',
        home: SplashPage(),
      ),
    );
  }
}
