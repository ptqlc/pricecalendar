part of 'index.dart';

class CustomCellGroup extends StatelessWidget {
  final List<Widget> children;
  final double? minHeight;
  final bool showDivider;

  const CustomCellGroup({
    super.key,
    this.children = const [],
    this.minHeight,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final ws = <Widget>[];
    for (var index = 0; index < children.length; index++) {
      if (index != 0 && showDivider) ws.add(Divider(height: 1.w));
      ws.add(ConstrainedBox(
        constraints: BoxConstraints(minHeight: minHeight ?? 65.w),
        child: children[index],
      ));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: ws,
    );
  }
}

class CustomCell extends StatelessWidget {
  final Widget title;
  final Widget? icon;
  final Widget? value;
  final bool? showArrow;
  final double? valueWidth;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final EdgeInsets? padding;
  final void Function()? onTap;

  const CustomCell({
    super.key,
    required this.title,
    this.icon,
    this.value,
    this.showArrow,
    this.valueWidth,
    this.onTap,
    this.titleStyle,
    this.valueStyle,
    this.padding,
  });

  factory CustomCell.simple({
    Key? key,
    required Widget title,
    Widget? value,
    EdgeInsets? padding,
  }) = _CellWithSimple;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ws = <Widget>[];
    if (icon != null) {
      ws.add(IconTheme(
        data: IconThemeData(
          color: colorScheme.primary,
          size: 26.w,
        ),
        child: icon!,
      ));
      ws.add(SizedBox(width: 16.w));
    }
    ws.add(Expanded(
      child: DefaultTextStyle.merge(
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20.w,
        ).merge(titleStyle),
        child: title,
      ),
    ));
    if (value != null) {
      ws.add(SizedBox(width: 12.w));
      ws.add(Container(
        constraints: BoxConstraints(maxWidth: valueWidth ?? double.infinity),
        alignment: Alignment.centerRight,
        child: DefaultTextStyle.merge(
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16.w,
            color: colorScheme.onSurface.withOpacity(0.7),
          ).merge(valueStyle),
          child: value!,
        ),
      ));
    }
    if (onTap != null && showArrow != false) {
      ws.add(SizedBox(width: 8.w));
      ws.add(Icon(
        Icons.arrow_forward_ios_rounded,
        size: 16.w,
        color: colorScheme.primary,
      ));
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(vertical: 10.w),
        child: Row(children: ws),
      ),
    );
  }
}

class _CellWithSimple extends CustomCell {
  _CellWithSimple({
    super.key,
    required super.title,
    super.value,
    super.padding,
  }) : super(
          titleStyle: TextStyle(fontSize: 18.w),
          valueStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppTheme.primary,
            fontSize: 18.w,
          ),
        );
}
