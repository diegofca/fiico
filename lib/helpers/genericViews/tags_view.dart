// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/extension/font_styles.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

typedef DeleteTag<T> = void Function(T index);

class FiicoTagsView extends StatefulWidget {
  FiicoTagsView({
    Key? key,
    required this.tags,
    this.minTagViewHeight = 0,
    this.maxTagViewHeight = 150,
    this.tagBackgroundColor = FiicoColors.purpleLite,
    this.isDeleteTag = false,
    this.onDeleteTag,
  }) : super(key: key);

  List<String> tags;
  Color tagBackgroundColor;
  bool isDeleteTag;
  double maxTagViewHeight;
  double minTagViewHeight;
  DeleteTag<int>? onDeleteTag;

  @override
  _FiicoTagViewState createState() => _FiicoTagViewState();
}

class _FiicoTagViewState extends State<FiicoTagsView> {
  @override
  Widget build(BuildContext context) {
    return getTagView();
  }

  Widget getTagView() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: widget.minTagViewHeight,
        maxHeight: widget.maxTagViewHeight,
      ),
      child: SingleChildScrollView(
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 5.0,
          direction: Axis.horizontal,
          children: buildTags(),
        ),
      ),
    );
  }

  List<Widget> buildTags() {
    List<Widget> tags = <Widget>[];
    for (int i = 0; i < widget.tags.length; i++) {
      tags.add(createTag(i, widget.tags[i]));
    }
    return tags;
  }

  Widget createTag(int index, String tagTitle) {
    return Chip(
      backgroundColor: widget.tagBackgroundColor,
      label: Text(
        tagTitle,
        style: Style.subtitle.copyWith(
          color: FiicoColors.black,
          fontSize: FiicoFontSize.xm,
        ),
      ),
      deleteIcon: Visibility(
        visible: widget.isDeleteTag,
        child: const Icon(
          MdiIcons.close,
          size: 15,
        ),
      ),
      onDeleted: () => deleteTag(index),
    );
  }

  void deleteTag(int index) {
    if (widget.onDeleteTag != null) {
      widget.onDeleteTag!(index);
    }
  }
}
