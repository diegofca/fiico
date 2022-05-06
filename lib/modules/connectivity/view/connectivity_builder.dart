import 'package:control/helpers/manager/firebase_manager.dart';
import 'package:control/modules/connectivity/bloc%20/connectivity_bloc.dart';
import 'package:control/modules/connectivity/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityBuilder extends StatefulWidget {
  const ConnectivityBuilder({
    Key? key,
    required this.childWithConnectivity,
    required this.childWithoutConnectivity,
    required this.pageName,
  }) : super(key: key);

  factory ConnectivityBuilder.noConnection({
    Key? key,
    required Widget child,
    required String pageName,
  }) {
    return ConnectivityBuilder(
      key: key,
      pageName: pageName,
      childWithConnectivity: child,
      childWithoutConnectivity: const NoConnectivityPage(),
    );
  }

  final Widget childWithConnectivity;
  final Widget childWithoutConnectivity;
  final String pageName;

  @override
  State<ConnectivityBuilder> createState() => _ConnectivityBuilderState();
}

class _ConnectivityBuilderState extends State<ConnectivityBuilder>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!isCurrent) return;

    final connectivityBloc = context.read<ConnectivityBloc>();
    FirebaseManager.addContext(context);

    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        connectivityBloc
            .add(const ConnectivityUpdateIsResumed(isResumed: false));
        break;
      case AppLifecycleState.resumed:
        connectivityBloc
            .add(const ConnectivityUpdateIsResumed(isResumed: true));
        break;
    }
  }

  bool get isCurrent => mounted && ModalRoute.of(context)!.isCurrent;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectivityBloc, ConnectivityState>(
      buildWhen: (previus, current) => current.isResumed && isCurrent,
      builder: (context, state) {
        return state.connected
            ? widget.childWithConnectivity
            : widget.childWithoutConnectivity;
      },
    );
  }
}
