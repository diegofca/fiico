import 'package:flutter/material.dart';

class SettingItem {
  final String name;
  final Icon? icon;
  final VoidCallback? onTap;
  final List<SettingItem>? childs;

  SettingItem({
    required this.name,
    this.icon,
    this.onTap,
    this.childs = const [],
  });
}
