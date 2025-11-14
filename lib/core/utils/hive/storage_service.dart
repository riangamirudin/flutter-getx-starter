import 'package:hive_ce/hive.dart';
import 'package:flutter_getx_starter/core/utils/logger/app_logger.dart';
import 'package:flutter_getx_starter/core/utils/constants/app_constants.dart';

/// Service untuk menyimpan dan mengambil data dari local storage
/// 
/// Menggunakan Hive sebagai backend storage
class HiveService {
  static Box? _box;
  static bool _initialized = false;

  /// Initialize storage service
  /// 
  /// Pastikan Hive sudah diinisialisasi sebelum memanggil method ini
  /// Contoh: await Hive.initFlutter();
  static Future<void> init() async {
    if (_initialized && _box != null) return;
    try {
      // Pastikan Hive sudah diinisialisasi
      if (!Hive.isBoxOpen(AppConstants.localHiveDatabase)) {
        // Buka atau buat box
        _box = await Hive.openBox(AppConstants.localHiveDatabase);
      } else {
        // Jika box sudah terbuka, ambil reference-nya
        _box = Hive.box(AppConstants.localHiveDatabase);
      }
      _initialized = true;
      AppLogger.d('Storage service initialized with Hive');
    } catch (e) {
      AppLogger.e('Failed to initialize storage', e);
      rethrow;
    }
  }

  /// Menyimpan string value
  static Future<void> write(String key, String value) async {
    try {
      await _box?.put(key, value);
    } catch (e) {
      AppLogger.e('Failed to write storage: $key', e);
      rethrow;
    }
  }

  /// Menyimpan value dengan tipe apapun
  /// 
  /// Hive mendukung tipe data: String, int, double, bool, List, Map, DateTime, dll
  /// Untuk complex objects, pastikan sudah register adapter terlebih dahulu
  static Future<void> writeObject(String key, dynamic value) async {
    try {
      await _box?.put(key, value);
    } catch (e) {
      AppLogger.e('Failed to write storage: $key', e);
      rethrow;
    }
  }

  /// Membaca string value
  static String? read(String key) {
    try {
      final value = _box?.get(key);
      if (value is String) {
        return value;
      }
      return value?.toString();
    } catch (e) {
      AppLogger.e('Failed to read storage: $key', e);
      return null;
    }
  }

  /// Membaca value dengan tipe apapun
  static T? readObject<T>(String key) {
    try {
      final value = _box?.get(key);
      if (value is T) {
        return value;
      }
      return null;
    } catch (e) {
      AppLogger.e('Failed to read storage: $key', e);
      return null;
    }
  }

  /// Menghapus value berdasarkan key
  static Future<void> remove(String key) async {
    try {
      await _box?.delete(key);
    } catch (e) {
      AppLogger.e('Failed to remove storage: $key', e);
      rethrow;
    }
  }

  /// Menghapus semua data di box
  static Future<void> clear() async {
    try {
      await _box?.clear();
    } catch (e) {
      AppLogger.e('Failed to clear storage', e);
      rethrow;
    }
  }

  /// Mengecek apakah key ada di storage
  static bool hasData(String key) {
    return _box?.containsKey(key) ?? false;
  }

  /// Mendapatkan semua keys
  static List<String> getKeys() {
    try {
      return _box?.keys.cast<String>().toList() ?? [];
    } catch (e) {
      AppLogger.e('Failed to get storage keys', e);
      return [];
    }
  }

  /// Mendapatkan semua values
  static List<dynamic> getValues() {
    try {
      return _box?.values.toList() ?? [];
    } catch (e) {
      AppLogger.e('Failed to get storage values', e);
      return [];
    }
  }

  /// Mendapatkan semua entries (key-value pairs)
  static Map<dynamic, dynamic> getAll() {
    try {
      return Map.fromEntries(
        _box?.toMap().entries ?? <MapEntry<dynamic, dynamic>>[],
      );
    } catch (e) {
      AppLogger.e('Failed to get all storage data', e);
      return {};
    }
  }

  /// Menghitung jumlah data di storage
  static int get length => _box?.length ?? 0;

  /// Mengecek apakah box kosong
  static bool get isEmpty => _box?.isEmpty ?? true;

  /// Mengecek apakah box tidak kosong
  static bool get isNotEmpty => _box?.isNotEmpty ?? false;

  /// Menutup box (opsional, biasanya tidak perlu dipanggil)
  static Future<void> close() async {
    try {
      await _box?.close();
      _initialized = false;
      AppLogger.d('Storage box closed');
    } catch (e) {
      AppLogger.e('Failed to close storage', e);
    }
  }

  /// Delete box dari disk (hapus semua data permanen)
  static Future<void> deleteBox() async {
    try {
      await _box?.close();
      await Hive.deleteBoxFromDisk(AppConstants.localHiveDatabase);
      _initialized = false;
      _box = null;
      AppLogger.d('Storage box deleted from disk');
    } catch (e) {
      AppLogger.e('Failed to delete storage box', e);
      rethrow;
    }
  }
}

