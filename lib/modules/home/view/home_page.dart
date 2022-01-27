import 'package:control/modules/home/view/appbar/home_sliver_app_bar.dart';
import 'package:flutter/material.dart';

import 'appbar/home_app_bar.dart';
import 'appbar/home_title_app_bar.dart';
import 'empty/home_empty_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _controller = ScrollController();

  double opacity = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      opacity = _controller.offset;
      setState(() {});
      if (_controller.position.atEdge) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(
        title: HomeTitleAppBar(
          title: "Hola, Diego",
          subtitle: "Controla tu dinero de la mejor manera",
          profileUrl: "",
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return CustomScrollView(
      controller: _controller,
      slivers: [
        HomeSliverAppBar(
          opacity,
          isHideBoards: false,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return const Expanded(
                  child: HomeEmptyView(),
                );
              }
              return ListTile(
                title: Center(child: Text('Item #$index')),
              );
            },
            childCount: 10,
          ),
        ),
      ],
    );
  }
}
