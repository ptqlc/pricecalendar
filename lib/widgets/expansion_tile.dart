part of 'index.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final Widget? child;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CustomExpansionTile({
    super.key,
    required this.title,
    this.child,
    this.value = false,
    this.onChanged,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  final Duration _duration = const Duration(milliseconds: 200);
  final Animatable<double> _easeOutTween = CurveTween(curve: Curves.easeOut);
  final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  final Animatable<double> _halfTween = Tween<double>(begin: 0.0, end: 0.5);
  final ColorTween _borderColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _borderColor;

  bool _isExpanded = false;

  EdgeInsets get _padding => EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.w,
      );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _duration, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _isExpanded = widget.value;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    _borderColorTween.end = colorScheme.primary;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (widget.child == null) return;
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isClose = !_isExpanded && _controller.isDismissed;
    Widget? child;
    if (!isClose) {
      child = Offstage(
        offstage: isClose,
        child: TickerMode(
          enabled: !isClose,
          child: Container(
            width: double.infinity,
            padding: _padding.copyWith(left: 0, right: 0),
            margin: _padding.copyWith(top: 0, bottom: 0),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: theme.dividerTheme.color ?? Colors.transparent,
                  width: 1.w,
                ),
              ),
            ),
            child: widget.child,
          ),
        ),
      );
    }
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _builder,
      child: child,
    );
  }

  Widget _builder(BuildContext context, Widget? child) {
    return CustomCard(
      borderColor: _borderColor.value,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _onTap,
            child: Padding(
              padding: _padding,
              child: _buildTitle(),
            ),
          ),
          if (child != null)
            ClipPath(
              child: Align(
                alignment: Alignment.topLeft,
                heightFactor: _heightFactor.value,
                child: child,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: 18.w,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
            child: widget.title,
          ),
        ),
        IconTheme(
          data: IconThemeData(
            color: colorScheme.primary.withValues(
              alpha: widget.child == null ? 0.5 : 1,
            ),
            size: 24.w,
          ),
          child: RotationTransition(
            turns: _iconTurns,
            child: const Icon(Icons.keyboard_arrow_down_rounded),
          ),
        ),
      ],
    );
  }
}
