import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../config/turbo_breakpoint_config.dart';
import '../extensions/turbo_box_constraints_extension.dart';
import '../models/turbo_data.dart';
import '../models/turbo_tools.dart';

class TurboResponsiveBuilder extends StatelessWidget {
  const TurboResponsiveBuilder({
    super.key,
    required this.builder,
    this.child,
    this.breakpointConfig = const TurboBreakpointConfig(),
    this.widthInDesign = 720.0,
    this.heightInDesign = 1440.0,
  });

  final Widget Function(
    BuildContext context,
    Widget? child,
    BoxConstraints constraints,
    TurboTools tools,
    TurboData data,
  )
  builder;

  final Widget? child;
  final TurboBreakpointConfig breakpointConfig;
  final double widthInDesign;
  final double heightInDesign;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final media = MediaQuery.of(context);
      final deviceType = constraints.turboDeviceType(
        breakpointConfig: breakpointConfig,
      );
      final orientation = constraints.turboOrientation;

      final tools = TurboTools(
        currentWidth: constraints.maxWidth,
        currentHeight: constraints.maxHeight,
        widthInDesign: widthInDesign,
        heightInDesign: heightInDesign,
      );

      final data = TurboData(
        currentWidth: constraints.maxWidth,
        currentHeight: constraints.maxHeight,
        orientation: orientation,
        deviceType: deviceType,
        media: media,
      );

      final builtWidget = builder(context, child, constraints, tools, data);

      return SizedBox(
        width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: builtWidget,
      );
    },
  );
}
