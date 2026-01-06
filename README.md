# turbo_responsiveness

Responsive design utilities and widgets for Flutter applications.

## Features

- **Device Type Detection**: Automatically detect mobile, tablet, and desktop device types
- **Responsive Builders**: Build widgets that adapt to different screen sizes
- **Breakpoint Configuration**: Customizable breakpoints for responsive design
- **Orientation Support**: Handle portrait and landscape orientations
- **Design Tools**: Utilities for scaling and adapting designs across devices

## Getting Started

Add `turbo_responsiveness` to your `pubspec.yaml`:

```yaml
dependencies:
  turbo_responsiveness: ^1.0.0
```

## Usage

### Basic Responsive Builder

```dart
import 'package:turbo_responsiveness/turbo_responsiveness.dart';

TurboResponsiveBuilder(
  builder: (context, child, constraints, tools, data) {
    if (data.deviceType == TurboDeviceType.mobile) {
      return MobileLayout();
    } else {
      return DesktopLayout();
    }
  },
  child: YourWidget(),
)
```

### Device Type Builder

```dart
TurboDeviceTypeBuilder(
  onMobile: (context, deviceType, child) => MobileView(),
  onTablet: (context, deviceType, child) => TabletView(),
  onDesktop: (context, deviceType, child) => DesktopView(),
  child: YourWidget(),
)
```

## Additional Information

For more details, visit the [GitHub repository](https://github.com/appboypov/turbo_responsiveness).
