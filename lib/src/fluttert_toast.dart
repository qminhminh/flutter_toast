import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttert_toast/src/toast_position.dart';
import 'package:fluttert_toast/src/toast_type.dart';
import 'package:fluttert_toast/src/toast_style.dart';
import 'package:fluttert_toast/src/toast_style_type.dart';
import 'package:fluttert_toast/src/icon_position.dart';

/// Class chính để hiển thị toast messages
class FlutterToast {
  static final FlutterToast _instance = FlutterToast._internal();
  factory FlutterToast() => _instance;
  FlutterToast._internal();

  OverlayEntry? _overlayEntry;
  Timer? _timer;
  bool _isVisible = false;

  /// Hiển thị toast message
  ///
  /// [message] - Nội dung message cần hiển thị
  /// [type] - Loại toast (success, error, warning, info, custom)
  /// [duration] - Thời gian hiển thị (mặc định 2 giây)
  /// [position] - Vị trí hiển thị (top, center, bottom)
  /// [style] - Style tùy chỉnh cho toast
  /// [icon] - Icon tùy chỉnh (nếu null sẽ dùng icon mặc định theo type)
  /// [backgroundColor] - Màu nền tùy chỉnh (nếu null sẽ dùng màu mặc định theo type)
  /// [textColor] - Màu chữ tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [iconColor] - Màu icon tùy chỉnh (nếu null sẽ dùng màu chữ)
  /// [iconPosition] - Vị trí icon trong toast (left, right, top, bottom, center)
  /// [iconSize] - Kích thước icon (nếu null sẽ dùng từ style)
  /// [iconPadding] - Padding xung quanh icon (nếu null sẽ dùng từ style)
  /// [iconMargin] - Margin xung quanh icon (nếu null sẽ dùng từ style)
  /// [fontSize] - Kích thước font chữ (nếu null sẽ dùng từ style)
  /// [textPadding] - Padding xung quanh text (nếu null sẽ dùng từ style)
  /// [textMargin] - Margin xung quanh text (nếu null sẽ dùng từ style)
  /// [showIcon] - Hiển thị icon (nếu null sẽ dùng từ style, mặc định true)
  /// [showText] - Hiển thị text (nếu null sẽ dùng từ style, mặc định true)
  /// [styleType] - Loại style (flat, fillColored, flatColored, minimal) - giống ToastificationStyle
  /// [showCloseButton] - Hiển thị nút đóng (X) ở góc phải (mặc định false, tự động true cho minimal style)
  /// [closeButtonIcon] - Icon cho nút đóng (mặc định Icons.close)
  /// [closeButtonSize] - Kích thước icon nút đóng (mặc định 20)
  /// [closeButtonColor] - Màu icon nút đóng (nếu null dùng Colors.grey)
  /// [builder] - Builder tùy chỉnh để tạo widget toast theo ý người dùng
  ///   Nếu builder được cung cấp, nó sẽ được sử dụng thay vì widget mặc định
  ///   Builder nhận các tham số: (BuildContext context, String message, IconData? icon, Color backgroundColor, Color textColor, Color iconColor, double iconSize, IconPosition iconPosition)
  void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
    ToastStyleType? styleType,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconPosition iconPosition = IconPosition.left,
    double? iconSize,
    EdgeInsets? iconPadding,
    EdgeInsets? iconMargin,
    double? fontSize,
    EdgeInsets? textPadding,
    EdgeInsets? textMargin,
    bool? showIcon,
    bool? showText,
    bool? showCloseButton,
    IconData? closeButtonIcon,
    double? closeButtonSize,
    Color? closeButtonColor,
    Widget Function(
      BuildContext context,
      String message,
      IconData? icon,
      Color backgroundColor,
      Color textColor,
      Color iconColor,
      double iconSize,
      IconPosition iconPosition,
      double fontSize,
      FontWeight fontWeight,
      double borderRadius,
      EdgeInsets padding,
      EdgeInsets margin,
      Border? border,
      List<BoxShadow>? boxShadow,
      bool showIconValue,
      bool showTextValue,
    )?
    builder,
  }) {
    // Ẩn toast hiện tại nếu có
    hide();

    // Tạo style - nếu có styleType thì dùng nó, nếu không thì dùng style được truyền vào
    final toastStyle =
        styleType != null
            ? ToastStyle.fromStyleType(styleType, type)
            : (style ?? const ToastStyle());
    // Ưu tiên màu người dùng chọn, nếu không có thì dùng màu mặc định
    final bgColor =
        backgroundColor ??
        (type == ToastType.custom
            ? toastStyle.backgroundColor
            : type.defaultColor);
    final txtColor = textColor ?? toastStyle.textColor;
    final iconData = icon ?? type.defaultIcon;
    // Ưu tiên màu icon người dùng chọn, nếu không có thì dùng màu từ style hoặc màu chữ
    final iconClr = iconColor ?? toastStyle.iconColor ?? txtColor;
    // Ưu tiên các giá trị người dùng nhập, nếu không có thì dùng từ style
    final iconSz = iconSize ?? toastStyle.iconSize;
    final iconPad = iconPadding ?? toastStyle.iconPadding;
    final iconMrg = iconMargin ?? toastStyle.iconMargin;
    final fontSz = fontSize ?? toastStyle.fontSize;
    final textPad = textPadding ?? toastStyle.textPadding;
    final textMrg = textMargin ?? toastStyle.textMargin;
    final showIconValue = showIcon ?? toastStyle.showIcon;
    final showTextValue = showText ?? toastStyle.showText;
    // Tự động bật close button cho minimal style
    final showCloseBtn =
        showCloseButton ?? (styleType == ToastStyleType.minimal);
    final closeBtnIcon = closeButtonIcon ?? Icons.close;
    final closeBtnSize = closeButtonSize ?? 20.0;
    final closeBtnColor = closeButtonColor ?? Colors.grey;

    // Tạo overlay entry
    _overlayEntry = OverlayEntry(
      builder: (context) {
        // Nếu có builder tùy chỉnh, sử dụng nó
        if (builder != null) {
          return _CustomToastWrapper(
            position: position,
            margin: toastStyle.margin,
            child: builder(
              context,
              message,
              iconData,
              bgColor,
              txtColor,
              iconClr,
              iconSz,
              iconPosition,
              fontSz,
              toastStyle.fontWeight,
              toastStyle.borderRadius,
              toastStyle.padding,
              toastStyle.margin,
              toastStyle.border,
              toastStyle.boxShadow,
              showIconValue,
              showTextValue,
            ),
          );
        }
        // Nếu không có builder, sử dụng widget mặc định
        return _ToastWidget(
          message: message,
          position: position,
          backgroundColor: bgColor,
          textColor: txtColor,
          icon: iconData,
          iconColor: iconClr,
          iconSize: iconSz,
          iconPosition: iconPosition,
          iconPadding: iconPad,
          iconMargin: iconMrg,
          borderRadius: toastStyle.borderRadius,
          padding: toastStyle.padding,
          margin: toastStyle.margin,
          fontSize: fontSz,
          textPadding: textPad,
          textMargin: textMrg,
          fontWeight: toastStyle.fontWeight,
          border: toastStyle.border,
          boxShadow: toastStyle.boxShadow,
          showIcon: showIconValue,
          showText: showTextValue,
          styleType: toastStyle.styleType,
          showCloseButton: showCloseBtn,
          closeButtonIcon: closeBtnIcon,
          closeButtonSize: closeBtnSize,
          closeButtonColor: closeBtnColor,
          hideCallback: hide,
        );
      },
    );

    // Chèn overlay vào
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;

    // Tự động ẩn sau duration
    _timer = Timer(duration, () {
      hide();
    });
  }

  /// Hiển thị toast thành công
  ///
  /// [backgroundColor] - Màu nền tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [textColor] - Màu chữ tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [iconColor] - Màu icon tùy chỉnh (nếu null sẽ dùng màu chữ)
  /// [iconPosition] - Vị trí icon trong toast (left, right, top, bottom, center)
  /// [iconSize] - Kích thước icon
  /// [iconPadding] - Padding xung quanh icon
  /// [iconMargin] - Margin xung quanh icon
  /// [fontSize] - Kích thước font chữ
  /// [textPadding] - Padding xung quanh text
  /// [textMargin] - Margin xung quanh text
  /// [showIcon] - Hiển thị icon (nếu null sẽ dùng từ style, mặc định true)
  /// [showText] - Hiển thị text (nếu null sẽ dùng từ style, mặc định true)
  /// [styleType] - Loại style (flat, fillColored, flatColored, minimal) - giống ToastificationStyle
  /// [builder] - Builder tùy chỉnh để tạo widget toast theo ý người dùng
  void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
    ToastStyleType? styleType,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconPosition iconPosition = IconPosition.left,
    double? iconSize,
    EdgeInsets? iconPadding,
    EdgeInsets? iconMargin,
    double? fontSize,
    EdgeInsets? textPadding,
    EdgeInsets? textMargin,
    bool? showIcon,
    bool? showText,
    Widget Function(
      BuildContext context,
      String message,
      IconData? icon,
      Color backgroundColor,
      Color textColor,
      Color iconColor,
      double iconSize,
      IconPosition iconPosition,
      double fontSize,
      FontWeight fontWeight,
      double borderRadius,
      EdgeInsets padding,
      EdgeInsets margin,
      Border? border,
      List<BoxShadow>? boxShadow,
      bool showIconValue,
      bool showTextValue,
    )?
    builder,
  }) {
    show(
      context,
      message,
      type: ToastType.success,
      duration: duration,
      position: position,
      style: style,
      styleType: styleType,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      iconPosition: iconPosition,
      iconSize: iconSize,
      iconPadding: iconPadding,
      iconMargin: iconMargin,
      fontSize: fontSize,
      textPadding: textPadding,
      textMargin: textMargin,
      showIcon: showIcon,
      showText: showText,
      builder: builder,
    );
  }

  /// Hiển thị toast lỗi
  ///
  /// [backgroundColor] - Màu nền tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [textColor] - Màu chữ tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [iconColor] - Màu icon tùy chỉnh (nếu null sẽ dùng màu chữ)
  /// [iconPosition] - Vị trí icon trong toast (left, right, top, bottom, center)
  /// [iconSize] - Kích thước icon
  /// [iconPadding] - Padding xung quanh icon
  /// [iconMargin] - Margin xung quanh icon
  /// [fontSize] - Kích thước font chữ
  /// [textPadding] - Padding xung quanh text
  /// [textMargin] - Margin xung quanh text
  /// [showIcon] - Hiển thị icon (nếu null sẽ dùng từ style, mặc định true)
  /// [showText] - Hiển thị text (nếu null sẽ dùng từ style, mặc định true)
  /// [styleType] - Loại style (flat, fillColored, flatColored, minimal) - giống ToastificationStyle
  /// [builder] - Builder tùy chỉnh để tạo widget toast theo ý người dùng
  void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
    ToastStyleType? styleType,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconPosition iconPosition = IconPosition.left,
    double? iconSize,
    EdgeInsets? iconPadding,
    EdgeInsets? iconMargin,
    double? fontSize,
    EdgeInsets? textPadding,
    EdgeInsets? textMargin,
    bool? showIcon,
    bool? showText,
    Widget Function(
      BuildContext context,
      String message,
      IconData? icon,
      Color backgroundColor,
      Color textColor,
      Color iconColor,
      double iconSize,
      IconPosition iconPosition,
      double fontSize,
      FontWeight fontWeight,
      double borderRadius,
      EdgeInsets padding,
      EdgeInsets margin,
      Border? border,
      List<BoxShadow>? boxShadow,
      bool showIconValue,
      bool showTextValue,
    )?
    builder,
  }) {
    show(
      context,
      message,
      type: ToastType.error,
      duration: duration,
      position: position,
      style: style,
      styleType: styleType,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      iconPosition: iconPosition,
      iconSize: iconSize,
      iconPadding: iconPadding,
      iconMargin: iconMargin,
      fontSize: fontSize,
      textPadding: textPadding,
      textMargin: textMargin,
      showIcon: showIcon,
      showText: showText,
      builder: builder,
    );
  }

  /// Hiển thị toast cảnh báo
  ///
  /// [backgroundColor] - Màu nền tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [textColor] - Màu chữ tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [iconColor] - Màu icon tùy chỉnh (nếu null sẽ dùng màu chữ)
  /// [iconPosition] - Vị trí icon trong toast (left, right, top, bottom, center)
  /// [iconSize] - Kích thước icon
  /// [iconPadding] - Padding xung quanh icon
  /// [iconMargin] - Margin xung quanh icon
  /// [fontSize] - Kích thước font chữ
  /// [textPadding] - Padding xung quanh text
  /// [textMargin] - Margin xung quanh text
  /// [showIcon] - Hiển thị icon (nếu null sẽ dùng từ style, mặc định true)
  /// [showText] - Hiển thị text (nếu null sẽ dùng từ style, mặc định true)
  /// [styleType] - Loại style (flat, fillColored, flatColored, minimal) - giống ToastificationStyle
  /// [builder] - Builder tùy chỉnh để tạo widget toast theo ý người dùng
  void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
    ToastStyleType? styleType,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconPosition iconPosition = IconPosition.left,
    double? iconSize,
    EdgeInsets? iconPadding,
    EdgeInsets? iconMargin,
    double? fontSize,
    EdgeInsets? textPadding,
    EdgeInsets? textMargin,
    bool? showIcon,
    bool? showText,
    Widget Function(
      BuildContext context,
      String message,
      IconData? icon,
      Color backgroundColor,
      Color textColor,
      Color iconColor,
      double iconSize,
      IconPosition iconPosition,
      double fontSize,
      FontWeight fontWeight,
      double borderRadius,
      EdgeInsets padding,
      EdgeInsets margin,
      Border? border,
      List<BoxShadow>? boxShadow,
      bool showIconValue,
      bool showTextValue,
    )?
    builder,
  }) {
    show(
      context,
      message,
      type: ToastType.warning,
      duration: duration,
      position: position,
      style: style,
      styleType: styleType,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      iconPosition: iconPosition,
      iconSize: iconSize,
      iconPadding: iconPadding,
      iconMargin: iconMargin,
      fontSize: fontSize,
      textPadding: textPadding,
      textMargin: textMargin,
      showIcon: showIcon,
      showText: showText,
      builder: builder,
    );
  }

  /// Hiển thị toast thông tin
  ///
  /// [backgroundColor] - Màu nền tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [textColor] - Màu chữ tùy chỉnh (nếu null sẽ dùng màu mặc định)
  /// [iconColor] - Màu icon tùy chỉnh (nếu null sẽ dùng màu chữ)
  /// [iconPosition] - Vị trí icon trong toast (left, right, top, bottom, center)
  /// [iconSize] - Kích thước icon
  /// [iconPadding] - Padding xung quanh icon
  /// [iconMargin] - Margin xung quanh icon
  /// [fontSize] - Kích thước font chữ
  /// [textPadding] - Padding xung quanh text
  /// [textMargin] - Margin xung quanh text
  /// [showIcon] - Hiển thị icon (nếu null sẽ dùng từ style, mặc định true)
  /// [showText] - Hiển thị text (nếu null sẽ dùng từ style, mặc định true)
  /// [styleType] - Loại style (flat, fillColored, flatColored, minimal) - giống ToastificationStyle
  /// [builder] - Builder tùy chỉnh để tạo widget toast theo ý người dùng
  void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
    ToastStyleType? styleType,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconPosition iconPosition = IconPosition.left,
    double? iconSize,
    EdgeInsets? iconPadding,
    EdgeInsets? iconMargin,
    double? fontSize,
    EdgeInsets? textPadding,
    EdgeInsets? textMargin,
    bool? showIcon,
    bool? showText,
    Widget Function(
      BuildContext context,
      String message,
      IconData? icon,
      Color backgroundColor,
      Color textColor,
      Color iconColor,
      double iconSize,
      IconPosition iconPosition,
      double fontSize,
      FontWeight fontWeight,
      double borderRadius,
      EdgeInsets padding,
      EdgeInsets margin,
      Border? border,
      List<BoxShadow>? boxShadow,
      bool showIconValue,
      bool showTextValue,
    )?
    builder,
  }) {
    show(
      context,
      message,
      type: ToastType.info,
      duration: duration,
      position: position,
      style: style,
      styleType: styleType,
      backgroundColor: backgroundColor,
      textColor: textColor,
      iconColor: iconColor,
      iconPosition: iconPosition,
      iconSize: iconSize,
      iconPadding: iconPadding,
      iconMargin: iconMargin,
      fontSize: fontSize,
      textPadding: textPadding,
      textMargin: textMargin,
      showIcon: showIcon,
      showText: showText,
      builder: builder,
    );
  }

  /// Hiển thị alert toast (thiết kế giống React Native Alert)
  ///
  /// [message] - Nội dung message
  /// [title] - Tiêu đề alert (tùy chọn)
  /// [onTap] - Callback khi tap vào toast
  /// [onDismiss] - Callback khi toast bị đóng
  /// [actionButton] - Widget nút action (ví dụ: TextButton)
  /// [dismissible] - Có thể đóng bằng cách tap vào hoặc nút đóng (mặc định true)
  /// [showCloseButton] - Hiển thị nút đóng (X) ở góc phải (mặc định true)
  /// [closeButtonIcon] - Icon cho nút đóng (mặc định Icons.close)
  /// [closeButtonSize] - Kích thước icon nút đóng (mặc định 20)
  /// [closeButtonColor] - Màu icon nút đóng (nếu null dùng textColor)
  /// [duration] - Thời gian hiển thị (null = không tự động đóng, mặc định 4 giây)
  /// [position] - Vị trí hiển thị (mặc định top)
  /// [style] - Style tùy chỉnh
  /// [backgroundColor] - Màu nền
  /// [textColor] - Màu chữ
  /// [iconColor] - Màu icon
  /// [iconPosition] - Vị trí icon
  /// [iconSize] - Kích thước icon
  /// [iconPadding] - Padding icon
  /// [iconMargin] - Margin icon
  /// [fontSize] - Kích thước font
  /// [textPadding] - Padding text
  /// [textMargin] - Margin text
  /// [titleFontSize] - Kích thước font cho title (nếu null = fontSize + 2)
  /// [titleFontWeight] - Font weight cho title (mặc định FontWeight.bold)
  /// [borderRadius] - Border radius (nếu null dùng từ style)
  /// [borderRadiusTopLeft] - Border radius góc trên trái (override borderRadius)
  /// [borderRadiusTopRight] - Border radius góc trên phải (override borderRadius)
  /// [borderRadiusBottomLeft] - Border radius góc dưới trái (override borderRadius)
  /// [borderRadiusBottomRight] - Border radius góc dưới phải (override borderRadius)
  /// [maxWidth] - Chiều rộng tối đa (nếu null = full width)
  /// [width] - Chiều rộng cố định (nếu null = auto)
  /// [height] - Chiều cao cố định (nếu null = auto)
  /// [iconSpacing] - Khoảng cách giữa icon và text (mặc định 12)
  /// [titleSpacing] - Khoảng cách giữa title và message (mặc định 4)
  /// [actionButtonSpacing] - Khoảng cách giữa text và action button (mặc định 8)
  /// [animationDuration] - Thời gian animation (mặc định 300ms)
  /// [isVerticalLayout] - Layout dọc thay vì ngang (mặc định false)
  void showAlert(
    BuildContext context,
    String message, {
    String? title,
    VoidCallback? onTap,
    VoidCallback? onDismiss,
    Widget? actionButton,
    bool dismissible = true,
    bool showCloseButton = true,
    IconData? closeButtonIcon,
    double? closeButtonSize,
    Color? closeButtonColor,
    Duration? duration,
    ToastPosition position = ToastPosition.top,
    ToastStyle? style,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconPosition iconPosition = IconPosition.left,
    double? iconSize,
    EdgeInsets? iconPadding,
    EdgeInsets? iconMargin,
    double? fontSize,
    EdgeInsets? textPadding,
    EdgeInsets? textMargin,
    double? titleFontSize,
    FontWeight? titleFontWeight,
    double? borderRadius,
    double? borderRadiusTopLeft,
    double? borderRadiusTopRight,
    double? borderRadiusBottomLeft,
    double? borderRadiusBottomRight,
    double? maxWidth,
    double? width,
    double? height,
    double? iconSpacing,
    double? titleSpacing,
    double? actionButtonSpacing,
    Duration? animationDuration,
    bool isVerticalLayout = false,
  }) {
    // Ẩn toast hiện tại nếu có
    hide();

    // Tạo style
    final toastStyle = style ?? const ToastStyle();
    final bgColor = backgroundColor ?? ToastType.alert.defaultColor;
    final txtColor = textColor ?? toastStyle.textColor;
    final iconData = ToastType.alert.defaultIcon;
    final iconClr = iconColor ?? toastStyle.iconColor ?? txtColor;
    final iconSz = iconSize ?? toastStyle.iconSize;
    final iconPad = iconPadding ?? toastStyle.iconPadding;
    final iconMrg = iconMargin ?? toastStyle.iconMargin;
    final fontSz = fontSize ?? toastStyle.fontSize;
    final textPad = textPadding ?? toastStyle.textPadding;
    final textMrg = textMargin ?? toastStyle.textMargin;
    final titleSz = titleFontSize ?? (fontSz + 2);
    final titleWeight = titleFontWeight ?? FontWeight.bold;
    final borderRad = borderRadius ?? toastStyle.borderRadius;
    final animDuration = animationDuration ?? const Duration(milliseconds: 300);

    // Tạo overlay entry
    _overlayEntry = OverlayEntry(
      builder:
          (context) => _AlertToastWidget(
            message: message,
            title: title,
            position: position,
            backgroundColor: bgColor,
            textColor: txtColor,
            icon: iconData,
            iconColor: iconClr,
            iconSize: iconSz,
            iconPosition: iconPosition,
            iconPadding: iconPad,
            iconMargin: iconMrg,
            borderRadius: borderRad,
            borderRadiusTopLeft: borderRadiusTopLeft,
            borderRadiusTopRight: borderRadiusTopRight,
            borderRadiusBottomLeft: borderRadiusBottomLeft,
            borderRadiusBottomRight: borderRadiusBottomRight,
            padding: toastStyle.padding,
            margin: toastStyle.margin,
            fontSize: fontSz,
            titleFontSize: titleSz,
            titleFontWeight: titleWeight,
            textPadding: textPad,
            textMargin: textMrg,
            fontWeight: toastStyle.fontWeight,
            border: toastStyle.border,
            boxShadow: toastStyle.boxShadow,
            onTap: onTap,
            onDismiss: onDismiss,
            actionButton: actionButton,
            dismissible: dismissible,
            showCloseButton: showCloseButton,
            closeButtonIcon: closeButtonIcon,
            closeButtonSize: closeButtonSize,
            closeButtonColor: closeButtonColor,
            maxWidth: maxWidth,
            width: width,
            height: height,
            iconSpacing: iconSpacing,
            titleSpacing: titleSpacing,
            actionButtonSpacing: actionButtonSpacing,
            animationDuration: animDuration,
            isVerticalLayout: isVerticalLayout,
            hideCallback: hide,
          ),
    );

    // Chèn overlay vào
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;

    // Tự động ẩn sau duration (mặc định 4 giây nếu không chỉ định)
    final alertDuration = duration ?? const Duration(seconds: 4);
    _timer = Timer(alertDuration, () {
      hide();
      onDismiss?.call();
    });
  }

  /// Hiển thị dialog toast với TextField và buttons (giống dialog có thể tương tác)
  ///
  /// [message] - Nội dung message
  /// [title] - Tiêu đề dialog (tùy chọn)
  /// [textField] - Widget TextField tùy chỉnh (nếu null sẽ không hiển thị)
  /// [onConfirm] - Callback khi nhấn nút xác nhận (nhận giá trị từ TextField nếu có)
  /// [onCancel] - Callback khi nhấn nút hủy
  /// [confirmButton] - Widget nút xác nhận tùy chỉnh (ví dụ: ElevatedButton với text "Đồng ý")
  /// [cancelButton] - Widget nút hủy tùy chỉnh (ví dụ: TextButton với text "Không")
  /// [confirmText] - Text cho nút xác nhận (mặc định "Đồng ý")
  /// [cancelText] - Text cho nút hủy (mặc định "Hủy")
  /// [showCancelButton] - Hiển thị nút hủy (mặc định true)
  /// [dismissible] - Có thể đóng bằng cách tap bên ngoài (mặc định true)
  /// [duration] - Thời gian hiển thị (null = không tự động đóng)
  /// [position] - Vị trí hiển thị (mặc định center)
  /// [style] - Style tùy chỉnh
  /// [backgroundColor] - Màu nền
  /// [textColor] - Màu chữ
  /// [iconColor] - Màu icon
  /// [iconPosition] - Vị trí icon
  /// [iconSize] - Kích thước icon
  /// [iconPadding] - Padding icon
  /// [iconMargin] - Margin icon
  /// [fontSize] - Kích thước font
  /// [textPadding] - Padding text
  /// [textMargin] - Margin text
  /// [titleFontSize] - Kích thước font cho title
  /// [titleFontWeight] - Font weight cho title
  /// [borderRadius] - Border radius
  /// [maxWidth] - Chiều rộng tối đa
  /// [width] - Chiều rộng cố định
  /// [animationDuration] - Thời gian animation
  void showDialogToast(
    BuildContext context,
    String message, {
    String? title,
    Widget? textField,
    Function(String?)? onConfirm,
    VoidCallback? onCancel,
    Widget? confirmButton,
    Widget? cancelButton,
    String confirmText = 'Đồng ý',
    String cancelText = 'Hủy',
    bool showCancelButton = true,
    bool dismissible = true,
    Duration? duration,
    ToastPosition position = ToastPosition.center,
    ToastStyle? style,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
    IconPosition iconPosition = IconPosition.top,
    double? iconSize,
    EdgeInsets? iconPadding,
    EdgeInsets? iconMargin,
    double? fontSize,
    EdgeInsets? textPadding,
    EdgeInsets? textMargin,
    double? titleFontSize,
    FontWeight? titleFontWeight,
    double? borderRadius,
    double? maxWidth,
    double? width,
    Duration? animationDuration,
  }) {
    // Ẩn toast hiện tại nếu có
    hide();

    // Tạo style
    final toastStyle = style ?? const ToastStyle();
    final bgColor = backgroundColor ?? Colors.white;
    final txtColor = textColor ?? Colors.black87;
    final iconData = ToastType.alert.defaultIcon;
    final iconClr = iconColor ?? toastStyle.iconColor ?? txtColor;
    final iconSz = iconSize ?? toastStyle.iconSize;
    final iconPad = iconPadding ?? toastStyle.iconPadding;
    final iconMrg = iconMargin ?? toastStyle.iconMargin;
    final fontSz = fontSize ?? toastStyle.fontSize;
    final textPad = textPadding ?? toastStyle.textPadding;
    final textMrg = textMargin ?? toastStyle.textMargin;
    final titleSz = titleFontSize ?? (fontSz + 2);
    final titleWeight = titleFontWeight ?? FontWeight.bold;
    final borderRad = borderRadius ?? toastStyle.borderRadius;
    final animDuration = animationDuration ?? const Duration(milliseconds: 300);

    // Tạo overlay entry
    _overlayEntry = OverlayEntry(
      builder:
          (context) => _DialogToastWidget(
            message: message,
            title: title,
            textField: textField,
            onConfirm: onConfirm,
            onCancel: onCancel,
            confirmButton: confirmButton,
            cancelButton: cancelButton,
            confirmText: confirmText,
            cancelText: cancelText,
            showCancelButton: showCancelButton,
            dismissible: dismissible,
            position: position,
            backgroundColor: bgColor,
            textColor: txtColor,
            icon: iconData,
            iconColor: iconClr,
            iconSize: iconSz,
            iconPosition: iconPosition,
            iconPadding: iconPad,
            iconMargin: iconMrg,
            borderRadius: borderRad,
            padding: toastStyle.padding,
            margin: toastStyle.margin,
            fontSize: fontSz,
            titleFontSize: titleSz,
            titleFontWeight: titleWeight,
            textPadding: textPad,
            textMargin: textMrg,
            fontWeight: toastStyle.fontWeight,
            border: toastStyle.border,
            boxShadow: toastStyle.boxShadow,
            maxWidth: maxWidth,
            width: width,
            animationDuration: animDuration,
            hideCallback: hide,
          ),
    );

    // Chèn overlay vào
    Overlay.of(context).insert(_overlayEntry!);
    _isVisible = true;

    // Tự động ẩn sau duration (nếu có)
    if (duration != null) {
      _timer = Timer(duration, () {
        hide();
        onCancel?.call();
      });
    }
  }

  /// Ẩn toast hiện tại
  void hide() {
    if (_isVisible && _overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      _isVisible = false;
    }
    _timer?.cancel();
    _timer = null;
  }

  /// Kiểm tra xem toast có đang hiển thị không
  bool get isVisible => _isVisible;
}

