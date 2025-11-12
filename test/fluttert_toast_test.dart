import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toast_notification/flutter_toast.dart';

void main() {
  group('FlutterToast', () {
    test('should be a singleton', () {
      final toast1 = FlutterToast();
      final toast2 = FlutterToast();
      expect(toast1, same(toast2));
    });

    test('isVisible should be false initially', () {
      final toast = FlutterToast();
      expect(toast.isVisible, false);
    });

    test('hide should not throw when no toast is showing', () {
      final toast = FlutterToast();
      expect(() => toast.hide(), returnsNormally);
    });
  });

  group('ToastType', () {
    test('should return correct default colors', () {
      expect(ToastType.success.defaultColor, Colors.green);
      expect(ToastType.error.defaultColor, Colors.red);
      expect(ToastType.warning.defaultColor, Colors.orange);
      expect(ToastType.info.defaultColor, Colors.blue);
    });

    test('should return correct default icons', () {
      expect(ToastType.success.defaultIcon, Icons.check_circle);
      expect(ToastType.error.defaultIcon, Icons.error);
      expect(ToastType.warning.defaultIcon, Icons.warning);
      expect(ToastType.info.defaultIcon, Icons.info);
      expect(ToastType.custom.defaultIcon, null);
    });
  });

  group('ToastStyle', () {
    test('fromStyleType should create correct flat style', () {
      final style = ToastStyle.fromStyleType(
        ToastStyleType.flat,
        ToastType.success,
      );
      expect(style.styleType, ToastStyleType.flat);
      expect(style.backgroundColor, Colors.grey.shade100);
      expect(style.textColor, Colors.black87);
      expect(style.iconColor, Colors.green);
      expect(style.border, isNotNull);
    });

    test('fromStyleType should create correct fillColored style', () {
      final style = ToastStyle.fromStyleType(
        ToastStyleType.fillColored,
        ToastType.error,
      );
      expect(style.styleType, ToastStyleType.fillColored);
      expect(style.backgroundColor, Colors.red);
      expect(style.textColor, Colors.white);
      expect(style.iconColor, Colors.white);
    });

    test('fromStyleType should create correct flatColored style', () {
      final style = ToastStyle.fromStyleType(
        ToastStyleType.flatColored,
        ToastType.warning,
      );
      expect(style.styleType, ToastStyleType.flatColored);
      expect(style.textColor, Colors.black87);
      expect(style.border, isNotNull);
    });

    test('fromStyleType should create correct minimal style', () {
      final style = ToastStyle.fromStyleType(
        ToastStyleType.minimal,
        ToastType.info,
      );
      expect(style.styleType, ToastStyleType.minimal);
      expect(style.backgroundColor, Colors.white);
      expect(style.textColor, Colors.black87);
      expect(style.iconColor, Colors.blue);
      expect(style.border, isNotNull);
    });

    test('copyWith should create new instance with updated values', () {
      const originalStyle = ToastStyle(
        backgroundColor: Colors.black,
        textColor: Colors.white,
      );
      final newStyle = originalStyle.copyWith(
        backgroundColor: Colors.red,
      );
      expect(newStyle.backgroundColor, Colors.red);
      expect(newStyle.textColor, Colors.white);
      expect(originalStyle.backgroundColor, Colors.black);
    });
  });

  group('ToastStyleType', () {
    test('should have all expected values', () {
      expect(ToastStyleType.values.length, 4);
      expect(ToastStyleType.values, contains(ToastStyleType.flat));
      expect(ToastStyleType.values, contains(ToastStyleType.fillColored));
      expect(ToastStyleType.values, contains(ToastStyleType.flatColored));
      expect(ToastStyleType.values, contains(ToastStyleType.minimal));
    });
  });

  group('ToastPosition', () {
    test('should have all expected values', () {
      expect(ToastPosition.values.length, greaterThanOrEqualTo(7));
      expect(ToastPosition.values, contains(ToastPosition.top));
      expect(ToastPosition.values, contains(ToastPosition.bottom));
      expect(ToastPosition.values, contains(ToastPosition.center));
      expect(ToastPosition.values, contains(ToastPosition.topLeft));
      expect(ToastPosition.values, contains(ToastPosition.topRight));
      expect(ToastPosition.values, contains(ToastPosition.bottomLeft));
      expect(ToastPosition.values, contains(ToastPosition.bottomRight));
    });
  });

  group('IconPosition', () {
    test('should have all expected values', () {
      expect(IconPosition.values.length, 5);
      expect(IconPosition.values, contains(IconPosition.left));
      expect(IconPosition.values, contains(IconPosition.right));
      expect(IconPosition.values, contains(IconPosition.top));
      expect(IconPosition.values, contains(IconPosition.bottom));
      expect(IconPosition.values, contains(IconPosition.center));
    });
  });
}
