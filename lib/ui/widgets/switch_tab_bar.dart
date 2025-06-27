import 'package:flutter/material.dart';

class SwitchTabBar extends StatefulWidget {
  const SwitchTabBar({
    required this.tabs,
    required this.onTabChanged,
    super.key,
    this.initialIndex = 0,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.grey,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.indicatorColor = Colors.blue,
    this.height = 50.0,
    this.borderRadius = 25.0,
    this.activeTextStyle,
    this.inactiveTextStyle,
  });

  final List<String> tabs;
  final void Function(int) onTabChanged;
  final int initialIndex;
  final Color activeColor;
  final Color inactiveColor;
  final Color backgroundColor;
  final Color indicatorColor;
  final double height;
  final double borderRadius;
  final TextStyle? activeTextStyle;
  final TextStyle? inactiveTextStyle;

  @override
  State<SwitchTabBar> createState() => _SwitchTabBarState();
}

class _SwitchTabBarState extends State<SwitchTabBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween<double>(
      begin: _selectedIndex.toDouble(),
      end: _selectedIndex.toDouble(),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectTab(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _animation = Tween<double>(
          begin: _selectedIndex.toDouble(),
          end: index.toDouble(),
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
        _selectedIndex = index;
      });
      _controller.forward(from: 0);
      widget.onTabChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
      ),
      child: Stack(
        children: [
          // Animated indicator
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                left:
                    _animation.value *
                    (MediaQuery.of(context).size.width - 32) /
                    widget.tabs.length,
                top: 4,
                child: Container(
                  width: (MediaQuery.of(context).size.width - 32) / widget.tabs.length - 8,
                  height: widget.height - 8,
                  decoration: BoxDecoration(
                    color: widget.indicatorColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius - 4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          // Tab buttons
          Row(
            children:
                widget.tabs.asMap().entries.map((entry) {
                  final index = entry.key;
                  final tab = entry.value;
                  final isSelected = index == _selectedIndex;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => _selectTab(index),
                      child: Container(
                        height: widget.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.borderRadius),
                        ),
                        child: Center(
                          child: Text(
                            tab,
                            style:
                                isSelected
                                    ? (widget.activeTextStyle ??
                                        TextStyle(
                                          color: widget.activeColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ))
                                    : (widget.inactiveTextStyle ??
                                        TextStyle(
                                          color: widget.inactiveColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        )),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
