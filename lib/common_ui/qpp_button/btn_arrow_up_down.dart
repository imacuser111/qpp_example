import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 點擊變換上下箭頭元件
/// 預設為向上, 若要預設向下請使用 [ClickArrow.defaultDown]
class BtnArrowUpDown extends StatefulWidget {
  // 箭頭大小
  final double size;
  final bool showUp;

  /// Called when state change between expanded/compress
  final Function(bool val)? callback;

  const BtnArrowUpDown({Key? key, required this.size, this.callback})
      : showUp = true,
        super(key: key);
  const BtnArrowUpDown.defaultDown(
      {Key? key, required this.size, this.callback})
      : showUp = false,
        super(key: key);

  String _getArrowPath(bool isUp) {
    return isUp
        ? 'desktop-icon-list-selection-arrow-up'
        : 'desktop-icon-list-selection-arrow-down';
  }

  @override
  State<StatefulWidget> createState() => _StateClickArrow();
}

class _StateClickArrow extends State<BtnArrowUpDown>
    with TickerProviderStateMixin {
  // desktop-icon-list-selection-arrow-down
  // desktop-icon-list-selection-arrow-up
  late bool _isUp;

  void _onTapLink() {
    setState(() {
      _isUp ? _animationController.forward() : _animationController.reverse();
      widget.callback?.call(_isUp);
      _isUp = !_isUp;
    });
  }

  late final Animation<double> _animation;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _isUp = widget.showUp;
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _animation =
        Tween<double>(begin: 0, end: 0.5).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapLink,
      child: RotationTransition(
        turns: _animation,
        child: SvgPicture.asset(
          'assets/desktop-icon-list-selection-arrow-up.svg',
          // 'assets/${widget._getArrowPath(_isUp)}.svg',
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }
}
