import 'package:flutter/material.dart';

class BottomSheetBarController {
  BottomSheetBarController();

  late final DraggableScrollableController draggableScrollableController;
  bool isExpanded = false;
  double maxSize = 1;
  double minSize = 0.2;

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
    draggableScrollableController.dispose();
  }
}

class BottomSheetBar extends StatefulWidget {
  const BottomSheetBar({
    required this.body,
    required this.header,
    required this.expandedSliver,
    super.key,
    this.bodyBottomPadding = 48,
    this.borderRadius = 16,
    this.controller,
  });

  final Widget body;
  final Widget header;
  final Widget expandedSliver;
  final double bodyBottomPadding;
  final BottomSheetBarController? controller;
  final double borderRadius;

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
    if (oldWidget.controller != widget.controller && widget.controller != null) {
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
        final minChildSize = _headerHeight / constraints.maxHeight;
        controller.minSize = minChildSize;
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(bottom: _headerHeight + widget.bodyBottomPadding),
                child: widget.body,
              ),
            ),
            BottomSheetBarSheet(
              onHeaderChange: _onHeaderMeasured,
              header: widget.header,
              minChildSize: minChildSize,
              expandedSliver: widget.expandedSliver,
              controller: controller,
              borderRadius: widget.borderRadius,
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
    required this.expandedSliver,
    required this.minChildSize,
    required this.controller,
    required this.borderRadius,
    super.key,
  });

  final void Function(Size size) onHeaderChange;
  final Widget header;
  final Widget expandedSliver;
  final double minChildSize;
  final BottomSheetBarController controller;
  final double borderRadius;

  @override
  State<BottomSheetBarSheet> createState() => _BottomSheetBarSheetState();
}

class _BottomSheetBarSheetState extends State<BottomSheetBarSheet> {
  @override
  void initState() {
    super.initState();
    widget.controller.draggableScrollableController = DraggableScrollableController();
    widget.controller.draggableScrollableController.addListener(_controllerListener);
  }

  void _controllerListener() {
    if (widget.controller.isExpanded &&
        widget.controller.draggableScrollableController.size == widget.controller.minSize) {
      widget.controller.isExpanded = false;
    }

    if (!widget.controller.isExpanded &&
        widget.controller.draggableScrollableController.size == widget.controller.maxSize) {
      widget.controller.isExpanded = true;
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
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
    return DraggableScrollableSheet(
      controller: widget.controller.draggableScrollableController,
      initialChildSize: widget.minChildSize,
      minChildSize: widget.minChildSize,
      snap: true,
      builder: (context, scrollController) {
        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(widget.borderRadius)),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: MeasureSize(
                  onChange: widget.onHeaderChange,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: _onHeaderTap,
                    child: widget.header,
                  ),
                ),
              ),
              widget.expandedSliver,
            ],
          ),
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
