import 'package:control/helpers/extension/colors.dart';
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

  //TEMPORAL
  final items = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        opacity = _controller.offset;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.white,
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
          isHideBoards: items == 0,
        ),
        _emptySliverView(items),
        _listItemsView(items),
      ],
    );
  }

  Widget _listItemsView(int count) {
    return SliverVisibility(
      visible: count > 0,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ListTile(
              title: Center(child: Text('Item #$index')),
            );
          },
          childCount: count,
        ),
      ),
    );
  }

  Widget _emptySliverView(int count) {
    return SliverVisibility(
      visible: count == 0,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            return const HomeEmptyView();
          },
          childCount: 1,
        ),
      ),
    );
  }
}