/// Widget hiển thị toast
class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastPosition position;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final IconPosition iconPosition;
  final EdgeInsets? iconPadding;
  final EdgeInsets? iconMargin;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double fontSize;
  final EdgeInsets? textPadding;
  final EdgeInsets? textMargin;
  final FontWeight fontWeight;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final bool showIcon;
  final bool showText;
  final ToastStyleType? styleType;
  final bool showCloseButton;
  final IconData? closeButtonIcon;
  final double closeButtonSize;
  final Color closeButtonColor;
  final VoidCallback hideCallback;

  const _ToastWidget({
    required this.message,
    required this.position,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.iconPosition,
    this.iconPadding,
    this.iconMargin,
    required this.borderRadius,
    required this.padding,
    required this.margin,
    required this.fontSize,
    this.textPadding,
    this.textMargin,
    required this.fontWeight,
    this.border,
    this.boxShadow,
    required this.showIcon,
    required this.showText,
    this.styleType,
    this.showCloseButton = false,
    this.closeButtonIcon,
    this.closeButtonSize = 20.0,
    this.closeButtonColor = Colors.grey,
    required this.hideCallback,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide animation dựa trên position
    Offset beginOffset;
    switch (widget.position) {
      case ToastPosition.top:
      case ToastPosition.topLeft:
      case ToastPosition.topRight:
        beginOffset = const Offset(0, -1);
        break;
      case ToastPosition.bottom:
      case ToastPosition.bottomLeft:
      case ToastPosition.bottomRight:
        beginOffset = const Offset(0, 1);
        break;
      case ToastPosition.center:
        beginOffset = Offset.zero;
        break;
    }
    final endOffset = Offset.zero;

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Xác định vị trí và alignment
    Alignment? alignment;
    bool isTop = false;
    bool isBottom = false;
    bool isLeft = false;
    bool isRight = false;

    switch (widget.position) {
      case ToastPosition.top:
        isTop = true;
        alignment = Alignment.topCenter;
        break;
      case ToastPosition.bottom:
        isBottom = true;
        alignment = Alignment.bottomCenter;
        break;
      case ToastPosition.topLeft:
        isTop = true;
        isLeft = true;
        alignment = Alignment.topLeft;
        break;
      case ToastPosition.topRight:
        isTop = true;
        isRight = true;
        alignment = Alignment.topRight;
        break;
      case ToastPosition.bottomLeft:
        isBottom = true;
        isLeft = true;
        alignment = Alignment.bottomLeft;
        break;
      case ToastPosition.bottomRight:
        isBottom = true;
        isRight = true;
        alignment = Alignment.bottomRight;
        break;
      case ToastPosition.center:
        alignment = null;
        break;
    }

    return Positioned(
      top: isTop ? widget.margin.top : null,
      bottom: isBottom ? widget.margin.bottom : null,
      left: isLeft ? widget.margin.left : null,
      right: isRight ? widget.margin.right : null,
      child:
          widget.position == ToastPosition.center
              ? Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildToastContent(),
                  ),
                ),
              )
              : Align(
                alignment: alignment!,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildToastContent(),
                  ),
                ),
              ),
    );
  }

  Widget _buildToastContent() {
    // Tính toán font size responsive dựa trên kích thước màn hình
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final screenSize = screenWidth < screenHeight ? screenWidth : screenHeight;

    // Font size responsive: điều chỉnh theo kích thước màn hình
    // Màn hình nhỏ (< 400): giảm 20%
    // Màn hình lớn (> 800): tăng 10%
    double responsiveFontSize = widget.fontSize;
    if (screenSize < 400) {
      responsiveFontSize = widget.fontSize * 0.8;
    } else if (screenSize > 800) {
      responsiveFontSize = widget.fontSize * 1.1;
    }

    // Icon widget với padding và margin (chỉ hiển thị nếu showIcon = true)
    // Nếu có styleType, icon sẽ được bọc trong circle như trong ảnh
    Widget? iconWidget;
    if (widget.showIcon && widget.icon != null) {
      Widget icon = Icon(
        widget.icon,
        color: widget.iconColor,
        size: widget.iconSize,
      );

      // Nếu có styleType, bọc icon trong circle (giống trong ảnh)
      if (widget.styleType != null) {
        // Màu nền của circle phụ thuộc vào styleType
        Color circleBackgroundColor;
        switch (widget.styleType!) {
          case ToastStyleType.flat:
            // Flat: circle với màu nhạt của icon
            circleBackgroundColor = widget.iconColor.withOpacity(0.15);
            break;
          case ToastStyleType.fillColored:
            // Fill colored: circle với màu trắng nhạt (vì icon màu trắng)
            circleBackgroundColor = Colors.white.withOpacity(0.2);
            break;
          case ToastStyleType.flatColored:
            // Flat colored: circle với màu nhạt của icon
            circleBackgroundColor = widget.iconColor.withOpacity(0.15);
            break;
          case ToastStyleType.minimal:
            // Minimal: circle với màu nhạt của icon
            circleBackgroundColor = widget.iconColor.withOpacity(0.15);
            break;
        }

        icon = Container(
          width: widget.iconSize + 12,
          height: widget.iconSize + 12,
          decoration: BoxDecoration(
            color: circleBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              widget.icon,
              color: widget.iconColor,
              size: widget.iconSize,
            ),
          ),
        );
      }

      iconWidget = icon;

      // Áp dụng padding cho icon
      if (widget.iconPadding != null) {
        iconWidget = Padding(padding: widget.iconPadding!, child: iconWidget);
      }

      // Áp dụng margin cho icon
      if (widget.iconMargin != null) {
        iconWidget = Container(margin: widget.iconMargin!, child: iconWidget);
      }
    }

    // Text widget với responsive font size, padding và margin (chỉ hiển thị nếu showText = true)
    Widget? textWidget;
    if (widget.showText) {
      textWidget = Text(
        widget.message,
        style: TextStyle(
          color: widget.textColor,
          fontSize: responsiveFontSize,
          fontWeight: widget.fontWeight,
        ),
        textAlign: widget.styleType != null ? TextAlign.left : TextAlign.center,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
      );

      // Áp dụng padding cho text
      if (widget.textPadding != null) {
        textWidget = Padding(padding: widget.textPadding!, child: textWidget);
      }

      // Áp dụng margin cho text
      if (widget.textMargin != null) {
        textWidget = Container(margin: widget.textMargin!, child: textWidget);
      }
    }

    // Close button widget (cho minimal style)
    Widget? closeButtonWidget;
    if (widget.showCloseButton) {
      closeButtonWidget = GestureDetector(
        onTap: () {
          _controller.reverse().then((_) {
            widget.hideCallback();
          });
        },
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Icon(
            widget.closeButtonIcon ?? Icons.close,
            color: widget.closeButtonColor,
            size: widget.closeButtonSize,
          ),
        ),
      );
    }

    // Xây dựng layout dựa trên vị trí icon
    // Chỉ thêm SizedBox nếu không có margin/padding được chỉ định
    final hasIconSpacing =
        widget.iconMargin == null && widget.iconPadding == null;
    final hasTextSpacing =
        widget.textMargin == null && widget.textPadding == null;

    Widget content;

    // Nếu có styleType (đặc biệt là minimal), layout đặc biệt với close button
    if (widget.styleType != null && widget.showCloseButton) {
      // Layout cho styleType: Icon bên trái, Text ở giữa (Expanded), Close button bên phải
      List<Widget> rowChildren = [];

      if (iconWidget != null) {
        rowChildren.add(iconWidget);
        rowChildren.add(const SizedBox(width: 12));
      }

      if (textWidget != null) {
        rowChildren.add(Expanded(child: textWidget));
      }

      if (closeButtonWidget != null) {
        rowChildren.add(const SizedBox(width: 8));
        rowChildren.add(closeButtonWidget);
      }

      content = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowChildren,
      );
    } else {
      // Layout thông thường
      // Nếu không có cả icon và text, hiển thị một container rỗng
      if (iconWidget == null && textWidget == null) {
        content = const SizedBox.shrink();
      } else if (iconWidget == null) {
        // Chỉ có text
        content = textWidget ?? const SizedBox.shrink();
      } else if (textWidget == null) {
        // Chỉ có icon
        content = iconWidget;
      } else {
        // Có cả icon và text
        switch (widget.iconPosition) {
          case IconPosition.left:
            content = Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                iconWidget,
                if (hasIconSpacing && hasTextSpacing) const SizedBox(width: 12),
                Flexible(child: textWidget),
              ],
            );
            break;
          case IconPosition.right:
            content = Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: textWidget),
                if (hasIconSpacing && hasTextSpacing) const SizedBox(width: 12),
                iconWidget,
              ],
            );
            break;
          case IconPosition.top:
            content = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                iconWidget,
                if (hasIconSpacing && hasTextSpacing) const SizedBox(height: 8),
                Flexible(child: textWidget),
              ],
            );
            break;
          case IconPosition.bottom:
            content = Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: textWidget),
                if (hasIconSpacing && hasTextSpacing) const SizedBox(height: 8),
                iconWidget,
              ],
            );
            break;
          case IconPosition.center:
            content = Stack(
              alignment: Alignment.center,
              children: [
                textWidget,
                Positioned.fill(
                  child: Center(
                    child: Container(
                      padding: widget.iconPadding ?? const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: widget.backgroundColor.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.icon,
                        color: widget.iconColor,
                        size: widget.iconSize,
                      ),
                    ),
                  ),
                ),
              ],
            );
            break;
        }
      }
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: BoxConstraints(
          maxWidth:
              screenWidth * 0.9, // Responsive: tối đa 90% chiều rộng màn hình
          minWidth: 100,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.border,
          boxShadow:
              widget.boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
        ),
        padding: widget.padding,
        child: content,
      ),
    );
  }
}

