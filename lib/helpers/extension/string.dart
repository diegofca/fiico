extension StringExtension on String {
  bool isUrl() {
    return Uri.tryParse(this)?.hasAbsolutePath ?? false;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
