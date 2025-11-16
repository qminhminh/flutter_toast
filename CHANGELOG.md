## 1.1.0

* **New Features:**
  * Added `textAlign` parameter to customize text alignment (left, center, right, justify)
  * Added `textStyle` parameter for full TextStyle customization with all properties (fontSize, fontWeight, color, letterSpacing, height, decoration, shadows, etc.)
  * Added `crossAxisAlignment` parameter to vertically align content in toast (default: center)
  * Added `width` and `height` parameters to customize toast dimensions
  * Added `horizontalAlignment` parameter to position toast on left/right when using top/bottom/center positions
  * Added `ToastStyleType.simple` - Simple style with light background, no icon, no close button

* **Improvements:**
  * Text in minimal style (and all styles) now vertically centered by default
  * Better text vertical alignment in Row layouts
  * Enhanced customization options for all toast styles

## 1.0.0

* Initial release of flutter_toast_notification package
* Support for all platforms: Android, iOS, Web, Desktop, macOS, Linux
* Multiple toast types: Success, Error, Warning, Info, and Custom
* Flexible positioning: Top, Bottom, Center, and corner positions
* Predefined styles: Flat, Fill Colored, Flat Colored, and Minimal
* Icon customization: Position, size, color, padding, and margin
* Text customization: Font size, padding, margin, and responsive sizing
* Custom colors: Background, text, and icon colors
* Alert toast: Interactive alerts with titles, action buttons, and callbacks
* Dialog toast: Dialog-style toasts with TextField input and buttons
* Custom builder: Full control over toast widget design
* Visibility control: Toggle icon and text visibility
* Close button: Optional close button for minimal style toasts
* Animation support: Smooth fade and slide animations
* Duration control: Customizable toast display duration