/// Widget wrapper cho custom toast builder
/// Xử lý positioning và animation cho custom widget
class _CustomToastWrapper extends StatefulWidget {
  final ToastPosition position;
  final EdgeInsets margin;
  final Widget child;

  const _CustomToastWrapper({
    required this.position,
    required this.margin,
    required this.child,
  });

  @override
  State<_CustomToastWrapper> createState() => _CustomToastWrapperState();
}

class _CustomToastWrapperState extends State<_CustomToastWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Slide animation dựa trên position
    Offset beginOffset;
    switch (widget.position) {
      case ToastPosition.top:
      case ToastPosition.topLeft:
      case ToastPosition.topRight:
        beginOffset = const Offset(0, -1);
        break;
      case ToastPosition.bottom:
      case ToastPosition.bottomLeft:
      case ToastPosition.bottomRight:
        beginOffset = const Offset(0, 1);
        break;
      case ToastPosition.center:
        beginOffset = Offset.zero;
        break;
    }
    final endOffset = Offset.zero;

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Xác định vị trí và alignment
    Alignment? alignment;
    bool isTop = false;
    bool isBottom = false;
    bool isLeft = false;
    bool isRight = false;

    switch (widget.position) {
      case ToastPosition.top:
        isTop = true;
        alignment = Alignment.topCenter;
        break;
      case ToastPosition.bottom:
        isBottom = true;
        alignment = Alignment.bottomCenter;
        break;
      case ToastPosition.topLeft:
        isTop = true;
        isLeft = true;
        alignment = Alignment.topLeft;
        break;
      case ToastPosition.topRight:
        isTop = true;
        isRight = true;
        alignment = Alignment.topRight;
        break;
      case ToastPosition.bottomLeft:
        isBottom = true;
        isLeft = true;
        alignment = Alignment.bottomLeft;
        break;
      case ToastPosition.bottomRight:
        isBottom = true;
        isRight = true;
        alignment = Alignment.bottomRight;
        break;
      case ToastPosition.center:
        alignment = null;
        break;
    }

    return Positioned(
      top: isTop ? widget.margin.top : null,
      bottom: isBottom ? widget.margin.bottom : null,
      left: isLeft ? widget.margin.left : null,
      right: isRight ? widget.margin.right : null,
      child:
          widget.position == ToastPosition.center
              ? Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: widget.child,
                  ),
                ),
              )
              : Align(
                alignment: alignment!,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: widget.child,
                  ),
                ),
              ),
    );
  }
}

