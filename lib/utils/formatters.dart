/// Small formatting helpers shared across screens.
class Formatters {
  static String price(num? value) =>
      '\$${(value ?? 0).toDouble().toStringAsFixed(2)}';

  /// "mens-shirts" -> "Mens Shirts"
  static String category(String? raw) {
    if (raw == null || raw.isEmpty) return 'Uncategorised';
    return raw
        .split(RegExp(r'[-_\s]+'))
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  static String dateTime(DateTime value) {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(value.day)}/${two(value.month)}/${value.year}, '
        '${two(value.hour)}:${two(value.minute)}';
  }
}
