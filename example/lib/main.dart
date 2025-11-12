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
            ],
          ),
        ),
      ),
    );
  }
}
