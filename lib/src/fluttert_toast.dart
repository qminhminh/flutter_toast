import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttert_toast/src/toast_position.dart';
import 'package:fluttert_toast/src/toast_type.dart';
import 'package:fluttert_toast/src/toast_style.dart';
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
  void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.info,
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
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
  }) {
    // Ẩn toast hiện tại nếu có
    hide();

    // Tạo style
    final toastStyle = style ?? const ToastStyle();
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

    // Tạo overlay entry
    _overlayEntry = OverlayEntry(
      builder:
          (context) => _ToastWidget(
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
          ),
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
  void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
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
  }) {
    show(
      context,
      message,
      type: ToastType.success,
      duration: duration,
      position: position,
      style: style,
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
  void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
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
  }) {
    show(
      context,
      message,
      type: ToastType.error,
      duration: duration,
      position: position,
      style: style,
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
  void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
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
  }) {
    show(
      context,
      message,
      type: ToastType.warning,
      duration: duration,
      position: position,
      style: style,
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
  void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
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
  }) {
    show(
      context,
      message,
      type: ToastType.info,
      duration: duration,
      position: position,
      style: style,
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
    );
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
    final beginOffset =
        widget.position == ToastPosition.top
            ? const Offset(0, -1)
            : widget.position == ToastPosition.bottom
            ? const Offset(0, 1)
            : const Offset(0, 0);
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
    return Positioned(
      top: widget.position == ToastPosition.top ? widget.margin.top : null,
      bottom:
          widget.position == ToastPosition.bottom ? widget.margin.bottom : null,
      left: widget.margin.left,
      right: widget.margin.right,
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
                alignment:
                    widget.position == ToastPosition.top
                        ? Alignment.topCenter
                        : Alignment.bottomCenter,
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

    // Icon widget với padding và margin
    Widget? iconWidget;
    if (widget.icon != null) {
      iconWidget = Icon(
        widget.icon,
        color: widget.iconColor,
        size: widget.iconSize,
      );

      // Áp dụng padding cho icon
      if (widget.iconPadding != null) {
        iconWidget = Padding(padding: widget.iconPadding!, child: iconWidget);
      }

      // Áp dụng margin cho icon
      if (widget.iconMargin != null) {
        iconWidget = Container(margin: widget.iconMargin!, child: iconWidget);
      }
    }

    // Text widget với responsive font size, padding và margin
    Widget textWidget = Text(
      widget.message,
      style: TextStyle(
        color: widget.textColor,
        fontSize: responsiveFontSize,
        fontWeight: widget.fontWeight,
      ),
      textAlign: TextAlign.center,
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

    // Xây dựng layout dựa trên vị trí icon
    // Chỉ thêm SizedBox nếu không có margin/padding được chỉ định
    final hasIconSpacing =
        widget.iconMargin == null && widget.iconPadding == null;
    final hasTextSpacing =
        widget.textMargin == null && widget.textPadding == null;

    Widget content;
    switch (widget.iconPosition) {
      case IconPosition.left:
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconWidget != null) ...[
              iconWidget,
              if (hasIconSpacing && hasTextSpacing) const SizedBox(width: 12),
            ],
            Flexible(child: textWidget),
          ],
        );
        break;
      case IconPosition.right:
        content = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(child: textWidget),
            if (iconWidget != null) ...[
              if (hasIconSpacing && hasTextSpacing) const SizedBox(width: 12),
              iconWidget,
            ],
          ],
        );
        break;
      case IconPosition.top:
        content = Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconWidget != null) ...[
              iconWidget,
              if (hasIconSpacing && hasTextSpacing) const SizedBox(height: 8),
            ],
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
            if (iconWidget != null) ...[
              if (hasIconSpacing && hasTextSpacing) const SizedBox(height: 8),
              iconWidget,
            ],
          ],
        );
        break;
      case IconPosition.center:
        content = Stack(
          alignment: Alignment.center,
          children: [
            textWidget,
            if (iconWidget != null)
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
