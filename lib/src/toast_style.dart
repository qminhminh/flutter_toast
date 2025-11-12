import 'package:flutter/material.dart';
import 'package:flutter_toast/src/toast_style_type.dart';
import 'package:flutter_toast/src/toast_type.dart';

/// Style tùy chỉnh cho toast
class ToastStyle {
  /// Loại style (flat, fillColored, flatColored, minimal)
  final ToastStyleType? styleType;

  /// Màu nền của toast
  final Color backgroundColor;

  /// Màu chữ của toast
  final Color textColor;

  /// Màu icon của toast
  final Color? iconColor;

  /// Kích thước icon (mặc định 30 theo memory)
  final double iconSize;

  /// Padding xung quanh icon
  final EdgeInsets? iconPadding;

  /// Margin xung quanh icon
  final EdgeInsets? iconMargin;

  /// Border radius của toast
  final double borderRadius;

  /// Padding bên trong toast
  final EdgeInsets padding;

  /// Margin bên ngoài toast
  final EdgeInsets margin;

  /// Font size của text
  final double fontSize;

  /// Padding xung quanh text
  final EdgeInsets? textPadding;

  /// Margin xung quanh text
  final EdgeInsets? textMargin;

  /// Font weight của text
  final FontWeight fontWeight;

  /// Border của toast
  final Border? border;

  /// Shadow của toast
  final List<BoxShadow>? boxShadow;

  /// Hiển thị icon (mặc định true)
  final bool showIcon;

  /// Hiển thị text (mặc định true)
  final bool showText;

  /// Hiển thị close button (mặc định null, sẽ tự động set theo styleType)
  final bool? showCloseButton;

  const ToastStyle({
    this.styleType,
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
    this.iconColor,
    this.iconSize = 30.0,
    this.iconPadding,
    this.iconMargin,
    this.borderRadius = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    this.fontSize = 14.0,
    this.textPadding,
    this.textMargin,
    this.fontWeight = FontWeight.normal,
    this.border,
    this.boxShadow,
    this.showIcon = true,
    this.showText = true,
    this.showCloseButton,
  });

  /// Tạo style dựa trên styleType và toastType
  static ToastStyle fromStyleType(
    ToastStyleType styleType,
    ToastType toastType,
  ) {
    final typeColor = toastType.defaultColor;
    final lightColor = _getLightColor(typeColor);
    final darkColor = _getDarkColor(typeColor);

    switch (styleType) {
      case ToastStyleType.flat:
        return ToastStyle(
          styleType: styleType,
          backgroundColor: const Color(
            0xFFF5F5F5,
          ), // Nền xám nhạt giống trong ảnh
          textColor: const Color(0xFF1F2937), // Text màu đen đậm (gray-800)
          iconColor: typeColor,
          borderRadius: 12.0,
          border: null, // Không có border cho flat style
          padding: const EdgeInsets.all(16.0),
          showCloseButton: true, // Flat style có close button
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A000000), // Shadow nhẹ hơn
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        );
      case ToastStyleType.fillColored:
        return ToastStyle(
          styleType: styleType,
          backgroundColor: typeColor, // Nền màu đậm theo type
          textColor: Colors.white,
          iconColor: Colors.white,
          borderRadius: 12.0,
          padding: const EdgeInsets.all(16.0),
          showCloseButton: true, // Fill colored style có close button
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A000000),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        );
      case ToastStyleType.flatColored:
        return ToastStyle(
          styleType: styleType,
          backgroundColor: lightColor, // Nền màu nhạt theo type
          textColor: const Color(0xFF1F2937), // Text màu đen đậm
          iconColor: darkColor, // Icon màu đậm
          borderRadius: 12.0,
          border: Border.all(color: darkColor, width: 1.5), // Border màu đậm
          padding: const EdgeInsets.all(16.0),
          showCloseButton: true, // Flat colored style có close button
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A000000),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        );
      case ToastStyleType.minimal:
        return ToastStyle(
          styleType: styleType,
          backgroundColor: Colors.white,
          textColor: const Color(0xFF1F2937), // Text màu đen đậm
          iconColor: typeColor,
          borderRadius: 12.0,
          border: Border(
            left: BorderSide(color: typeColor, width: 4),
          ), // Border left màu type
          padding: const EdgeInsets.all(16.0),
          showCloseButton: true, // Minimal style có close button
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A000000),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        );
      case ToastStyleType.simple:
        return ToastStyle(
          styleType: styleType,
          backgroundColor: const Color(0xFFF5F5F5), // Nền xám nhạt
          textColor: const Color(0xFF1F2937), // Text màu đen đậm
          iconColor: typeColor,
          borderRadius: 12.0,
          padding: const EdgeInsets.all(16.0),
          showIcon: false, // Simple style không có icon
          showCloseButton: false, // Simple style không có close button
          boxShadow: [
            BoxShadow(
              color: const Color(0x0A000000),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 0,
            ),
          ],
        );
    }
  }

  /// Lấy màu nhạt từ màu gốc
  static Color _getLightColor(Color color) {
    if (color == Colors.green) return Colors.green.shade100;
    if (color == Colors.red) return Colors.red.shade100;
    if (color == Colors.orange) return Colors.orange.shade100;
    if (color == Colors.blue) return Colors.blue.shade100;
    return color.withOpacity(0.1);
  }

  /// Lấy màu đậm từ màu gốc
  static Color _getDarkColor(Color color) {
    if (color == Colors.green) return Colors.green.shade700;
    if (color == Colors.red) return Colors.red.shade700;
    if (color == Colors.orange) return Colors.orange.shade700;
    if (color == Colors.blue) return Colors.blue.shade700;
    return color;
  }

  /// Copy với các thay đổi
  ToastStyle copyWith({
    ToastStyleType? styleType,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? iconSize,
    EdgeInsets? iconPadding,
    EdgeInsets? iconMargin,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? fontSize,
    EdgeInsets? textPadding,
    EdgeInsets? textMargin,
    FontWeight? fontWeight,
    Border? border,
    List<BoxShadow>? boxShadow,
    bool? showIcon,
    bool? showText,
    bool? showCloseButton,
  }) {
    return ToastStyle(
      styleType: styleType ?? this.styleType,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      iconPadding: iconPadding ?? this.iconPadding,
      iconMargin: iconMargin ?? this.iconMargin,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      fontSize: fontSize ?? this.fontSize,
      textPadding: textPadding ?? this.textPadding,
      textMargin: textMargin ?? this.textMargin,
      fontWeight: fontWeight ?? this.fontWeight,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
      showIcon: showIcon ?? this.showIcon,
      showText: showText ?? this.showText,
      showCloseButton: showCloseButton ?? this.showCloseButton,
    );
  }
}
