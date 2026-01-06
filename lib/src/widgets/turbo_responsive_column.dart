import 'package:flutter/material.dart';

/// A responsive layout widget that automatically arranges children in columns based on available width
class TurboResponsiveColumn extends StatelessWidget {
  const TurboResponsiveColumn({
    super.key,
    required this.children,
    this.maxWidth = 1024,
    this.maxColumns = 2,
    this.crossAxisSpacing = 16.0,
    this.spacing = 12,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : assert(maxColumns > 0, 'maxColumns must be greater than 0');

  /// The widgets to be displayed in the columns
  final List<Widget> children;

  /// The maximum total width before splitting into columns
  final double maxWidth;

  /// The maximum number of columns to display
  final int maxColumns;

  /// The spacing between columns
  final double crossAxisSpacing;

  /// The spacing between elements
  final double spacing;

  /// The alignment of the content
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final columnCount = _calculateColumnCount(width);
        final content = columnCount == 1
            ? Column(
                crossAxisAlignment: crossAxisAlignment,
                mainAxisAlignment: MainAxisAlignment.start,
                children: _spacedChildren(spacing),
              )
            : _buildMultiColumn(columnCount);

        return SizedBox(
          width: width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: content,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> _spacedChildren(double spacing) {
    if (spacing == 0) return children;
    final spaced = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      if (i > 0) spaced.add(SizedBox(height: spacing));
      spaced.add(children[i]);
    }
    return spaced;
  }

  Widget _buildMultiColumn(int columnCount) {
    final columns = List<List<Widget>>.generate(columnCount, (_) => []);

    for (var i = 0; i < children.length; i++) {
      final columnIndex = i % columnCount;
      columns[columnIndex].add(children[i]);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < columns.length; i++)
          Expanded(
            child: Column(
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: MainAxisAlignment.start,
              children: _spacedChildren(spacing),
            ),
          ),
        if (columns.length > 1) SizedBox(width: crossAxisSpacing),
      ],
    );
  }

  int _calculateColumnCount(double width) {
    final columnWidth = maxWidth / maxColumns;
    final possibleColumns = (width / columnWidth).floor();
    return possibleColumns.clamp(1, maxColumns);
  }
}
