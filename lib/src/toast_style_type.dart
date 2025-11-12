/// Loại style cho toast (giống ToastificationStyle)
enum ToastStyleType {
  /// Flat style: Nền xám nhạt với border màu theo type, text đen
  flat,

  /// Fill colored style: Nền màu đậm theo type, text và icon trắng
  fillColored,

  /// Flat colored style: Nền màu nhạt theo type với border màu đậm, text đen
  flatColored,

  /// Minimal style: Nền trắng với đường line màu bên trái, text đen
  minimal,

  /// Simple style: Nền xám nhạt, không có icon, không có close button, text centered
  simple,
}

