import 'package:flutter/widgets.dart';
import '../config/turbo_breakpoint_config.dart';
import '../enums/turbo_device_type.dart';
import '../enums/turbo_orientation.dart';

extension TurboBoxConstraintsExtension on BoxConstraints {
  TurboOrientation get turboOrientation {
    final difference = (maxHeight - maxWidth).abs();
    const landscapeMultiplier = 1;
    const portraitMultiplier = 1;
    final landscapeThreshold = maxHeight * landscapeMultiplier;
    final portraitThreshold = maxWidth * portraitMultiplier;

    if (difference <= landscapeThreshold && difference <= portraitThreshold) {
      return TurboOrientation.square;
    }

    return maxHeight > maxWidth
        ? TurboOrientation.portrait
        : TurboOrientation.landscape;
  }

  TurboDeviceType turboDeviceType({
    required TurboBreakpointConfig breakpointConfig,
  }) {
    if (maxWidth >= breakpointConfig.desktopBreakpointWidth ||
        maxHeight >= breakpointConfig.desktopBreakpointHeight) {
      return TurboDeviceType.desktop;
    }
    if (maxWidth >= breakpointConfig.tabletBreakpointWidth) {
      return TurboDeviceType.tablet;
    }
    return TurboDeviceType.mobile;
  }
}
