import 'package:flutter/material.dart';
import 'package:fluttert_toast/fluttert_toast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Toast Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ToastDemoPage(),
    );
  }
}

class ToastDemoPage extends StatelessWidget {
  const ToastDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final toast = FlutterToast();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flutter Toast Demo'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Chọn loại toast để demo:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              // Success Toast
              ElevatedButton.icon(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Thành công! Đây là toast thành công.',
                  );
                },
                icon: const Icon(Icons.check_circle, size: 30),
                label: const Text('Success Toast'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Error Toast
              ElevatedButton.icon(
                onPressed: () {
                  toast.showError(
                    context,
                    'Lỗi! Đã xảy ra lỗi trong quá trình xử lý.',
                  );
                },
                icon: const Icon(Icons.error, size: 30),
                label: const Text('Error Toast'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Warning Toast
              ElevatedButton.icon(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Cảnh báo! Vui lòng kiểm tra lại thông tin.',
                  );
                },
                icon: const Icon(Icons.warning, size: 30),
                label: const Text('Warning Toast'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Info Toast
              ElevatedButton.icon(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Thông tin: Đây là một thông báo thông tin.',
                  );
                },
                icon: const Icon(Icons.info, size: 30),
                label: const Text('Info Toast'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Custom Toast
              ElevatedButton.icon(
                onPressed: () {
                  toast.show(
                    context,
                    'Toast tùy chỉnh với màu sắc và icon riêng!',
                    type: ToastType.custom,
                    icon: Icons.star,
                    backgroundColor: Colors.purple,
                    duration: const Duration(seconds: 3),
                  );
                },
                icon: const Icon(Icons.star, size: 30),
                label: const Text('Custom Toast'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Vị trí hiển thị:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Top Position
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Toast ở trên cùng',
                    position: ToastPosition.top,
                  );
                },
                child: const Text('Top Position'),
              ),
              const SizedBox(height: 12),

              // Center Position
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Toast ở giữa màn hình',
                    position: ToastPosition.center,
                  );
                },
                child: const Text('Center Position'),
              ),
              const SizedBox(height: 12),

              // Bottom Position
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Toast ở dưới cùng',
                    position: ToastPosition.bottom,
                  );
                },
                child: const Text('Bottom Position'),
              ),
              const SizedBox(height: 12),

              // Top Left Position
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Toast ở góc trên trái',
                    position: ToastPosition.topLeft,
                  );
                },
                child: const Text('Top Left'),
              ),
              const SizedBox(height: 12),

              // Top Right Position
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Toast ở góc trên phải',
                    position: ToastPosition.topRight,
                  );
                },
                child: const Text('Top Right'),
              ),
              const SizedBox(height: 12),

              // Bottom Left Position
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Toast ở góc dưới trái',
                    position: ToastPosition.bottomLeft,
                  );
                },
                child: const Text('Bottom Left'),
              ),
              const SizedBox(height: 12),

              // Bottom Right Position
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Toast ở góc dưới phải',
                    position: ToastPosition.bottomRight,
                  );
                },
                child: const Text('Bottom Right'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              // Long Duration
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Toast này sẽ hiển thị trong 5 giây',
                    duration: const Duration(seconds: 5),
                  );
                },
                child: const Text('Long Duration (5s)'),
              ),
              const SizedBox(height: 12),

              // Custom Style
              ElevatedButton(
                onPressed: () {
                  toast.show(
                    context,
                    'Toast với style tùy chỉnh',
                    type: ToastType.custom,
                    style: const ToastStyle(
                      backgroundColor: Colors.indigo,
                      textColor: Colors.white,
                      borderRadius: 20,
                      padding: EdgeInsets.all(20),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    icon: Icons.celebration,
                  );
                },
                child: const Text('Custom Style'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Tùy chọn màu sắc:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Success với màu tùy chỉnh
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Success với màu nền tùy chỉnh',
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    iconColor: Colors.yellow,
                  );
                },
                child: const Text('Success - Màu Tùy Chỉnh'),
              ),
              const SizedBox(height: 12),

              // Error với màu tùy chỉnh
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Error với màu nền hồng',
                    backgroundColor: Colors.pink,
                    textColor: Colors.white,
                  );
                },
                child: const Text('Error - Màu Tùy Chỉnh'),
              ),
              const SizedBox(height: 12),

              // Warning với màu tùy chỉnh
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Warning với màu vàng nhạt',
                    backgroundColor: Colors.amber.shade300,
                    textColor: Colors.brown,
                    iconColor: Colors.orange,
                  );
                },
                child: const Text('Warning - Màu Tùy Chỉnh'),
              ),
              const SizedBox(height: 12),

              // Info với màu tùy chỉnh
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Info với màu xanh lá',
                    backgroundColor: Colors.lightGreen,
                    textColor: Colors.green.shade900,
                    iconColor: Colors.green.shade900,
                  );
                },
                child: const Text('Info - Màu Tùy Chỉnh'),
              ),
              const SizedBox(height: 12),

              // Show với màu hoàn toàn tùy chỉnh
              ElevatedButton(
                onPressed: () {
                  toast.show(
                    context,
                    'Toast với màu gradient tùy chỉnh',
                    backgroundColor: Colors.deepPurple.shade400,
                    textColor: Colors.white,
                    iconColor: Colors.amber,
                    icon: Icons.palette,
                  );
                },
                child: const Text('Màu Hoàn Toàn Tùy Chỉnh'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Vị trí Icon:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Icon Left
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Icon ở bên trái (mặc định)',
                    iconPosition: IconPosition.left,
                  );
                },
                child: const Text('Icon Trái'),
              ),
              const SizedBox(height: 12),

              // Icon Right
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Icon ở bên phải',
                    iconPosition: IconPosition.right,
                  );
                },
                child: const Text('Icon Phải'),
              ),
              const SizedBox(height: 12),

              // Icon Top
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Icon ở trên cùng',
                    iconPosition: IconPosition.top,
                  );
                },
                child: const Text('Icon Trên'),
              ),
              const SizedBox(height: 12),

              // Icon Bottom
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Icon ở dưới cùng',
                    iconPosition: IconPosition.bottom,
                  );
                },
                child: const Text('Icon Dưới'),
              ),
              const SizedBox(height: 12),

              // Icon Center
              ElevatedButton(
                onPressed: () {
                  toast.show(
                    context,
                    'Icon ở giữa (overlay)',
                    type: ToastType.custom,
                    backgroundColor: Colors.indigo,
                    textColor: Colors.white,
                    icon: Icons.star,
                    iconPosition: IconPosition.center,
                  );
                },
                child: const Text('Icon Giữa'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Text Responsive:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Long text để test responsive
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Đây là một đoạn text rất dài để kiểm tra tính năng responsive của toast. Text sẽ tự động điều chỉnh kích thước font và chiều rộng theo màn hình thiết bị.',
                    iconPosition: IconPosition.left,
                  );
                },
                child: const Text('Text Dài - Responsive'),
              ),
              const SizedBox(height: 12),

              // Toast chỉ có icon (không có text)
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    '', // Text rỗng
                    showText: false,
                    showIcon: true,
                  );
                },
                child: const Text('Chỉ Hiển Thị Icon'),
              ),
              const SizedBox(height: 12),

              // Toast chỉ có text (không có icon)
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Toast này chỉ hiển thị text, không có icon',
                    showIcon: false,
                    showText: true,
                  );
                },
                child: const Text('Chỉ Hiển Thị Text'),
              ),
              const SizedBox(height: 12),

              // Toast không có cả icon và text (chỉ có background)
              ElevatedButton(
                onPressed: () {
                  toast.show(
                    context,
                    '',
                    type: ToastType.custom,
                    backgroundColor: Colors.purple,
                    showIcon: false,
                    showText: false,
                  );
                },
                child: const Text('Không Có Icon Và Text'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Custom Builder (Tự Thiết Kế Style):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Toast với custom builder - Gradient background
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Toast với gradient background tự thiết kế',
                    builder: (
                      context,
                      message,
                      icon,
                      backgroundColor,
                      textColor,
                      iconColor,
                      iconSize,
                      iconPosition,
                      fontSize,
                      fontWeight,
                      borderRadius,
                      padding,
                      margin,
                      border,
                      boxShadow,
                      showIconValue,
                      showTextValue,
                    ) {
                      return Container(
                        constraints: const BoxConstraints(
                          maxWidth: 300,
                          minWidth: 100,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.purple.shade400,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(borderRadius),
                          boxShadow:
                              boxShadow ??
                              [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                        ),
                        padding: padding,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showIconValue && icon != null) ...[
                              Icon(icon, color: iconColor, size: iconSize),
                              const SizedBox(width: 12),
                            ],
                            if (showTextValue)
                              Flexible(
                                child: Text(
                                  message,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: fontWeight,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text('Custom Builder - Gradient'),
              ),
              const SizedBox(height: 12),

              // Toast với custom builder - Card style
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Toast kiểu card với shadow đẹp',
                    builder: (
                      context,
                      message,
                      icon,
                      backgroundColor,
                      textColor,
                      iconColor,
                      iconSize,
                      iconPosition,
                      fontSize,
                      fontWeight,
                      borderRadius,
                      padding,
                      margin,
                      border,
                      boxShadow,
                      showIconValue,
                      showTextValue,
                    ) {
                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(borderRadius),
                        ),
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 350,
                            minWidth: 150,
                          ),
                          padding: padding,
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(borderRadius),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (showIconValue && icon != null) ...[
                                Icon(icon, color: iconColor, size: iconSize),
                                const SizedBox(height: 8),
                              ],
                              if (showTextValue)
                                Text(
                                  message,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: fontWeight,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: const Text('Custom Builder - Card Style'),
              ),
              const SizedBox(height: 12),

              // Toast với custom builder - Rounded với border
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Toast với border và style độc đáo',
                    builder: (
                      context,
                      message,
                      icon,
                      backgroundColor,
                      textColor,
                      iconColor,
                      iconSize,
                      iconPosition,
                      fontSize,
                      fontWeight,
                      borderRadius,
                      padding,
                      margin,
                      border,
                      boxShadow,
                      showIconValue,
                      showTextValue,
                    ) {
                      return Container(
                        constraints: const BoxConstraints(
                          maxWidth: 320,
                          minWidth: 120,
                        ),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.orange, width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.5),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (showIconValue && icon != null) ...[
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  icon,
                                  color: iconColor,
                                  size: iconSize,
                                ),
                              ),
                              const SizedBox(width: 16),
                            ],
                            if (showTextValue)
                              Flexible(
                                child: Text(
                                  message,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text('Custom Builder - Rounded Border'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Alert Toast:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Alert đơn giản
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'Đây là một alert toast đơn giản. Tap vào để đóng.',
                    dismissible: true,
                  );
                },
                child: const Text('Alert Đơn Giản'),
              ),
              const SizedBox(height: 12),

              // Alert với title
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'Bạn có chắc chắn muốn thực hiện hành động này không?',
                    title: 'Xác Nhận',
                    dismissible: true,
                  );
                },
                child: const Text('Alert Có Title'),
              ),
              const SizedBox(height: 12),

              // Alert với nút action
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'Bạn có muốn lưu thay đổi không?',
                    title: 'Lưu Thay Đổi',
                    actionButton: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            toast.hide();
                            toast.showInfo(context, 'Đã hủy');
                          },
                          child: const Text('Hủy'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            toast.hide();
                            toast.showSuccess(context, 'Đã lưu thành công!');
                          },
                          child: const Text('Lưu'),
                        ),
                      ],
                    ),
                    dismissible: false,
                  );
                },
                child: const Text('Alert Có Nút Action'),
              ),
              const SizedBox(height: 12),

              // Alert không tự đóng
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'Alert này sẽ không tự động đóng. Bạn phải tap vào để đóng.',
                    title: 'Alert Quan Trọng',
                    dismissible: true,
                    duration: null, // Không tự động đóng
                  );
                },
                child: const Text('Alert Không Tự Đóng'),
              ),
              const SizedBox(height: 12),

              // Alert với callback
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'Alert với callback. Kiểm tra console khi đóng.',
                    title: 'Alert Callback',
                    onDismiss: () {
                      toast.showInfo(context, 'Alert đã được đóng!');
                    },
                    onTap: () {
                      print('Alert được tap!');
                    },
                  );
                },
                child: const Text('Alert Với Callback'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Dialog Toast (Có TextField và Buttons):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Dialog đơn giản với buttons
              ElevatedButton(
                onPressed: () {
                  toast.showDialogToast(
                    context,
                    'Bạn có muốn tiếp tục không?',
                    title: 'Xác Nhận',
                    onConfirm: (value) {
                      toast.showSuccess(context, 'Bạn đã đồng ý!');
                    },
                    onCancel: () {
                      toast.showInfo(context, 'Bạn đã hủy');
                    },
                  );
                },
                child: const Text('Dialog Đơn Giản'),
              ),
              const SizedBox(height: 12),

              // Dialog với TextField
              ElevatedButton(
                onPressed: () {
                  final controller = TextEditingController();
                  toast.showDialogToast(
                    context,
                    'Vui lòng nhập tên của bạn:',
                    title: 'Nhập Tên',
                    textField: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Nhập tên của bạn',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    onConfirm: (value) {
                      final name = controller.text;
                      if (name.isNotEmpty) {
                        toast.showSuccess(context, 'Xin chào $name!');
                      } else {
                        toast.showError(context, 'Vui lòng nhập tên!');
                      }
                    },
                    onCancel: () {
                      controller.dispose();
                      toast.showInfo(context, 'Đã hủy');
                    },
                  );
                },
                child: const Text('Dialog Với TextField'),
              ),
              const SizedBox(height: 12),

              // Dialog với buttons tùy chỉnh
              ElevatedButton(
                onPressed: () {
                  toast.showDialogToast(
                    context,
                    'Bạn có chắc chắn muốn xóa không?',
                    title: 'Xóa Dữ Liệu',
                    confirmText: 'Xóa',
                    cancelText: 'Không',
                    onConfirm: (value) {
                      toast.showError(context, 'Đã xóa thành công!');
                    },
                    onCancel: () {
                      toast.showInfo(context, 'Đã hủy xóa');
                    },
                    backgroundColor: Colors.red.shade50,
                    textColor: Colors.red.shade900,
                  );
                },
                child: const Text('Dialog Với Buttons Tùy Chỉnh'),
              ),
              const SizedBox(height: 12),

              // Dialog không dismissible
              ElevatedButton(
                onPressed: () {
                  toast.showDialogToast(
                    context,
                    'Dialog này không thể đóng bằng cách tap bên ngoài.',
                    title: 'Dialog Quan Trọng',
                    dismissible: false,
                    onConfirm: (value) {
                      toast.showSuccess(context, 'Đã xác nhận!');
                    },
                    onCancel: () {
                      toast.showInfo(context, 'Đã hủy');
                    },
                  );
                },
                child: const Text('Dialog Không Dismissible'),
              ),
              const SizedBox(height: 12),

              // Dialog với TextField và validation
              ElevatedButton(
                onPressed: () {
                  final emailController = TextEditingController();
                  toast.showDialogToast(
                    context,
                    'Vui lòng nhập email của bạn:',
                    title: 'Đăng Ký Email',
                    textField: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'email@example.com',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    confirmText: 'Đăng Ký',
                    cancelText: 'Hủy',
                    onConfirm: (value) {
                      final email = emailController.text;
                      if (email.contains('@') && email.contains('.')) {
                        toast.showSuccess(
                          context,
                          'Đăng ký email $email thành công!',
                        );
                      } else {
                        toast.showError(context, 'Email không hợp lệ!');
                      }
                      emailController.dispose();
                    },
                    onCancel: () {
                      emailController.dispose();
                      toast.showInfo(context, 'Đã hủy đăng ký');
                    },
                  );
                },
                child: const Text('Dialog Với Validation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
