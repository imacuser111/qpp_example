import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

const String _arrowUp = 'desktop-icon-list-selection-arrow-up';
const String _arrowDown = 'desktop-icon-list-selection-arrow-down';

/// 點擊變換上下箭頭元件
/// 預設為向上, 若要預設向下請使用 [ClickArrow.defaultDown]
class BtnArrowUpDown extends StatefulWidget {
  // 箭頭大小
  final double size;
  final bool showUp;

  /// Called when state change between expanded/compress
  final Function(bool val)? callback;

  /// 外部傳入點擊事件
  final Function()? onTap;

  const BtnArrowUpDown(
      {Key? key, required this.size, this.callback, this.onTap})
      : showUp = true,
        super(key: key);
  const BtnArrowUpDown.defaultDown(
      {Key? key, required this.size, this.callback, this.onTap})
      : showUp = false,
        super(key: key);

  String get _arrowPath {
    return showUp ? _arrowUp : _arrowDown;
  }

  @override
  StateClickArrow createState() => StateClickArrow();
}

class StateClickArrow extends State<BtnArrowUpDown>
    with TickerProviderStateMixin {
  late bool _isUp;

  void _onTap() {
    setState(() {
      rotate();
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
        // 若預設為往下箭頭, 結束位置反轉
        Tween<double>(begin: 0, end: widget._arrowPath == _arrowUp ? 0.5 : -0.5)
            .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap ?? _onTap,
      child: RotationTransition(
        turns: _animation,
        child: SvgPicture.asset(
          'assets/${widget._arrowPath}.svg',
          width: widget.size,
          height: widget.size,
        ),
      ),
    );
  }

  /// 旋轉
  rotate() {
    setState(() {
      _isUp ? _animationController.forward() : _animationController.reverse();
      _isUp = !_isUp;
      widget.callback?.call(_isUp);
    });
  }
}
