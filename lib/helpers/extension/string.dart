extension StringExtension on String {
  bool isUrl() {
    return Uri.tryParse(this)?.hasAbsolutePath ?? false;
  }
}