/// Widget hiển thị alert toast (có thể tương tác)
class _AlertToastWidget extends StatefulWidget {
  final String message;
  final String? title;
  final ToastPosition position;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final IconPosition iconPosition;
  final EdgeInsets? iconPadding;
  final EdgeInsets? iconMargin;
  final double borderRadius;
  final double? borderRadiusTopLeft;
  final double? borderRadiusTopRight;
  final double? borderRadiusBottomLeft;
  final double? borderRadiusBottomRight;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double fontSize;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final EdgeInsets? textPadding;
  final EdgeInsets? textMargin;
  final FontWeight fontWeight;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;
  final Widget? actionButton;
  final bool dismissible;
  final bool showCloseButton;
  final IconData? closeButtonIcon;
  final double? closeButtonSize;
  final Color? closeButtonColor;
  final double? maxWidth;
  final double? width;
  final double? height;
  final double? iconSpacing;
  final double? titleSpacing;
  final double? actionButtonSpacing;
  final Duration animationDuration;
  final bool isVerticalLayout;
  final VoidCallback hideCallback;

  const _AlertToastWidget({
    required this.message,
    this.title,
    required this.position,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.iconPosition,
    this.iconPadding,
    this.iconMargin,
    required this.borderRadius,
    this.borderRadiusTopLeft,
    this.borderRadiusTopRight,
    this.borderRadiusBottomLeft,
    this.borderRadiusBottomRight,
    required this.padding,
    required this.margin,
    required this.fontSize,
    this.titleFontSize,
    this.titleFontWeight,
    this.textPadding,
    this.textMargin,
    required this.fontWeight,
    this.border,
    this.boxShadow,
    this.onTap,
    this.onDismiss,
    this.actionButton,
    required this.dismissible,
    this.showCloseButton = true,
    this.closeButtonIcon,
    this.closeButtonSize,
    this.closeButtonColor,
    this.maxWidth,
    this.width,
    this.height,
    this.iconSpacing,
    this.titleSpacing,
    this.actionButtonSpacing,
    required this.animationDuration,
    this.isVerticalLayout = false,
    required this.hideCallback,
  });

