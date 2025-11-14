/// Validator untuk form fields
class FormValidator {
  /// Validator untuk field required (wajib diisi)
  static String? required(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'Field ini wajib diisi';
    }
    return null;
  }

  /// Validator untuk email
  static String? email(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'Email wajib diisi';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return message ?? 'Format email tidak valid';
    }
    return null;
  }

  /// Validator untuk password
  static String? password(String? value, {String? message, int minLength = 8}) {
    if (value == null || value.isEmpty) {
      return 'Password wajib diisi';
    }
    if (value.length < minLength) {
      return message ?? 'Password minimal $minLength karakter';
    }
    return null;
  }

  /// Validator untuk konfirmasi password
  static String? confirmPassword(String? value, String? password, {String? message}) {
    if (value == null || value.isEmpty) {
      return 'Konfirmasi password wajib diisi';
    }
    if (value != password) {
      return message ?? 'Password tidak cocok';
    }
    return null;
  }

  /// Validator untuk nomor telepon (Indonesia)
  static String? phoneNumber(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'Nomor telepon wajib diisi';
    }
    final phoneRegex = RegExp(r'^(\+62|62|0)[0-9]{9,12}$');
    if (!phoneRegex.hasMatch(value)) {
      return message ?? 'Format nomor telepon tidak valid';
    }
    return null;
  }

  /// Validator untuk minimal panjang karakter
  static String? minLength(String? value, int min, {String? message}) {
    if (value == null || value.isEmpty) {
      return 'Field ini wajib diisi';
    }
    if (value.length < min) {
      return message ?? 'Minimal $min karakter';
    }
    return null;
  }

  /// Validator untuk maksimal panjang karakter
  static String? maxLength(String? value, int max, {String? message}) {
    if (value == null || value.isEmpty) {
      return null;
    }
    if (value.length > max) {
      return message ?? 'Maksimal $max karakter';
    }
    return null;
  }

  /// Validator untuk URL
  static String? url(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'URL wajib diisi';
    }
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    if (!urlRegex.hasMatch(value)) {
      return message ?? 'Format URL tidak valid';
    }
    return null;
  }

  /// Validator untuk angka
  static String? numeric(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'Field ini wajib diisi';
    }
    if (double.tryParse(value) == null) {
      return message ?? 'Harus berupa angka';
    }
    return null;
  }

  /// Validator untuk angka positif
  static String? positiveNumber(String? value, {String? message}) {
    if (value == null || value.trim().isEmpty) {
      return 'Field ini wajib diisi';
    }
    final number = double.tryParse(value);
    if (number == null || number <= 0) {
      return message ?? 'Harus berupa angka positif';
    }
    return null;
  }

  /// Validator kombinasi (multiple validators)
  static String? combine(List<String? Function()> validators) {
    for (final validator in validators) {
      final result = validator();
      if (result != null) return result;
    }
    return null;
  }
}

