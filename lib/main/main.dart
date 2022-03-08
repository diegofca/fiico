import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/genericViews/loading_view.dart';
import 'package:control/modules/login/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GlobalLoaderOverlay(
      overlayColor: FiicoColors.black,
      useDefaultLoading: false,
      overlayWidget: LoadingView(),
      child: MaterialApp(
        title: 'Fiico',
        home: LoginPage(),
      ),
    );
  }
}