  @override
  State<_AlertToastWidget> createState() => _AlertToastWidgetState();
}

class _AlertToastWidgetState extends State<_AlertToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Animation slide dựa trên position
    Offset beginOffset;
    switch (widget.position) {
      case ToastPosition.top:
      case ToastPosition.topLeft:
      case ToastPosition.topRight:
        beginOffset = const Offset(0, -1);
        break;
      case ToastPosition.bottom:
      case ToastPosition.bottomLeft:
      case ToastPosition.bottomRight:
        beginOffset = const Offset(0, 1);
        break;
      case ToastPosition.center:
        beginOffset = Offset.zero;
        break;
    }
    final endOffset = Offset.zero;

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (widget.dismissible) {
      _controller.reverse().then((_) {
        widget.hideCallback();
        widget.onDismiss?.call();
      });
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    // Xác định vị trí và alignment
    Alignment? alignment;
    bool isTop = false;
    bool isBottom = false;
    bool isLeft = false;
    bool isRight = false;

    switch (widget.position) {
      case ToastPosition.top:
        isTop = true;
        alignment = Alignment.topCenter;
        break;
      case ToastPosition.bottom:
        isBottom = true;
        alignment = Alignment.bottomCenter;
        break;
      case ToastPosition.topLeft:
        isTop = true;
        isLeft = true;
        alignment = Alignment.topLeft;
        break;
      case ToastPosition.topRight:
        isTop = true;
        isRight = true;
        alignment = Alignment.topRight;
        break;
      case ToastPosition.bottomLeft:
        isBottom = true;
        isLeft = true;
        alignment = Alignment.bottomLeft;
        break;
      case ToastPosition.bottomRight:
        isBottom = true;
        isRight = true;
        alignment = Alignment.bottomRight;
        break;
      case ToastPosition.center:
        alignment = null;
        break;
    }

    return Positioned(
      top: isTop ? widget.margin.top : null,
      bottom: isBottom ? widget.margin.bottom : null,
      left: isLeft ? widget.margin.left : null,
      right: isRight ? widget.margin.right : null,
      child:
          widget.position == ToastPosition.center
              ? Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildAlertContent(screenWidth),
                  ),
                ),
              )
              : Align(
                alignment: alignment!,
                child: GestureDetector(
                  onTap: widget.dismissible ? _handleTap : null,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: _buildAlertContent(screenWidth),
                    ),
                  ),
                ),
              ),
    );
  }

  Widget _buildAlertContent(double screenWidth) {
    // Icon widget
    Widget? iconWidget;
    if (widget.icon != null) {
      iconWidget = Icon(
        widget.icon,
        color: widget.iconColor,
        size: widget.iconSize,
      );

      if (widget.iconPadding != null) {
        iconWidget = Padding(padding: widget.iconPadding!, child: iconWidget);
      }

      if (widget.iconMargin != null) {
        iconWidget = Container(margin: widget.iconMargin!, child: iconWidget);
      }
    }

    // Title widget
    Widget? titleWidget;
    if (widget.title != null) {
      titleWidget = Text(
        widget.title!,
        style: TextStyle(
          color: widget.textColor,
          fontSize: widget.titleFontSize ?? (widget.fontSize + 2),
          fontWeight: widget.titleFontWeight ?? FontWeight.bold,
        ),
      );
    }

    // Message widget
    Widget messageWidget = Flexible(
      child: Text(
        widget.message,
        style: TextStyle(
          color: widget.textColor,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );

    if (widget.textPadding != null) {
      messageWidget = Padding(
        padding: widget.textPadding!,
        child: messageWidget,
      );
    }

    if (widget.textMargin != null) {
      messageWidget = Container(
        margin: widget.textMargin!,
        child: messageWidget,
      );
    }

    // Close button widget
    Widget? closeButton;
    if (widget.showCloseButton && widget.dismissible) {
      closeButton = GestureDetector(
        onTap: _handleTap,
        child: Container(
          padding: const EdgeInsets.all(4),
          child: Icon(
            widget.closeButtonIcon ?? Icons.close,
            color: widget.closeButtonColor ?? widget.textColor,
            size: widget.closeButtonSize ?? 20,
          ),
        ),
      );
    }

    // Tính toán border radius
    final topLeft = widget.borderRadiusTopLeft ?? widget.borderRadius;
    final topRight = widget.borderRadiusTopRight ?? widget.borderRadius;
    final bottomLeft = widget.borderRadiusBottomLeft ?? widget.borderRadius;
    final bottomRight = widget.borderRadiusBottomRight ?? widget.borderRadius;

    // Tính toán spacing
    final iconSpace = widget.iconSpacing ?? 12.0;
    final titleSpace = widget.titleSpacing ?? 4.0;
    final actionSpace = widget.actionButtonSpacing ?? 8.0;

    // Tính toán width constraints
    final maxW = widget.maxWidth ?? screenWidth;
    final containerWidth = widget.width ?? double.infinity;

    // Build content
    Widget content;
    if (widget.isVerticalLayout) {
      // Layout dọc
      List<Widget> columnChildren = [];
      if (iconWidget != null && widget.iconPosition == IconPosition.top) {
        columnChildren.add(iconWidget);
        columnChildren.add(SizedBox(height: iconSpace));
      }
      if (titleWidget != null) {
        columnChildren.add(titleWidget);
        columnChildren.add(SizedBox(height: titleSpace));
      }
      columnChildren.add(messageWidget);
      if (widget.actionButton != null) {
        columnChildren.add(SizedBox(height: actionSpace));
        columnChildren.add(widget.actionButton!);
      } else if (closeButton != null) {
        columnChildren.add(SizedBox(height: actionSpace));
        columnChildren.add(
          Align(alignment: Alignment.centerRight, child: closeButton),
        );
      }

      content = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columnChildren,
      );
    } else {
      // Layout ngang (mặc định)
      List<Widget> rowChildren = [];

      // Icon ở bên trái
      if (iconWidget != null &&
          (widget.iconPosition == IconPosition.left ||
              widget.iconPosition == IconPosition.top)) {
        rowChildren.add(iconWidget);
        rowChildren.add(SizedBox(width: iconSpace));
      }

      // Text content (title + message)
      List<Widget> textChildren = [];
      if (titleWidget != null) {
        textChildren.add(titleWidget);
        textChildren.add(SizedBox(height: titleSpace));
      }
      textChildren.add(messageWidget);

      rowChildren.add(
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: textChildren,
          ),
        ),
      );

      // Action button hoặc close button
      if (widget.actionButton != null) {
        rowChildren.add(SizedBox(width: actionSpace));
        rowChildren.add(widget.actionButton!);
      } else if (closeButton != null) {
        rowChildren.add(SizedBox(width: actionSpace));
        rowChildren.add(closeButton);
      }

      content = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rowChildren,
      );
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        width: containerWidth,
        height: widget.height,
        constraints: BoxConstraints(maxWidth: maxW),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(topLeft),
            topRight: Radius.circular(topRight),
            bottomLeft: Radius.circular(bottomLeft),
            bottomRight: Radius.circular(bottomRight),
          ),
          border: widget.border,
          boxShadow:
              widget.boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
        ),
        padding: widget.padding,
        child: content,
      ),
    );
  }
}

