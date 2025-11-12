import 'package:flutter/material.dart';

/// Loại toast message
enum ToastType {
  /// Toast thành công (màu xanh lá)
  success,

  /// Toast lỗi (màu đỏ)
  error,

  /// Toast cảnh báo (màu vàng/cam)
  warning,

  /// Toast thông tin (màu xanh dương)
  info,

  /// Toast tùy chỉnh
  custom,
}

/// Extension để lấy màu sắc và icon cho từng loại toast
extension ToastTypeExtension on ToastType {
  /// Màu sắc mặc định cho từng loại toast
  Color get defaultColor {
    switch (this) {
      case ToastType.success:
        return Colors.green;
      case ToastType.error:
        return Colors.red;
      case ToastType.warning:
        return Colors.orange;
      case ToastType.info:
        return Colors.blue;
      case ToastType.custom:
        return Colors.grey;
    }
  }

  /// Icon mặc định cho từng loại toast
  IconData? get defaultIcon {
    switch (this) {
      case ToastType.success:
        return Icons.check_circle;
      case ToastType.error:
        return Icons.error;
      case ToastType.warning:
        return Icons.warning;
      case ToastType.info:
        return Icons.info;
      case ToastType.custom:
        return null;
    }
  }
}
