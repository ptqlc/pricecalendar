part of 'index.dart';

class CustomRadioGroup<T> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final int rowCount;
  final bool showIcon;
  final bool shrink;
  final double? spacing;
  final Widget Function(int index, bool isSelected) builder;
  final ValueChanged<T?>? onChanged;

  const CustomRadioGroup({
    super.key,
    this.items = const [],
    this.value,
    required this.builder,
    this.showIcon = true,
    this.rowCount = 1,
    this.spacing,
    this.onChanged,
    this.shrink = false,
  });

  @override
  State<CustomRadioGroup<T>> createState() => _CustomRadioGroupState<T>();
}

class _CustomRadioGroupState<T> extends State<CustomRadioGroup<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  void didUpdateWidget(covariant CustomRadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  void _onChanged(T value) {
    _value = value;
    widget.onChanged?.call(_value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _CheckboxGroupLayout(
      length: widget.items.length,
      rowCount: widget.rowCount,
      spacing: widget.spacing,
      builder: (int index, BoxConstraints constraints) {
        final item = widget.items[index];
        final isSelected = _value == item;
        return SizedBox(
          width: !widget.shrink ? constraints.maxWidth : null,
          child: CustomCheckbox(
            showIcon: widget.showIcon,
            value: isSelected,
            onTap: () => _onChanged(item),
            child: widget.builder(index, isSelected),
          ),
        );
      },
    );
  }
}

class CustomCheckboxGroup<T> extends StatefulWidget {
  final List<T> items;
  final List<T> values;
  final int? maxCount;
  final int rowCount;
  final bool showIcon;
  final bool shrink;
  final double? spacing;
  final Widget Function(int index, bool isSelected) builder;
  final ValueChanged<List<T>>? onChanged;

  const CustomCheckboxGroup({
    super.key,
    this.items = const [],
    this.values = const [],
    this.maxCount,
    required this.builder,
    this.showIcon = true,
    this.rowCount = 1,
    this.spacing,
    this.onChanged,
    this.shrink = false,
  });

  @override
  State<CustomCheckboxGroup<T>> createState() => _CustomCheckboxGroupState<T>();
}

class _CustomCheckboxGroupState<T> extends State<CustomCheckboxGroup<T>> {
  late List<T> _values;

  int get _maxCount => widget.maxCount ?? widget.items.length;

  @override
  void initState() {
    super.initState();
    _values = [...widget.values];
  }

  @override
  void didUpdateWidget(covariant CustomCheckboxGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _values = [...widget.values];
  }

  int _getCurrentIndex(T value) {
    return _values.indexWhere((element) => element == value);
  }

  void _onChanged(T value) {
    final index = _getCurrentIndex(value);
    if (index > -1) {
      _values.remove(value);
    } else {
      if (_values.length >= _maxCount) return;
      _values.add(value);
    }
    widget.onChanged?.call(_values);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _CheckboxGroupLayout(
      length: widget.items.length,
      rowCount: widget.rowCount,
      spacing: widget.spacing,
      builder: (int index, BoxConstraints constraints) {
        final item = widget.items[index];
        final isSelected = _getCurrentIndex(item) > -1;
        return SizedBox(
          width: !widget.shrink ? constraints.maxWidth : null,
          child: CustomCheckbox(
            showIcon: widget.showIcon,
            value: isSelected,
            onTap: () => _onChanged(item),
            child: widget.builder(index, isSelected),
          ),
        );
      },
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Widget? child;
  final bool showIcon;
  final void Function()? onTap;

  const CustomCheckbox({
    super.key,
    required this.value,
    this.child,
    this.showIcon = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final ws = <Widget>[];
    if (showIcon) {
      ws.add(Container(
        width: 16.w,
        height: 16.w,
        margin: EdgeInsets.only(right: child != null ? 12.w : 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.primary,
            width: 1.w,
          ),
          color: value ? colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular((4.w)),
        ),
        child: Visibility(
          visible: value,
          child: Icon(
            Icons.check_rounded,
            size: 13.w,
            color: colorScheme.onPrimary,
          ),
        ),
      ));
    }
    if (child != null) {
      ws.add(Flexible(
        fit: FlexFit.tight,
        child: child!,
      ));
    }
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: ws,
      ),
    );
  }
}

class _CheckboxGroupLayout extends StatelessWidget {
  final double? spacing;
  final int length;
  final int rowCount;
  final Widget Function(int index, BoxConstraints constraints) builder;

  const _CheckboxGroupLayout({
    required this.length,
    required this.builder,
    this.spacing,
    this.rowCount = 1,
  });

  double get _spacing => spacing ?? 15.w;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final margin = (rowCount - 1) * _spacing;
        final width = (constraints.maxWidth - margin) / rowCount;
        return Wrap(
          runSpacing: _spacing,
          spacing: _spacing,
          children: List.generate(length, (index) {
            return builder(
              index,
              BoxConstraints(
                minHeight: 0,
                minWidth: 0,
                maxHeight: constraints.maxHeight,
                maxWidth: width,
              ),
            );
          }),
        );
      },
    );
  }
}
