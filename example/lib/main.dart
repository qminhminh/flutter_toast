import 'package:flutter/material.dart';
import 'package:flutter_toast_notification/flutter_toast.dart';

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
                'Choose toast type to demo:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),

              const Text(
                'Toast Style Types (Like ToastificationStyle):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Flat Style
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.flat,
                  );
                },
                child: const Text('Flat Style - Success'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.flat,
                  );
                },
                child: const Text('Flat Style - Info'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.flat,
                  );
                },
                child: const Text('Flat Style - Warning'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.flat,
                  );
                },
                child: const Text('Flat Style - Error'),
              ),
              const SizedBox(height: 16),

              // Fill Colored Style
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.fillColored,
                  );
                },
                child: const Text('Fill Colored - Success'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.fillColored,
                  );
                },
                child: const Text('Fill Colored - Info'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.fillColored,
                  );
                },
                child: const Text('Fill Colored - Warning'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.fillColored,
                  );
                },
                child: const Text('Fill Colored - Error'),
              ),
              const SizedBox(height: 16),

              // Flat Colored Style
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.flatColored,
                  );
                },
                child: const Text('Flat Colored - Success'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.flatColored,
                  );
                },
                child: const Text('Flat Colored - Info'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.flatColored,
                  );
                },
                child: const Text('Flat Colored - Warning'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.flatColored,
                  );
                },
                child: const Text('Flat Colored - Error'),
              ),
              const SizedBox(height: 16),

              // Minimal Style
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.minimal,
                  );
                },
                child: const Text('Minimal - Success'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.minimal,
                  );
                },
                child: const Text('Minimal - Info'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.minimal,
                  );
                },
                child: const Text('Minimal - Warning'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Component updates available.',
                    styleType: ToastStyleType.minimal,
                  );
                },
                child: const Text('Minimal - Error'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              // Success Toast
              ElevatedButton.icon(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Success! This is a success toast.',
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
                    'Error! An error occurred during processing.',
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
                    'Warning! Please check your information.',
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
                    'Info: This is an informational notification.',
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
                    'Custom toast with unique colors and icon!',
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
                'Display Position:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Top Position
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Toast at the top',
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
                    'Toast at center screen',
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
                    'Toast at the bottom',
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
                    'Toast at top left corner',
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
                    'Toast at top right corner',
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
                    'Toast at bottom left corner',
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
                    'Toast at bottom right corner',
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
                    'This toast will display for 5 seconds',
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
                    'Toast with custom style',
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
                'Custom Colors:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Success with custom colors
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Success with custom background color',
                    backgroundColor: Colors.teal,
                    textColor: Colors.white,
                    iconColor: Colors.yellow,
                  );
                },
                child: const Text('Success - Custom Colors'),
              ),
              const SizedBox(height: 12),

              // Error with custom colors
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Error with pink background',
                    backgroundColor: Colors.pink,
                    textColor: Colors.white,
                  );
                },
                child: const Text('Error - Custom Colors'),
              ),
              const SizedBox(height: 12),

              // Warning with custom colors
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Warning with light yellow color',
                    backgroundColor: Colors.amber.shade300,
                    textColor: Colors.brown,
                    iconColor: Colors.orange,
                  );
                },
                child: const Text('Warning - Custom Colors'),
              ),
              const SizedBox(height: 12),

              // Info with custom colors
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Info with light green color',
                    backgroundColor: Colors.lightGreen,
                    textColor: Colors.green.shade900,
                    iconColor: Colors.green.shade900,
                  );
                },
                child: const Text('Info - Custom Colors'),
              ),
              const SizedBox(height: 12),

              // Show with fully custom colors
              ElevatedButton(
                onPressed: () {
                  toast.show(
                    context,
                    'Toast with custom gradient colors',
                    backgroundColor: Colors.deepPurple.shade400,
                    textColor: Colors.white,
                    iconColor: Colors.amber,
                    icon: Icons.palette,
                  );
                },
                child: const Text('Fully Custom Colors'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Icon Position:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Icon Left
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Icon on the left (default)',
                    iconPosition: IconPosition.left,
                  );
                },
                child: const Text('Icon Left'),
              ),
              const SizedBox(height: 12),

              // Icon Right
              ElevatedButton(
                onPressed: () {
                  toast.showError(
                    context,
                    'Icon on the right',
                    iconPosition: IconPosition.right,
                  );
                },
                child: const Text('Icon Right'),
              ),
              const SizedBox(height: 12),

              // Icon Top
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Icon on top',
                    iconPosition: IconPosition.top,
                  );
                },
                child: const Text('Icon Top'),
              ),
              const SizedBox(height: 12),

              // Icon Bottom
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Icon on bottom',
                    iconPosition: IconPosition.bottom,
                  );
                },
                child: const Text('Icon Bottom'),
              ),
              const SizedBox(height: 12),

              // Icon Center
              ElevatedButton(
                onPressed: () {
                  toast.show(
                    context,
                    'Icon at center (overlay)',
                    type: ToastType.custom,
                    backgroundColor: Colors.indigo,
                    textColor: Colors.white,
                    icon: Icons.star,
                    iconPosition: IconPosition.center,
                  );
                },
                child: const Text('Icon Center'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Responsive Text:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Long text to test responsive
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'This is a very long text to test the responsive feature of toast. Text will automatically adjust font size and width according to device screen.',
                    iconPosition: IconPosition.left,
                  );
                },
                child: const Text('Long Text - Responsive'),
              ),
              const SizedBox(height: 12),

              // Toast with icon only (no text)
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    '', // Empty text
                    showText: false,
                    showIcon: true,
                  );
                },
                child: const Text('Show Icon Only'),
              ),
              const SizedBox(height: 12),

              // Toast with text only (no icon)
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'This toast only displays text, no icon',
                    showIcon: false,
                    showText: true,
                  );
                },
                child: const Text('Show Text Only'),
              ),
              const SizedBox(height: 12),

              // Toast without icon and text (background only)
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
                child: const Text('No Icon And Text'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Custom Builder (Design Your Own Style):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Toast with custom builder - Gradient background
              ElevatedButton(
                onPressed: () {
                  toast.showSuccess(
                    context,
                    'Toast with custom gradient background',
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

              // Toast with custom builder - Card style
              ElevatedButton(
                onPressed: () {
                  toast.showInfo(
                    context,
                    'Card-style toast with beautiful shadow',
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

              // Toast with custom builder - Rounded with border
              ElevatedButton(
                onPressed: () {
                  toast.showWarning(
                    context,
                    'Toast with border and unique style',
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

              // Simple alert
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'This is a simple alert toast. Tap to close.',
                    dismissible: true,
                  );
                },
                child: const Text('Simple Alert'),
              ),
              const SizedBox(height: 12),

              // Alert with title
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'Are you sure you want to perform this action?',
                    title: 'Confirm',
                    dismissible: true,
                  );
                },
                child: const Text('Alert With Title'),
              ),
              const SizedBox(height: 12),

              // Alert with action button
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'Do you want to save changes?',
                    title: 'Save Changes',
                    actionButton: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            toast.hide();
                            toast.showInfo(context, 'Cancelled');
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            toast.hide();
                            toast.showSuccess(context, 'Saved successfully!');
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                    dismissible: false,
                  );
                },
                child: const Text('Alert With Action Button'),
              ),
              const SizedBox(height: 12),

              // Alert without auto-close
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'This alert will not close automatically. You must tap to close.',
                    title: 'Important Alert',
                    dismissible: true,
                    duration: null, // No auto-close
                  );
                },
                child: const Text('Alert Without Auto-Close'),
              ),
              const SizedBox(height: 12),

              // Alert with callback
              ElevatedButton(
                onPressed: () {
                  toast.showAlert(
                    context,
                    'Alert with callback. Check console when closed.',
                    title: 'Alert Callback',
                    onDismiss: () {
                      toast.showInfo(context, 'Alert has been closed!');
                    },
                    onTap: () {
                      print('Alert was tapped!');
                    },
                  );
                },
                child: const Text('Alert With Callback'),
              ),
              const SizedBox(height: 32),

              const Divider(),
              const SizedBox(height: 16),

              const Text(
                'Dialog Toast (With TextField and Buttons):',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Simple dialog with buttons
              ElevatedButton(
                onPressed: () {
                  toast.showDialogToast(
                    context,
                    'Do you want to continue?',
                    title: 'Confirm',
                    onConfirm: (value) {
                      toast.showSuccess(context, 'You agreed!');
                    },
                    onCancel: () {
                      toast.showInfo(context, 'Cancelled');
                    },
                  );
                },
                child: const Text('Simple Dialog'),
              ),
              const SizedBox(height: 12),

              // Dialog with TextField
              ElevatedButton(
                onPressed: () {
                  final controller = TextEditingController();
                  toast.showDialogToast(
                    context,
                    'Please enter your name:',
                    title: 'Enter Name',
                    textField: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    onConfirm: (value) {
                      final name = controller.text;
                      if (name.isNotEmpty) {
                        toast.showSuccess(context, 'Hello $name!');
                      } else {
                        toast.showError(context, 'Please enter name!');
                      }
                    },
                    onCancel: () {
                      controller.dispose();
                      toast.showInfo(context, 'Cancelled');
                    },
                  );
                },
                child: const Text('Dialog With TextField'),
              ),
              const SizedBox(height: 12),

              // Dialog with custom buttons
              ElevatedButton(
                onPressed: () {
                  toast.showDialogToast(
                    context,
                    'Are you sure you want to delete?',
                    title: 'Delete Data',
                    confirmText: 'Delete',
                    cancelText: 'No',
                    onConfirm: (value) {
                      toast.showError(context, 'Deleted successfully!');
                    },
                    onCancel: () {
                      toast.showInfo(context, 'Deletion cancelled');
                    },
                    backgroundColor: Colors.red.shade50,
                    textColor: Colors.red.shade900,
                  );
                },
                child: const Text('Dialog With Custom Buttons'),
              ),
              const SizedBox(height: 12),

              // Non-dismissible dialog
              ElevatedButton(
                onPressed: () {
                  toast.showDialogToast(
                    context,
                    'This dialog cannot be closed by tapping outside.',
                    title: 'Important Dialog',
                    dismissible: false,
                    onConfirm: (value) {
                      toast.showSuccess(context, 'Confirmed!');
                    },
                    onCancel: () {
                      toast.showInfo(context, 'Cancelled');
                    },
                  );
                },
                child: const Text('Non-Dismissible Dialog'),
              ),
              const SizedBox(height: 12),

              // Dialog with TextField and validation
              ElevatedButton(
                onPressed: () {
                  final emailController = TextEditingController();
                  toast.showDialogToast(
                    context,
                    'Please enter your email:',
                    title: 'Email Registration',
                    textField: TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'email@example.com',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    confirmText: 'Register',
                    cancelText: 'Cancel',
                    onConfirm: (value) {
                      final email = emailController.text;
                      if (email.contains('@') && email.contains('.')) {
                        toast.showSuccess(
                          context,
                          'Email $email registered successfully!',
                        );
                      } else {
                        toast.showError(context, 'Invalid email!');
                      }
                      emailController.dispose();
                    },
                    onCancel: () {
                      emailController.dispose();
                      toast.showInfo(context, 'Registration cancelled');
                    },
                  );
                },
                child: const Text('Dialog With Validation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
