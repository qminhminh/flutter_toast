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

  /// Copy với các thay đổi
  ToastStyle copyWith({
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
