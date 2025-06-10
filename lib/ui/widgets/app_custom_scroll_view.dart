import 'package:flutter/material.dart';

class AppCustomScrollView extends StatefulWidget {
  const AppCustomScrollView({
    required this.slivers,
    super.key,
    this.onLoadMore,
    this.onRefresh,
    this.controller,
  });

  final List<Widget> slivers;
  final Future<void> Function()? onLoadMore;
  final RefreshCallback? onRefresh;
  final ScrollController? controller;

  @override
  State<AppCustomScrollView> createState() => _AppCustomScrollViewState();
}

class _AppCustomScrollViewState extends State<AppCustomScrollView> {
  final ValueNotifier<bool> _isLoadingMore = ValueNotifier<bool>(false);
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _isLoadingMore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (!mounted) return false;

        final endReached =
            notification.metrics.pixels >= notification.metrics.maxScrollExtent - 50;

        final shouldLoadMore =
            endReached && !_isLoadingMore.value && widget.onLoadMore != null;

        if (shouldLoadMore) {
          _isLoadingMore.value = true;
          widget.onLoadMore!().then((value) {
            _isLoadingMore.value = false;
          });
        }
        return true;
      },
      child:
          widget.onRefresh != null
              ? RefreshIndicator(onRefresh: widget.onRefresh!, child: _getScrollView())
              : _getScrollView(),
    );
  }

  Widget _getScrollView() {
    return CustomScrollView(
      clipBehavior: Clip.none,
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        ...widget.slivers,
        SliverToBoxAdapter(
          child: ValueListenableBuilder<bool>(
            valueListenable: _isLoadingMore,
            builder: (BuildContext context, bool value, Widget? child) {
              return value
                  ? Container(
                    margin: const EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: const SizedBox.square(dimension: 24, child: CircularProgressIndicator()),
                  )
                  : const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}
