import 'package:intl/intl.dart';

extension StringExtension on String {
  /// Mengubah string menjadi title case
  /// Contoh: "hello world" -> "Hello World"
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  /// Mengecek apakah string adalah email yang valid
  bool isValidEmail() {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Mengecek apakah string adalah URL yang valid
  bool isValidUrl() {
    return RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    ).hasMatch(this);
  }

  /// Mengecek apakah string adalah nomor telepon yang valid (Indonesia)
  bool isValidPhoneNumber() {
    return RegExp(r'^(\+62|62|0)[0-9]{9,12}$').hasMatch(this);
  }

  /// Menghapus semua whitespace dari string
  String removeWhitespace() {
    return replaceAll(RegExp(r'\s+'), '');
  }

  /// Mengambil inisial dari string (untuk avatar)
  /// Contoh: "John Doe" -> "JD"
  String getInitials() {
    if (isEmpty) return '';
    final words = trim().split(' ');
    if (words.length == 1) {
      return words[0][0].toUpperCase();
    }
    return (words[0][0] + words[1][0]).toUpperCase();
  }

  /// Memotong string jika lebih panjang dari [maxLength]
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}$suffix';
  }

  /// Mengubah string menjadi format currency (Rupiah)
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// '1000000'.toCurrency(); // "Rp 1.000.000"
  /// ```
  String toCurrency({String symbol = 'Rp '}) {
    if (isEmpty) return '${symbol}0';
    final number = double.tryParse(this) ?? 0;
    return '$symbol${number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  /// Parse string currency menjadi number
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// 'Rp 1.000.000'.parseRupiah(); // 1000000
  /// '1.000.000'.parseRupiah(); // 1000000
  /// 'invalid'.parseRupiah(); // null
  /// ```
  num? parseRupiah() {
    try {
      // Hapus simbol dan titik
      final cleaned = this
          .replaceAll('Rp', '')
          .replaceAll(' ', '')
          .replaceAll('.', '')
          .trim();
      return num.parse(cleaned);
    } catch (e) {
      return null;
    }
  }

  /// Parse string tanggal dari format ISO menjadi DateTime
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final dateString = '2024-01-15';
  /// final date = dateString.toIsoDate(); // DateTime(2024, 1, 15)
  /// 
  /// // Jika format tidak valid, return null
  /// final invalid = 'invalid-date'.toIsoDate(); // null
  /// ```
  DateTime? toIsoDate() {
    try {
      return DateFormat('yyyy-MM-dd').parse(this);
    } catch (e) {
      return null;
    }
  }
}

