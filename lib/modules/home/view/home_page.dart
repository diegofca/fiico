// ignore_for_file: must_be_immutable

import 'package:control/helpers/extension/colors.dart';
import 'package:control/modules/home/view/appbar/home_sliver_app_bar.dart';
import 'package:flutter/material.dart';

import 'appbar/home_app_bar.dart';
import 'appbar/home_title_app_bar.dart';
import 'empty/home_empty_view.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  //TEMPORAL
  var items = 0;

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
        _mainAppBar(),
        _emptySliverView(widget.items),
        _listItemsView(widget.items),
      ],
    );
  }

  Widget _mainAppBar() {
    return HomeSliverAppBar(
      opacity,
      isHideBoards: widget.items == 0,
    );
  }

  Widget _listItemsView(int count) {
    return SliverVisibility(
      visible: count > 0,
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  widget.items += 1;
                  _scrollDown();
                });
              },
              child: ListTile(
                title: Center(child: Text('ItemSSSSS #$index')),
              ),
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
            return HomeEmptyView(
              onTapNewItem: () {
                widget.items += 1;
                setState(() {});
              },
            );
          },
          childCount: 1,
        ),
      ),
    );
  }

  void _scrollDown() {
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }
}
