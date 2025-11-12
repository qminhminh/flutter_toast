import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttert_toast/src/toast_position.dart';
import 'package:fluttert_toast/src/toast_type.dart';
import 'package:fluttert_toast/src/toast_style.dart';

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
  /// [backgroundColor] - Màu nền tùy chỉnh
  /// [textColor] - Màu chữ tùy chỉnh
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
  }) {
    // Ẩn toast hiện tại nếu có
    hide();

    // Tạo style
    final toastStyle = style ?? const ToastStyle();
    final bgColor = backgroundColor ?? 
        (type == ToastType.custom ? toastStyle.backgroundColor : type.defaultColor);
    final txtColor = textColor ?? toastStyle.textColor;
    final iconData = icon ?? type.defaultIcon;
    final iconClr = toastStyle.iconColor ?? txtColor;

    // Tạo overlay entry
    _overlayEntry = OverlayEntry(
      builder: (context) => _ToastWidget(
        message: message,
        position: position,
        backgroundColor: bgColor,
        textColor: txtColor,
        icon: iconData,
        iconColor: iconClr,
        iconSize: toastStyle.iconSize,
        borderRadius: toastStyle.borderRadius,
        padding: toastStyle.padding,
        margin: toastStyle.margin,
        fontSize: toastStyle.fontSize,
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
  void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
  }) {
    show(
      context,
      message,
      type: ToastType.success,
      duration: duration,
      position: position,
      style: style,
    );
  }

  /// Hiển thị toast lỗi
  void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
  }) {
    show(
      context,
      message,
      type: ToastType.error,
      duration: duration,
      position: position,
      style: style,
    );
  }

  /// Hiển thị toast cảnh báo
  void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
  }) {
    show(
      context,
      message,
      type: ToastType.warning,
      duration: duration,
      position: position,
      style: style,
    );
  }

  /// Hiển thị toast thông tin
  void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 2),
    ToastPosition position = ToastPosition.bottom,
    ToastStyle? style,
  }) {
    show(
      context,
      message,
      type: ToastType.info,
      duration: duration,
      position: position,
      style: style,
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
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double fontSize;
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
    required this.borderRadius,
    required this.padding,
    required this.margin,
    required this.fontSize,
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

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Slide animation dựa trên position
    final beginOffset = widget.position == ToastPosition.top
        ? const Offset(0, -1)
        : widget.position == ToastPosition.bottom
            ? const Offset(0, 1)
            : const Offset(0, 0);
    final endOffset = Offset.zero;

    _slideAnimation = Tween<Offset>(begin: beginOffset, end: endOffset).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

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
      bottom: widget.position == ToastPosition.bottom
          ? widget.margin.bottom
          : null,
      left: widget.margin.left,
      right: widget.margin.right,
      child: widget.position == ToastPosition.center
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
              alignment: widget.position == ToastPosition.top
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
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          border: widget.border,
          boxShadow: widget.boxShadow ??
              [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
        ),
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                color: widget.iconColor,
                size: widget.iconSize,
              ),
              const SizedBox(width: 12),
            ],
            Flexible(
              child: Text(
                widget.message,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: widget.fontSize,
                  fontWeight: widget.fontWeight,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

