import 'package:flutter/material.dart';

class BottomSheetBar extends StatefulWidget {
  const BottomSheetBar({
    required this.body,
    required this.header,
    required this.expandedSliver,
    super.key,
  });

  final Widget body;
  final Widget header;
  final Widget expandedSliver;

  @override
  State<BottomSheetBar> createState() => _BottomSheetBarState();
}

class _BottomSheetBarState extends State<BottomSheetBar> {
  double _headerHeight = 60;
  bool _isHeaderMeasured = false;

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

        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(bottom: _headerHeight + 24),
                child: widget.body,
              ),
            ),
            BottomSheetBarSheet(
              onHeaderChange: _onHeaderMeasured,
              header: widget.header,
              minChildSize: minChildSize,
              expandedSliver: widget.expandedSliver,
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
    super.key,
  });

  final void Function(Size size) onHeaderChange;
  final Widget header;
  final Widget expandedSliver;
  final double minChildSize;

  @override
  State<BottomSheetBarSheet> createState() => _BottomSheetBarSheetState();
}

class _BottomSheetBarSheetState extends State<BottomSheetBarSheet> {
  final DraggableScrollableController _draggableScrollableController =
      DraggableScrollableController();
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _draggableScrollableController.addListener(_controllerListener);
  }

  @override
  void dispose() {
    _draggableScrollableController
      ..removeListener(_controllerListener)
      ..dispose();
    super.dispose();
  }

  void _controllerListener() {
    if (_draggableScrollableController.size == 1 && !_expanded) {
      setState(() {
        _expanded = true;
      });
    } else if (_expanded) {
      setState(() {
        _expanded = false;
      });
    }
  }

  void _onHeaderTap() {
    if (_expanded) {
      _draggableScrollableController.animateTo(
        widget.minChildSize,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    } else {
      _draggableScrollableController.animateTo(
        1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: _draggableScrollableController,
      initialChildSize: widget.minChildSize,
      minChildSize: widget.minChildSize,
      snap: true,
      builder: (context, scrollController) {
        return Material(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
