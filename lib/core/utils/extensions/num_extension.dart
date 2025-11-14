extension NumExtension on num {

  /// Format number menjadi string currency (Rupiah)
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final amount = 1000000;
  /// amount.toRupiah(); // "Rp 1.000.000"
  /// amount.toRupiah(showDecimals: true); // "Rp 1.000.000.00"
  /// amount.toRupiah(symbol: 'IDR '); // "IDR 1.000.000"
  /// ```
  String toRupiah({String symbol = 'Rp ', bool showDecimals = false}) {
    if (showDecimals) {
      return '$symbol${toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(\.\d+)?$)'),
        (Match m) => '${m[1]}.',
      )}';
    } else {
      return '$symbol${toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      )}';
    }
  }

  /// Format number menjadi string currency (Rupiah) - alias untuk toRupiah
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final amount = 1000000;
  /// amount.toCurrency(); // "Rp 1.000.000"
  /// ```
  String toCurrency({String symbol = 'Rp '}) {
    return toRupiah(symbol: symbol, showDecimals: false);
  }

  /// Format number menjadi string dengan separator ribuan (tanpa simbol)
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final amount = 1000000;
  /// amount.toFormattedString(); // "1.000.000"
  /// amount.toFormattedString(showDecimals: true); // "1.000.000.00"
  /// ```
  String toFormattedString({bool showDecimals = false}) {
    if (showDecimals) {
      return toStringAsFixed(2).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(\.\d+)?$)'),
        (Match m) => '${m[1]}.',
      );
    } else {
      return toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
    }
  }

  /// Format currency dengan format singkat
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// 1000000.toShortRupiah(); // "Rp 1.0jt"
  /// 1500000000.toShortRupiah(); // "Rp 1.5M"
  /// 5000.toShortRupiah(); // "Rp 5.0rb"
  /// ```
  String toShortRupiah({String symbol = 'Rp '}) {
    if (this >= 1000000000) {
      return '$symbol${(this / 1000000000).toStringAsFixed(1)}M';
    } else if (this >= 1000000) {
      return '$symbol${(this / 1000000).toStringAsFixed(1)}jt';
    } else if (this >= 1000) {
      return '$symbol${(this / 1000).toStringAsFixed(1)}rb';
    } else {
      return '$symbol${toStringAsFixed(0)}';
    }
  }
}

