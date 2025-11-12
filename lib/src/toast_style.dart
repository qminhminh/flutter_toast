import 'package:flutter/material.dart';

/// Style tùy chỉnh cho toast
class ToastStyle {
  /// Màu nền của toast
  final Color backgroundColor;

  /// Màu chữ của toast
  final Color textColor;

  /// Màu icon của toast
  final Color? iconColor;

  /// Kích thước icon (mặc định 30 theo memory)
  final double iconSize;

  /// Border radius của toast
  final double borderRadius;

  /// Padding bên trong toast
  final EdgeInsets padding;

  /// Margin bên ngoài toast
  final EdgeInsets margin;

  /// Font size của text
  final double fontSize;

  /// Font weight của text
  final FontWeight fontWeight;

  /// Border của toast
  final Border? border;

  /// Shadow của toast
  final List<BoxShadow>? boxShadow;

  const ToastStyle({
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
    this.iconColor,
    this.iconSize = 30.0,
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    this.margin = const EdgeInsets.all(16.0),
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.border,
    this.boxShadow,
  });

  /// Copy với các thay đổi
  ToastStyle copyWith({
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    double? iconSize,
    double? borderRadius,
    EdgeInsets? padding,
    EdgeInsets? margin,
    double? fontSize,
    FontWeight? fontWeight,
    Border? border,
    List<BoxShadow>? boxShadow,
  }) {
    return ToastStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      iconColor: iconColor ?? this.iconColor,
      iconSize: iconSize ?? this.iconSize,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      fontSize: fontSize ?? this.fontSize,
      fontWeight: fontWeight ?? this.fontWeight,
      border: border ?? this.border,
      boxShadow: boxShadow ?? this.boxShadow,
    );
  }
}
