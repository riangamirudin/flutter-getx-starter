import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Base button widget dengan berbagai variasi
/// 
/// Contoh penggunaan:
/// ```dart
/// // 1. Button Primary (default)
/// DefaultButton(
///   text: 'Simpan',
///   onPressed: () => saveData(),
/// )
/// 
/// // 2. Button dengan icon
/// DefaultButton(
///   text: 'Kirim',
///   icon: Icons.send,
///   onPressed: () => sendData(),
/// )
/// 
/// // 3. Button Secondary
/// DefaultButton(
///   text: 'Batal',
///   type: ButtonType.secondary,
///   onPressed: () => cancel(),
/// )
/// 
/// // 4. Button Outline
/// DefaultButton(
///   text: 'Edit',
///   type: ButtonType.outline,
///   onPressed: () => editData(),
/// )
/// 
/// // 5. Button Text (tanpa background)
/// DefaultButton(
///   text: 'Lihat Detail',
///   type: ButtonType.text,
///   onPressed: () => viewDetail(),
/// )
/// 
/// // 6. Button Danger (untuk delete/hapus)
/// DefaultButton(
///   text: 'Hapus',
///   type: ButtonType.danger,
///   icon: Icons.delete,
///   onPressed: () => deleteData(),
/// )
/// 
/// // 7. Button dengan loading state
/// DefaultButton(
///   text: 'Submit',
///   isLoading: isLoading,
///   onPressed: isLoading ? null : () => submit(),
/// )
/// 
/// // 8. Button full width
/// DefaultButton(
///   text: 'Login',
///   isFullWidth: true,
///   onPressed: () => login(),
/// )
/// 
/// // 9. Button dengan custom size
/// DefaultButton(
///   text: 'Kecil',
///   size: ButtonSize.small,
///   onPressed: () => action(),
/// )
/// 
/// DefaultButton(
///   text: 'Besar',
///   size: ButtonSize.large,
///   onPressed: () => action(),
/// )
/// 
/// // 10. Button dengan custom color
/// DefaultButton(
///   text: 'Custom',
///   backgroundColor: Colors.purple,
///   textColor: Colors.white,
///   onPressed: () => action(),
/// )
/// 
/// // 11. Button disabled
/// DefaultButton(
///   text: 'Disabled',
///   onPressed: null, // Button akan otomatis disabled
/// )
/// ```
class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;

  const DefaultButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buttonStyle = _getButtonStyle(context, theme);
    final textStyle = _getTextStyle(context, theme);
    final padding = _getPadding();

    Widget button = _buildButton(context, buttonStyle, textStyle, padding);

    if (isFullWidth) {
      button = SizedBox(width: double.infinity, child: button);
    }

    return button;
  }

  ButtonStyle _getButtonStyle(BuildContext context, ThemeData theme) {
    final colors = theme.colorScheme;
    Color? bgColor = backgroundColor;
    Color fgColor;

    switch (type) {
      case ButtonType.primary:
        bgColor ??= colors.primary;
        fgColor = textColor ?? colors.onPrimary;
        break;
      case ButtonType.secondary:
        bgColor ??= colors.secondary;
        fgColor = textColor ?? colors.onSecondary;
        break;
      case ButtonType.outline:
        bgColor = Colors.transparent;
        fgColor = textColor ?? colors.primary;
        break;
      case ButtonType.text:
        bgColor = Colors.transparent;
        fgColor = textColor ?? colors.primary;
        break;
      case ButtonType.danger:
        bgColor ??= colors.error;
        fgColor = textColor ?? colors.onError;
        break;
    }

    return ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: fgColor,
      padding: _getPadding(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: type == ButtonType.outline
            ? BorderSide(color: fgColor)
            : BorderSide.none,
      ),
      elevation: type == ButtonType.text || type == ButtonType.outline ? 0 : 2,
    );
  }

  TextStyle _getTextStyle(BuildContext context, ThemeData theme) {
    switch (size) {
      case ButtonSize.small:
        return theme.textTheme.bodySmall ?? const TextStyle();
      case ButtonSize.medium:
        return theme.textTheme.bodyMedium ?? const TextStyle();
      case ButtonSize.large:
        return theme.textTheme.bodyLarge ?? const TextStyle();
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h);
      case ButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h);
      case ButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h);
    }
  }

  Widget _buildButton(
    BuildContext context,
    ButtonStyle style,
    TextStyle textStyle,
    EdgeInsets padding,
  ) {
    if (type == ButtonType.text) {
      return TextButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: _buildButtonContent(textStyle),
      );
    } else {
      return ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: _buildButtonContent(textStyle),
      );
    }
  }

  Widget _buildButtonContent(TextStyle textStyle) {
    if (isLoading) {
      return SizedBox(
        width: 16.w,
        height: 16.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor ?? Colors.white),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18.sp),
          SizedBox(width: 8.w),
          Text(text, style: textStyle),
        ],
      );
    }

    return Text(text, style: textStyle);
  }
}

/// Tipe button yang tersedia
/// 
/// Contoh penggunaan:
/// ```dart
/// ButtonType.primary   // Button utama dengan background solid
/// ButtonType.secondary // Button sekunder dengan warna berbeda
/// ButtonType.outline   // Button dengan border outline
/// ButtonType.text      // Button tanpa background (text only)
/// ButtonType.danger    // Button untuk aksi berbahaya (delete, dll)
/// ```
enum ButtonType {
  /// Button utama dengan background solid (default)
  primary,
  
  /// Button sekunder dengan warna berbeda
  secondary,
  
  /// Button dengan border outline, tanpa background
  outline,
  
  /// Button text tanpa background dan border
  text,
  
  /// Button untuk aksi berbahaya (delete, remove, dll)
  danger,
}

/// Ukuran button yang tersedia
/// 
/// Contoh penggunaan:
/// ```dart
/// ButtonSize.small   // Button kecil (padding kecil, font kecil)
/// ButtonSize.medium  // Button sedang (default)
/// ButtonSize.large   // Button besar (padding besar, font besar)
/// ```
enum ButtonSize {
  /// Button kecil dengan padding dan font size kecil
  small,
  
  /// Button sedang dengan padding dan font size sedang (default)
  medium,
  
  /// Button besar dengan padding dan font size besar
  large,
}