/// Widget hiển thị dialog toast với TextField và buttons
class _DialogToastWidget extends StatefulWidget {
  final String message;
  final String? title;
  final Widget? textField;
  final Function(String?)? onConfirm;
  final VoidCallback? onCancel;
  final Widget? confirmButton;
  final Widget? cancelButton;
  final String confirmText;
  final String cancelText;
  final bool showCancelButton;
  final bool dismissible;
  final ToastPosition position;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final IconPosition iconPosition;
  final EdgeInsets? iconPadding;
  final EdgeInsets? iconMargin;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double fontSize;
  final double? titleFontSize;
  final FontWeight? titleFontWeight;
  final EdgeInsets? textPadding;
  final EdgeInsets? textMargin;
  final FontWeight fontWeight;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final double? maxWidth;
  final double? width;
  final Duration animationDuration;
  final VoidCallback hideCallback;

  const _DialogToastWidget({
    required this.message,
    this.title,
    this.textField,
    this.onConfirm,
    this.onCancel,
    this.confirmButton,
    this.cancelButton,
    this.confirmText = 'Đồng ý',
    this.cancelText = 'Hủy',
    this.showCancelButton = true,
    required this.dismissible,
    required this.position,
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.iconPosition,
    this.iconPadding,
    this.iconMargin,
    required this.borderRadius,
    required this.padding,
    required this.margin,
    required this.fontSize,
    this.titleFontSize,
    this.titleFontWeight,
    this.textPadding,
    this.textMargin,
    required this.fontWeight,
    this.border,
    this.boxShadow,
    this.maxWidth,
    this.width,
    required this.animationDuration,
    required this.hideCallback,
  });

