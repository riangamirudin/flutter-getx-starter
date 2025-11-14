import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension BuildContextExtension on BuildContext {
  /// Mendapatkan MediaQuery dengan mudah
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final mediaQuery = context.mediaQuery;
  /// final orientation = mediaQuery.orientation;
  /// final devicePixelRatio = mediaQuery.devicePixelRatio;
  /// ```
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Mendapatkan ukuran layar
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final size = context.screenSize;
  /// print('Width: ${size.width}, Height: ${size.height}');
  /// ```
  Size get screenSize => mediaQuery.size;

  /// Mendapatkan lebar layar
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final width = context.screenWidth;
  /// Container(width: width * 0.8) // 80% dari lebar layar
  /// ```
  double get screenWidth => screenSize.width;

  /// Mendapatkan tinggi layar
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final height = context.screenHeight;
  /// SizedBox(height: height * 0.5) // 50% dari tinggi layar
  /// ```
  double get screenHeight => screenSize.height;

  /// Mendapatkan padding top (untuk status bar)
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final topPadding = context.paddingTop;
  /// Padding(
  ///   padding: EdgeInsets.only(top: topPadding),
  ///   child: YourWidget(),
  /// )
  /// ```
  double get paddingTop => mediaQuery.padding.top;

  /// Mendapatkan padding bottom (untuk navigation bar)
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final bottomPadding = context.paddingBottom;
  /// Padding(
  ///   padding: EdgeInsets.only(bottom: bottomPadding),
  ///   child: YourWidget(),
  /// )
  /// ```
  double get paddingBottom => mediaQuery.padding.bottom;

  /// Mendapatkan ThemeData
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final theme = context.theme;
  /// final primaryColor = theme.primaryColor;
  /// final textTheme = theme.textTheme;
  /// ```
  ThemeData get theme => Theme.of(this);

  /// Mendapatkan TextTheme
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final textTheme = context.textTheme;
  /// Text('Hello', style: textTheme.headlineLarge)
  /// ```
  TextTheme get textTheme => theme.textTheme;

  /// Mendapatkan ColorScheme
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final colorScheme = context.colorScheme;
  /// Container(color: colorScheme.primary)
  /// ```
  ColorScheme get colorScheme => theme.colorScheme;

  /// Mendapatkan brightness (light/dark)
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final brightness = context.brightness;
  /// if (brightness == Brightness.dark) {
  ///   // Dark mode logic
  /// }
  /// ```
  Brightness get brightness => theme.brightness;

  /// Mengecek apakah dalam mode dark
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// if (context.isDarkMode) {
  ///   // Tampilkan widget untuk dark mode
  ///   return DarkWidget();
  /// } else {
  ///   return LightWidget();
  /// }
  /// ```
  bool get isDarkMode => brightness == Brightness.dark;

  /// Mendapatkan ScaffoldMessenger untuk show snackbar
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// final messenger = context.scaffoldMessenger;
  /// messenger.showSnackBar(SnackBar(content: Text('Hello')));
  /// ```
  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  /// Menampilkan snackbar dengan mudah
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Snackbar sederhana
  /// context.showSnackBar('Data berhasil disimpan');
  /// 
  /// // Snackbar dengan custom color
  /// context.showSnackBar(
  ///   'Error terjadi',
  ///   backgroundColor: Colors.red,
  ///   textColor: Colors.white,
  /// );
  /// 
  /// // Snackbar dengan action
  /// context.showSnackBar(
  ///   'Item dihapus',
  ///   action: SnackBarAction(
  ///     label: 'UNDO',
  ///     onPressed: () => undoDelete(),
  ///   ),
  /// );
  /// ```
  void showSnackBar(
    String message, {
    Color? backgroundColor,
    Color? textColor,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
      ),
    );
  }

  /// Menampilkan dialog dengan mudah
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Dialog sederhana
  /// context.showDialog(
  ///   builder: (context) => AlertDialog(
  ///     title: Text('Konfirmasi'),
  ///     content: Text('Apakah Anda yakin?'),
  ///     actions: [
  ///       TextButton(
  ///         onPressed: () => context.goBack(),
  ///         child: Text('Batal'),
  ///       ),
  ///       TextButton(
  ///         onPressed: () => context.goBack(true),
  ///         child: Text('Ya'),
  ///       ),
  ///     ],
  ///   ),
  /// );
  /// 
  /// // Dialog dengan return value
  /// final result = await context.showDialog<bool>(
  ///   builder: (context) => AlertDialog(...),
  /// );
  /// if (result == true) {
  ///   // User memilih ya
  /// }
  /// ```
  Future<T?> showDialog<T>({
    required Widget Function(BuildContext) builder,
    bool barrierDismissible = true,
  }) {
    return Get.dialog<T>(
      builder(this),
      barrierDismissible: barrierDismissible,
    );
  }

  /// Menampilkan bottom sheet dengan mudah
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Bottom sheet sederhana
  /// context.showBottomSheet(
  ///   builder: (context) => Container(
  ///     padding: EdgeInsets.all(16),
  ///     child: Column(
  ///       mainAxisSize: MainAxisSize.min,
  ///       children: [
  ///         ListTile(title: Text('Option 1')),
  ///         ListTile(title: Text('Option 2')),
  ///       ],
  ///     ),
  ///   ),
  /// );
  /// 
  /// // Bottom sheet dengan return value
  /// final selected = await context.showBottomSheet<String>(
  ///   builder: (context) => BottomSheetWidget(),
  /// );
  /// ```
  Future<T?> showBottomSheet<T>({
    required Widget Function(BuildContext) builder,
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    return Get.bottomSheet<T>(
      builder(this),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
    );
  }

  /// Navigate ke route dengan mudah
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Navigate sederhana
  /// context.navigateTo('/home');
  /// 
  /// // Navigate dengan arguments
  /// context.navigateTo(
  ///   '/detail',
  ///   arguments: {'id': 123, 'name': 'Product'},
  /// );
  /// 
  /// // Navigate dengan return value
  /// final result = await context.navigateTo<String>('/edit');
  /// if (result != null) {
  ///   print('Data diupdate: $result');
  /// }
  /// ```
  Future<T?>? navigateTo<T>(String route, {dynamic arguments}) {
    return Get.toNamed<T>(route, arguments: arguments);
  }

  /// Navigate dan replace route dengan mudah
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Replace current route (tidak bisa back ke route sebelumnya)
  /// context.navigateToReplacement('/login');
  /// 
  /// // Replace dengan arguments
  /// context.navigateToReplacement(
  ///   '/profile',
  ///   arguments: {'userId': 123},
  /// );
  /// ```
  Future<T?>? navigateToReplacement<T>(String route, {dynamic arguments}) {
    return Get.offNamed<T>(route, arguments: arguments);
  }

  /// Navigate dan clear semua route sebelumnya
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Clear semua route dan navigate ke home (untuk logout)
  /// context.navigateToAndClearStack('/home');
  /// 
  /// // Clear stack dan navigate ke login
  /// context.navigateToAndClearStack('/login');
  /// ```
  Future<T?>? navigateToAndClearStack<T>(String route, {dynamic arguments}) {
    return Get.offAllNamed<T>(route, arguments: arguments);
  }

  /// Kembali ke route sebelumnya
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Kembali tanpa return value
  /// context.goBack();
  /// 
  /// // Kembali dengan return value
  /// context.goBack({'updated': true});
  /// 
  /// // Kembali dengan typed return value
  /// context.goBack<String>('Success');
  /// ```
  void goBack<T>([T? result]) {
    Get.back(result: result);
  }

  /// Mendapatkan argument yang dikirim dari route sebelumnya
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Di halaman detail, ambil data dari route sebelumnya
  /// final arguments = context.getArgument<Map<String, dynamic>>();
  /// if (arguments != null) {
  ///   final id = arguments['id'];
  ///   final name = arguments['name'];
  /// }
  /// 
  /// // Atau langsung cast ke model
  /// final user = context.getArgument<User>();
  /// if (user != null) {
  ///   print('User: ${user.name}');
  /// }
  /// ```
  T? getArgument<T>() {
    return Get.arguments as T?;
  }

  /// Mendapatkan parameter dari route
  /// 
  /// Contoh penggunaan:
  /// ```dart
  /// // Route: /user/:id
  /// // URL: /user/123
  /// final userId = context.getParameter<String>('id');
  /// // userId = '123'
  /// 
  /// // Route: /product/:id/:category
  /// // URL: /product/456/electronics
  /// final productId = context.getParameter<String>('id');
  /// final category = context.getParameter<String>('category');
  /// ```
  T? getParameter<T>(String key) {
    return Get.parameters[key] as T?;
  }
}

