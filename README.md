# fluttert_toast

[![pub package](https://img.shields.io/pub/v/fluttert_toast.svg)](https://pub.dev/packages/fluttert_toast)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A beautiful and powerful Flutter package for displaying toast notifications on all platforms (Android, iOS, Web, Desktop, macOS, Linux). Inspired by [toastification](https://pub.dev/packages/toastification), this package provides a simple yet flexible way to show toast messages with beautiful predefined styles.

## ✨ Features

- 🎨 **Multiple Toast Types**: Success, Error, Warning, Info, and Custom
- 📍 **Flexible Positioning**: Top, Bottom, Center, and corner positions (topLeft, topRight, bottomLeft, bottomRight)
- 🎭 **Predefined Styles**: Flat, Fill Colored, Flat Colored, and Minimal styles (similar to ToastificationStyle)
- 🎯 **Icon Customization**: Custom icon positions (left, right, top, bottom, center), sizes, colors, padding, and margins
- 📱 **Responsive Design**: Automatic font size adjustment based on screen size
- 🎨 **Full Customization**: Custom colors, fonts, borders, shadows, padding, and margins
- 🔔 **Alert Toast**: Interactive alert-style toasts with titles, action buttons, and callbacks
- 💬 **Dialog Toast**: Dialog-style toasts with TextField input and confirm/cancel buttons
- 🎨 **Custom Builder**: Build your own toast widget with full control
- 👁️ **Visibility Control**: Toggle icon and text visibility independently
- ❌ **Close Button**: Optional close button for minimal style toasts
- 🎬 **Smooth Animations**: Beautiful fade and slide animations
- ⏱️ **Auto-close**: Configurable duration for automatic dismissal

## 📦 Installation

Add `fluttert_toast` to your `pubspec.yaml` file:

```yaml
dependencies:
  fluttert_toast: ^1.0.0
```

Then, run `flutter pub get` to install the package.

## 🚀 Quick Start

### Import

```dart
import 'package:fluttert_toast/fluttert_toast.dart';
```

### Basic Usage

```dart
final toast = FlutterToast();

// Success toast
toast.showSuccess(context, 'Operation completed successfully!');

// Error toast
toast.showError(context, 'Something went wrong!');

// Warning toast
toast.showWarning(context, 'Please check your input!');

// Info toast
toast.showInfo(context, 'New update available!');
```

## 📖 Usage

### Show Method

The `show` method allows you to display toast messages with full customization:

```dart
toast.show(
  context,
  'Hello, world!',
  type: ToastType.success,
  styleType: ToastStyleType.flat,
  duration: Duration(seconds: 5),
  position: ToastPosition.top,
  backgroundColor: Colors.white,
  textColor: Colors.black87,
  iconColor: Colors.green,
  iconPosition: IconPosition.left,
  iconSize: 30,
  fontSize: 14,
  showIcon: true,
  showText: true,
);
```

### Toast Types

```dart
// Using helper methods
toast.showSuccess(context, 'Success message');
toast.showError(context, 'Error message');
toast.showWarning(context, 'Warning message');
toast.showInfo(context, 'Info message');

// Or using show method with type
toast.show(context, 'Custom message', type: ToastType.custom);
```

### Toast Positions

```dart
// Top position
toast.showSuccess(context, 'Message', position: ToastPosition.top);

// Bottom position (default)
toast.showSuccess(context, 'Message', position: ToastPosition.bottom);

// Center position
toast.showSuccess(context, 'Message', position: ToastPosition.center);

// Corner positions
toast.showSuccess(context, 'Message', position: ToastPosition.topLeft);
toast.showSuccess(context, 'Message', position: ToastPosition.topRight);
toast.showSuccess(context, 'Message', position: ToastPosition.bottomLeft);
toast.showSuccess(context, 'Message', position: ToastPosition.bottomRight);
```

### Predefined Styles

We have 4 predefined styles for toast messages, each offering a unique look and feel:

#### 1. ToastStyleType.flat

A simple and clean style with a subtle border and light background. Ideal for minimalist notifications.

```dart
toast.showSuccess(
  context,
  'Component updates available.',
  styleType: ToastStyleType.flat,
);
```

#### 2. ToastStyleType.fillColored

A bold style with a solid colored background and white text/icon. Perfect for high-visibility alerts.

```dart
toast.showError(
  context,
  'Component updates available.',
  styleType: ToastStyleType.fillColored,
);
```

#### 3. ToastStyleType.flatColored

A balanced style with a light colored background, colored borders, and dark text. Great for notifications that need to stand out.

```dart
toast.showWarning(
  context,
  'Component updates available.',
  styleType: ToastStyleType.flatColored,
);
```

#### 4. ToastStyleType.minimal

A sleek and modern design with minimal elements, a left accent border, and a close button. Perfect for clean, distraction-free interfaces.

```dart
toast.showInfo(
  context,
  'Component updates available.',
  styleType: ToastStyleType.minimal,
);
```

### Icon Customization

```dart
toast.showSuccess(
  context,
  'Message',
  iconPosition: IconPosition.left, // or right, top, bottom, center
  iconSize: 30,
  iconPadding: EdgeInsets.all(8),
  iconMargin: EdgeInsets.only(right: 12),
  iconColor: Colors.green,
);
```

### Text Customization

```dart
toast.showSuccess(
  context,
  'Message',
  fontSize: 16,
  textPadding: EdgeInsets.all(8),
  textMargin: EdgeInsets.only(left: 12),
);
```

### Custom Colors

```dart
toast.showSuccess(
  context,
  'Message',
  backgroundColor: Colors.blue,
  textColor: Colors.white,
  iconColor: Colors.yellow,
);
```

### Alert Toast

Display interactive alert-style toasts with titles, action buttons, and callbacks:

```dart
toast.showAlert(
  context,
  'This is an alert message',
  title: 'Alert Title',
  actionButton: ElevatedButton(
    onPressed: () {
      toast.hide();
    },
    child: Text('OK'),
  ),
  onDismiss: () {
    print('Alert dismissed');
  },
  dismissible: true,
  showCloseButton: true,
);
```

### Dialog Toast with Input

Display dialog-style toasts with TextField input and confirm/cancel buttons:

```dart
toast.showDialogToast(
  context,
  'Please enter your name',
  textField: TextField(
    decoration: InputDecoration(
      labelText: 'Name',
      border: OutlineInputBorder(),
    ),
  ),
  onConfirm: (value) {
    print('Confirmed: $value');
  },
  onCancel: () {
    print('Cancelled');
  },
  confirmText: 'Confirm',
  cancelText: 'Cancel',
);
```

### Custom Builder

For complete control over the toast appearance, use the custom builder:

```dart
toast.show(
  context,
  'Message',
  builder: (context, message, icon, bgColor, textColor, iconColor, iconSize, iconPosition, fontSize, fontWeight, borderRadius, padding, margin, border, boxShadow, showIcon, showText) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: boxShadow,
      ),
      child: Row(
        children: [
          if (showIcon && icon != null)
            Icon(icon, color: iconColor, size: iconSize),
          SizedBox(width: 12),
          if (showText)
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ),
        ],
      ),
    );
  },
);
```

### Toggle Icon/Text Visibility

```dart
toast.showSuccess(
  context,
  'Message',
  showIcon: false, // Hide icon
  showText: true,  // Show text
);
```

### Duration

```dart
toast.showSuccess(
  context,
  'Message',
  duration: Duration(seconds: 5), // Show for 5 seconds
);
```

### Close Button

The close button is automatically enabled for minimal style toasts. You can also enable it for other styles:

```dart
toast.showSuccess(
  context,
  'Message',
  showCloseButton: true,
  closeButtonIcon: Icons.close,
  closeButtonSize: 20,
  closeButtonColor: Colors.grey,
);
```

## 📚 API Reference

### FlutterToast Methods

#### `show(context, message, {...})`

Show a custom toast message with full customization options.

**Parameters:**
- `context` - BuildContext for the toast
- `message` - The message to display
- `type` - ToastType (success, error, warning, info, custom)
- `duration` - Duration to display (default: 2 seconds)
- `position` - ToastPosition (top, bottom, center, corners)
- `styleType` - ToastStyleType (flat, fillColored, flatColored, minimal)
- `backgroundColor` - Custom background color
- `textColor` - Custom text color
- `iconColor` - Custom icon color
- `iconPosition` - IconPosition (left, right, top, bottom, center)
- `iconSize` - Icon size
- `fontSize` - Font size
- `showIcon` - Show/hide icon
- `showText` - Show/hide text
- `showCloseButton` - Show/hide close button
- `builder` - Custom builder function

#### Helper Methods

- `showSuccess(context, message, {...})` - Show a success toast
- `showError(context, message, {...})` - Show an error toast
- `showWarning(context, message, {...})` - Show a warning toast
- `showInfo(context, message, {...})` - Show an info toast
- `showAlert(context, message, {...})` - Show an alert toast
- `showDialogToast(context, message, {...})` - Show a dialog toast
- `hide()` - Hide the current toast
- `isVisible` - Check if toast is currently visible (getter)

### Enums

#### ToastType

- `ToastType.success` - Success toast (green)
- `ToastType.error` - Error toast (red)
- `ToastType.warning` - Warning toast (orange)
- `ToastType.info` - Info toast (blue)
- `ToastType.custom` - Custom toast

#### ToastPosition

- `ToastPosition.top` - Top center
- `ToastPosition.bottom` - Bottom center (default)
- `ToastPosition.center` - Center of screen
- `ToastPosition.topLeft` - Top left corner
- `ToastPosition.topRight` - Top right corner
- `ToastPosition.bottomLeft` - Bottom left corner
- `ToastPosition.bottomRight` - Bottom right corner

#### ToastStyleType

- `ToastStyleType.flat` - Flat style with light background
- `ToastStyleType.fillColored` - Filled background with white text and icon
- `ToastStyleType.flatColored` - Light colored background with dark border
- `ToastStyleType.minimal` - Minimal style with left border and close button

#### IconPosition

- `IconPosition.left` - Icon on the left (default)
- `IconPosition.right` - Icon on the right
- `IconPosition.top` - Icon on top
- `IconPosition.bottom` - Icon on bottom
- `IconPosition.center` - Icon centered over text

## 🎨 Examples

See the `example` folder for a complete example app demonstrating all features.

## 🤝 Contributing

Contributions are always welcome! If you have any suggestions, bug reports, or feature requests, please open an issue on the GitHub repository.

If you would like to contribute to the project, please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License. See the LICENSE file for details.

## 🙏 Acknowledgments

This package is inspired by the beautiful design of [toastification](https://pub.dev/packages/toastification) package. Special thanks to the toastification team for their excellent work.

---

**Made with ❤️ for Flutter developers**