  @override
  State<_DialogToastWidget> createState() => _DialogToastWidgetState();
}

class _DialogToastWidgetState extends State<_DialogToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Offset beginOffset;
    switch (widget.position) {
      case ToastPosition.top:
      case ToastPosition.topLeft:
      case ToastPosition.topRight:
        beginOffset = const Offset(0, -0.5);
        break;
      case ToastPosition.bottom:
      case ToastPosition.bottomLeft:
      case ToastPosition.bottomRight:
        beginOffset = const Offset(0, 0.5);
        break;
      case ToastPosition.center:
        beginOffset = Offset.zero;
        break;
    }
    final endOffset = Offset.zero;

    _slideAnimation = Tween<Offset>(
      begin: beginOffset,
      end: endOffset,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _handleConfirm() {
    // Nếu có TextField tùy chỉnh, người dùng sẽ tự quản lý giá trị
    // Nếu không có TextField, truyền null
    final textValue = null; // Người dùng tự quản lý giá trị từ TextField của họ
    _controller.reverse().then((_) {
      widget.hideCallback();
      widget.onConfirm?.call(textValue);
    });
  }

  void _handleCancel() {
    _controller.reverse().then((_) {
      widget.hideCallback();
      widget.onCancel?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return Positioned.fill(
      child: GestureDetector(
        onTap: widget.dismissible ? _handleCancel : null,
        child: Container(
          color: Colors.black.withOpacity(0.3),
          child: Center(
            child: GestureDetector(
              onTap: () {}, // Ngăn tap event bubble lên
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildDialogContent(screenWidth),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogContent(double screenWidth) {
    // Icon widget
    Widget? iconWidget;
    if (widget.icon != null) {
      iconWidget = Icon(
        widget.icon,
        color: widget.iconColor,
        size: widget.iconSize,
      );

      if (widget.iconPadding != null) {
        iconWidget = Padding(padding: widget.iconPadding!, child: iconWidget);
      }

      if (widget.iconMargin != null) {
        iconWidget = Container(margin: widget.iconMargin!, child: iconWidget);
      }
    }

    // Title widget
    Widget? titleWidget;
    if (widget.title != null) {
      titleWidget = Text(
        widget.title!,
        style: TextStyle(
          color: widget.textColor,
          fontSize: widget.titleFontSize ?? (widget.fontSize + 2),
          fontWeight: widget.titleFontWeight ?? FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
    }

    // Message widget
    Widget messageWidget = Text(
      widget.message,
      style: TextStyle(
        color: widget.textColor,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
      ),
      textAlign: TextAlign.center,
    );

    if (widget.textPadding != null) {
      messageWidget = Padding(
        padding: widget.textPadding!,
        child: messageWidget,
      );
    }

    if (widget.textMargin != null) {
      messageWidget = Container(
        margin: widget.textMargin!,
        child: messageWidget,
      );
    }

    // TextField widget
    Widget? textFieldWidget;
    if (widget.textField != null) {
      textFieldWidget = widget.textField;
    }

    // Buttons
    Widget? buttonsWidget;
    if (widget.confirmButton != null ||
        widget.cancelButton != null ||
        widget.showCancelButton ||
        widget.onConfirm != null) {
      List<Widget> buttonRow = [];

      if (widget.showCancelButton) {
        if (widget.cancelButton != null) {
          buttonRow.add(Expanded(child: widget.cancelButton!));
        } else {
          buttonRow.add(
            Expanded(
              child: TextButton(
                onPressed: _handleCancel,
                child: Text(widget.cancelText),
              ),
            ),
          );
        }
        if (widget.confirmButton != null || widget.onConfirm != null) {
          buttonRow.add(const SizedBox(width: 12));
        }
      }

      if (widget.confirmButton != null) {
        buttonRow.add(Expanded(child: widget.confirmButton!));
      } else if (widget.onConfirm != null) {
        buttonRow.add(
          Expanded(
            child: ElevatedButton(
              onPressed: _handleConfirm,
              child: Text(widget.confirmText),
            ),
          ),
        );
      }

      buttonsWidget = Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(children: buttonRow),
      );
    }

    // Build content
    List<Widget> children = [];
    if (iconWidget != null && widget.iconPosition == IconPosition.top) {
      children.add(iconWidget);
      children.add(const SizedBox(height: 16));
    }
    if (titleWidget != null) {
      children.add(titleWidget);
      children.add(const SizedBox(height: 12));
    }
    children.add(messageWidget);
    if (textFieldWidget != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: textFieldWidget,
        ),
      );
    }
    if (buttonsWidget != null) {
      children.add(buttonsWidget);
    }

    return Material(
      color: Colors.transparent,
      child: Container(
        width: widget.width,
        constraints: BoxConstraints(
          maxWidth: widget.maxWidth ?? (screenWidth * 0.85),
          minWidth: 250,
        ),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.border,
          boxShadow:
              widget.boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
        ),
        padding: widget.padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}
