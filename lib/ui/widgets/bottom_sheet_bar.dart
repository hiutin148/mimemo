import 'dart:math';

import 'package:flutter/material.dart';

class BottomSheetBarController {
  BottomSheetBarController();

  late ScrollController scrollController;
  DraggableScrollableController? _draggableScrollableController;
  bool isExpanded = false;
  double maxSize = 1;
  double minSize = 0.2;

  // Getter that creates the controller if it doesn't exist
  DraggableScrollableController get draggableScrollableController {
    _draggableScrollableController ??= DraggableScrollableController();
    return _draggableScrollableController!;
  }

  // Setter for backward compatibility
  set draggableScrollableController(DraggableScrollableController controller) {
    _draggableScrollableController = controller;
  }

  void expand() {
    draggableScrollableController.animateTo(
      maxSize,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
    isExpanded = true;
  }

  void collapse() {
    draggableScrollableController.animateTo(
      minSize,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
    isExpanded = false;
  }

  void dispose() {
    _draggableScrollableController?.dispose();
    _draggableScrollableController = null;
  }
}

class BottomSheetBar extends StatefulWidget {
  const BottomSheetBar({
    required this.body,
    required this.header,
    super.key,
    this.bodyBottomPadding = 48,
    this.borderRadius = 16,
    this.controller,
    this.expandedSliver,
    this.expandedWidget,
    this.expandedBuilder,
  }) : assert(
         (expandedSliver != null) ^
             (expandedWidget != null) ^
             (expandedBuilder != null),
         'Exactly one of expandedSliver, expandedWidget, or expandedBuilder must be provided',
       );

  final Widget body;
  final Widget header;
  final Widget? expandedSliver; // Keep for backward compatibility
  final Widget? expandedWidget; // New option for normal widgets
  final double bodyBottomPadding;
  final BottomSheetBarController? controller;
  final double borderRadius;
  final ScrollableWidgetBuilder? expandedBuilder;

  @override
  State<BottomSheetBar> createState() => _BottomSheetBarState();
}

class _BottomSheetBarState extends State<BottomSheetBar> {
  double _headerHeight = 60;
  bool _isHeaderMeasured = false;
  late final BottomSheetBarController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? BottomSheetBarController();
  }

  @override
  void didUpdateWidget(covariant BottomSheetBar oldWidget) {
    if (oldWidget.controller != widget.controller &&
        widget.controller != null) {
      controller = widget.controller!;
    }
    super.didUpdateWidget(oldWidget);
  }

  void _onHeaderMeasured(Size size) {
    if (!_isHeaderMeasured || _headerHeight != size.height) {
      setState(() {
        _headerHeight = size.height;
        _isHeaderMeasured = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double minChildSize = 0;
        if (controller.minSize > 0) {
          minChildSize = _headerHeight / constraints.maxHeight;
          controller.minSize = minChildSize;
        }

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: minChildSize != 0
                      ? _headerHeight + widget.bodyBottomPadding
                      : 0,
                ),
                child: widget.body,
              ),
            ),
            BottomSheetBarSheet(
              onHeaderChange: _onHeaderMeasured,
              header: widget.header,
              minChildSize: minChildSize,
              expandedSliver: widget.expandedSliver,
              expandedWidget: widget.expandedWidget,
              controller: controller,
              borderRadius: widget.borderRadius,
              expandedBuilder: widget.expandedBuilder,
              headerHeight: _headerHeight,
            ),
          ],
        );
      },
    );
  }
}

class BottomSheetBarSheet extends StatefulWidget {
  const BottomSheetBarSheet({
    required this.onHeaderChange,
    required this.header,
    required this.minChildSize,
    required this.controller,
    required this.borderRadius,
    required this.headerHeight,
    super.key,
    this.expandedSliver,
    this.expandedWidget,
    this.expandedBuilder,
  });

  final void Function(Size size) onHeaderChange;
  final Widget header;
  final Widget? expandedSliver;
  final Widget? expandedWidget;
  final double minChildSize;
  final BottomSheetBarController controller;
  final double borderRadius;
  final ScrollableWidgetBuilder? expandedBuilder;
  final double headerHeight;

  @override
  State<BottomSheetBarSheet> createState() => _BottomSheetBarSheetState();
}

class _BottomSheetBarSheetState extends State<BottomSheetBarSheet> {
  @override
  void initState() {
    super.initState();
    // Access the controller through the getter, which will create it if needed
    // Remove any existing listener to avoid duplicates
    widget.controller.draggableScrollableController.removeListener(_controllerListener);
    widget.controller.draggableScrollableController.addListener(_controllerListener);
  }

  void _controllerListener() {
    if (widget.controller.isExpanded &&
        widget.controller.draggableScrollableController.size ==
            widget.controller.minSize) {
      widget.controller.isExpanded = false;
    }

    if (!widget.controller.isExpanded &&
        widget.controller.draggableScrollableController.size ==
            widget.controller.maxSize) {
      widget.controller.isExpanded = true;
    }
  }

  @override
  void dispose() {
    // Only remove the listener, don't dispose the controller here
    // since it's managed by the BottomSheetBarController
    widget.controller.draggableScrollableController.removeListener(_controllerListener);
    super.dispose();
  }

  void _onHeaderTap() {
    if (widget.controller.isExpanded) {
      widget.controller.collapse();
    } else {
      widget.controller.expand();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return DraggableScrollableSheet(
          controller: widget.controller.draggableScrollableController,
          initialChildSize: widget.minChildSize,
          minChildSize: widget.minChildSize,
          snap: true,
          builder: (context, scrollController) {
            widget.controller.scrollController = scrollController;
            return Material(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(widget.borderRadius),
              ),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      maxHeight: widget.headerHeight,
                      minHeight: widget.headerHeight,
                      child: MeasureSize(
                        onChange: widget.onHeaderChange,
                        child: GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: _onHeaderTap,
                          child: widget.header,
                        ),
                      ),
                    ),
                  ),
                  // Use either the provided sliver or wrap the widget in a sliver
                  widget.expandedSliver ??
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: constraints.maxHeight,
                          child:
                          widget.expandedBuilder?.call(
                            context,
                            scrollController,
                          ) ??
                              widget.expandedWidget ??
                              const SizedBox.shrink(),
                        ),
                      ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class MeasureSize extends StatefulWidget {
  const MeasureSize({required this.onChange, required this.child, super.key});

  final Widget child;
  final void Function(Size) onChange;

  @override
  State<MeasureSize> createState() => _MeasureSizeState();
}

class _MeasureSizeState extends State<MeasureSize> {
  final GlobalKey _widgetKey = GlobalKey();
  Size? _oldSize;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallback);
  }

  @override
  void didUpdateWidget(MeasureSize oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback(_postFrameCallback);
  }

  void _postFrameCallback(dynamic _) {
    final context = _widgetKey.currentContext;
    if (context == null) return;

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final newSize = renderBox.size;
    if (_oldSize != newSize) {
      _oldSize = newSize;
      widget.onChange(newSize);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(key: _widgetKey, child: widget.child);
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
