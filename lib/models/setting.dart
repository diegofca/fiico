import 'package:flutter/material.dart';

class SettingGroup {
  final String name;
  final List<SettingItem>? items;

  SettingGroup({required this.name, this.items});
}

class SettingItem {
  final String name;
  final Icon? icon;
  final VoidCallback? onTap;

  SettingItem({required this.name, this.icon, this.onTap});
}
