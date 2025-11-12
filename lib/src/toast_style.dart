import 'package:flutter/material.dart';
import 'package:fluttert_toast/src/toast_style_type.dart';
import 'package:fluttert_toast/src/toast_type.dart';

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

  const ToastStyle({
    this.styleType,
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
    this.iconColor,
    this.iconSize = 30.0,
    this.iconPadding,
    this.iconMargin,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.margin = const EdgeInsets.all(16.0),
    this.fontSize = 14.0,
    this.textPadding,
    this.textMargin,
    this.fontWeight = FontWeight.normal,
    this.border,
    this.boxShadow,
    this.showIcon = true,
    this.showText = true,
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
          backgroundColor: Colors.grey.shade100,
          textColor: Colors.black87,
          iconColor: typeColor,
          borderRadius: 8.0,
          border: Border.all(color: lightColor, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        );
      case ToastStyleType.fillColored:
        return ToastStyle(
          styleType: styleType,
          backgroundColor: typeColor,
          textColor: Colors.white,
          iconColor: Colors.white,
          borderRadius: 8.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        );
      case ToastStyleType.flatColored:
        return ToastStyle(
          styleType: styleType,
          backgroundColor: lightColor,
          textColor: Colors.black87,
          iconColor: darkColor,
          borderRadius: 8.0,
          border: Border.all(color: darkColor, width: 1),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        );
      case ToastStyleType.minimal:
        return ToastStyle(
          styleType: styleType,
          backgroundColor: Colors.white,
          textColor: Colors.black87,
          iconColor: typeColor,
          borderRadius: 8.0,
          border: Border(
            left: BorderSide(color: typeColor, width: 4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
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
    );
  }
}
