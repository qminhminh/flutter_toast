# fluttert_toast

A simple and powerful Flutter package for displaying toast messages on all platforms (Android, iOS, Web, Desktop, macOS, Linux).

## Features

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

## Getting Started

### Installation

Add `fluttert_toast` to your `pubspec.yaml`:

```yaml
dependencies:
  fluttert_toast: ^1.0.0
```

Then run:

```bash
flutter pub get
```

### Import

```dart
import 'package:fluttert_toast/fluttert_toast.dart';
```

## Usage

### Basic Toast

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

### Custom Toast

```dart
toast.show(
  context,
  'Custom toast message',
  type: ToastType.custom,
  backgroundColor: Colors.purple,
  textColor: Colors.white,
  icon: Icons.star,
  iconColor: Colors.yellow,
);
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

```dart
// Flat style
toast.showSuccess(
  context,
  'Component updates available.',
  styleType: ToastStyleType.flat,
);

// Fill colored style
toast.showError(
  context,
  'Component updates available.',
  styleType: ToastStyleType.fillColored,
);

// Flat colored style
toast.showWarning(
  context,
  'Component updates available.',
  styleType: ToastStyleType.flatColored,
);

// Minimal style (with close button)
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
);
```

### Dialog Toast with Input

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
);
```

### Custom Builder

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
            Text(message, style: TextStyle(color: textColor, fontSize: fontSize)),
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

## API Reference

### FlutterToast Methods

- `show(context, message, {...})` - Show a custom toast
- `showSuccess(context, message, {...})` - Show a success toast
- `showError(context, message, {...})` - Show an error toast
- `showWarning(context, message, {...})` - Show a warning toast
- `showInfo(context, message, {...})` - Show an info toast
- `showAlert(context, message, {...})` - Show an alert toast
- `showDialogToast(context, message, {...})` - Show a dialog toast
- `hide()` - Hide the current toast
- `isVisible` - Check if toast is currently visible

### ToastType Enum

- `ToastType.success` - Success toast (green)
- `ToastType.error` - Error toast (red)
- `ToastType.warning` - Warning toast (orange)
- `ToastType.info` - Info toast (blue)
- `ToastType.custom` - Custom toast

### ToastPosition Enum

- `ToastPosition.top` - Top center
- `ToastPosition.bottom` - Bottom center (default)
- `ToastPosition.center` - Center of screen
- `ToastPosition.topLeft` - Top left corner
- `ToastPosition.topRight` - Top right corner
- `ToastPosition.bottomLeft` - Bottom left corner
- `ToastPosition.bottomRight` - Bottom right corner

### ToastStyleType Enum

- `ToastStyleType.flat` - Flat style with light background
- `ToastStyleType.fillColored` - Filled background with white text and icon
- `ToastStyleType.flatColored` - Light colored background with dark border
- `ToastStyleType.minimal` - Minimal style with left border and close button

### IconPosition Enum

- `IconPosition.left` - Icon on the left (default)
- `IconPosition.right` - Icon on the right
- `IconPosition.top` - Icon on top
- `IconPosition.bottom` - Icon on bottom
- `IconPosition.center` - Icon centered over text

## Example

See the `example` folder for a complete example app demonstrating all features.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License.
