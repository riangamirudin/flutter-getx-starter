import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Format tanggal menjadi string dengan format Indonesia
  /// Contoh: "15 Januari 2024"
  String toIndonesianDate() {
    final months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return '${day} ${months[month - 1]} $year';
  }

  /// Format tanggal menjadi string dengan format pendek
  /// Contoh: "15/01/2024"
  String toShortDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }

  /// Format tanggal dan waktu menjadi string
  /// Contoh: "15/01/2024 10:30"
  String toDateTimeString() {
    return DateFormat('dd/MM/yyyy HH:mm').format(this);
  }

  /// Format waktu menjadi string
  /// Contoh: "10:30"
  String toTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  /// Format tanggal menjadi string dengan format ISO
  /// Contoh: "2024-01-15"
  String toIsoDate() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  /// Mengecek apakah tanggal adalah hari ini
  bool isToday() {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Mengecek apakah tanggal adalah kemarin
  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Mengecek apakah tanggal adalah minggu ini
  bool isThisWeek() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return isAfter(startOfWeek.subtract(const Duration(days: 1))) &&
        isBefore(endOfWeek.add(const Duration(days: 1)));
  }

  /// Format relatif waktu (misalnya "2 jam yang lalu")
  String toRelativeTime() {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'tahun' : 'tahun'} yang lalu';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'bulan' : 'bulan'} yang lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'hari' : 'hari'} yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'jam' : 'jam'} yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'menit' : 'menit'} yang lalu';
    } else {
      return 'Baru saja';
    }
  }

  /// Mendapatkan awal hari dari tanggal
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final date = DateTime(2024, 1, 15, 14, 30);
  /// final start = date.startOfDay(); // 2024-01-15 00:00:00
  /// ```
  DateTime startOfDay() {
    return DateTime(year, month, day);
  }

  /// Mendapatkan akhir hari dari tanggal
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final date = DateTime(2024, 1, 15, 14, 30);
  /// final end = date.endOfDay(); // 2024-01-15 23:59:59.999
  /// ```
  DateTime endOfDay() {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }
}

