part of 'index.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
  final Widget? title;
  final Widget? cancel;
  final Widget? confirm;
  final void Function()? onCancel;
  final void Function()? onConfirm;
  final EdgeInsets? minimum;

  const CustomBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.cancel,
    this.confirm,
    this.onCancel,
    this.onConfirm,
    this.minimum,
  });

  static Future<T?> show<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    Widget? title,
    Widget? confirm,
    Widget? cancel,
    void Function()? onConfirm,
    void Function()? onCancel,
    EdgeInsets? minimum,
    bool enableDrag = true,
  }) {
    return showCustomModalBottomSheet<T>(
      context: context,
      enableDrag: enableDrag,
      barrierColor: const Color(0xFF09101D).withOpacity(0.7),
      containerWidget: (context, animation, child) {
        return CustomBottomSheet(
          title: title,
          confirm: confirm,
          cancel: cancel,
          onConfirm: onConfirm,
          onCancel: onCancel,
          minimum: minimum,
          child: child,
        );
      },
      builder: builder,
    );
  }

  static Future<T?> showFilter<T>({
    required BuildContext context,
  }) {
    return show<T>(
      context: context,
      title: const Text('Search filter'),
      confirm: const Text('Apply filter'),
      cancel: const Text('Clear'),
      builder: (context) => const _BottomSheetWithFilter(),
      onCancel: Navigator.of(context).pop,
      onConfirm: Navigator.of(context).pop,
    );
  }

  static Future<DateTime?> showDateTime({
    required BuildContext context,
    required Widget title,
    int type = PickerDateTimeType.kYMD,
    DateTime? value,
    DateTime? minValue,
    DateTime? maxValue,
  }) {
    final adapter = DateTimePickerAdapter(
      type: type,
      isNumberMonth: true,
      value: value,
      minValue: minValue,
      maxValue: maxValue,
    );
    final delimiters = <PickerDelimiter>[];
    if (type == PickerDateTimeType.kYMDHM) {
      delimiters.add(PickerDelimiter(
        column: 4,
        child: const Center(child: Text(':')),
      ));
    }
    return show<DateTime>(
      context: context,
      title: title,
      enableDrag: false,
      confirm: const Text('Confirm'),
      cancel: const Text('Cancel'),
      minimum: const EdgeInsets.all(0),
      builder: (BuildContext context) => _BottomSheetWithPicker(
        adapter: adapter,
        delimiters: delimiters,
      ),
      onCancel: Navigator.of(context).pop,
      onConfirm: () {
        Navigator.of(context).pop(DateTime.tryParse(adapter.text));
      },
    );
  }

  static Future<T?> showPicker<T>({
    required BuildContext context,
    List<T> items = const [],
    Widget? title,
    required Widget Function(T value) builder,
  }) async {
    final textStyle = TextStyle(
      fontSize: 19.w,
      height: 1.2,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface,
    );
    final adapter = PickerDataAdapter<T>(
      data: List.generate(items.length, (index) {
        return PickerItem(
          value: items[index],
          text: DefaultTextStyle.merge(
            style: textStyle,
            child: Center(child: builder(items[index])),
          ),
        );
      }),
    );
    return show<T>(
      context: context,
      title: title,
      enableDrag: false,
      confirm: const Text('Confirm'),
      cancel: const Text('Cancel'),
      minimum: const EdgeInsets.all(0),
      builder: (context) => _BottomSheetWithPicker(adapter: adapter),
      onCancel: Navigator.of(context).pop,
      onConfirm: () {
        Navigator.of(context).pop(adapter.getSelectedValues().first);
      },
    );
  }

  static Future<T?> showSelect<T>({
    required BuildContext context,
    required Widget Function(T value) builder,
    Widget? title,
    List<T> items = const [],
    T? value,
  }) async {
    return show<T>(
      context: context,
      title: title,
      builder: (BuildContext context) {
        final colorScheme = Theme.of(context).colorScheme;
        return CustomRadioGroup<T>(
          items: items,
          value: value,
          showIcon: false,
          spacing: 0,
          onChanged: Navigator.of(context).pop,
          builder: (index, isSelected) => Container(
            constraints: BoxConstraints(minHeight: 65.w),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1.w,
                  color: Theme.of(context).dividerTheme.color ??
                      colorScheme.onSurface.withOpacity(0.08),
                ),
              ),
            ),
            child: CustomCell(
              title: builder(items[index]),
              showArrow: false,
              value: Visibility(
                visible: isSelected,
                child: IconTheme(
                  data: IconThemeData(
                    size: 22.w,
                    color: colorScheme.primary,
                  ),
                  child: const Icon(Icons.check_rounded),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> share({
    required BuildContext context,
  }) {
    return show<void>(
      context: context,
      title: const Text('Share'),
      builder: (BuildContext context) => _BottomSheetWithShare(
        onTap: Navigator.of(context).pop,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonGroup = <Widget>[];
    if (cancel != null) {
      buttonGroup.add(Expanded(
        child: CustomButton(
          type: CustomButtonType.ghost,
          shape: CustomButtonShape.stadium,
          size: CustomButtonSize.large,
          onPressed: onCancel,
          child: cancel!,
        ),
      ));
    }
    if (confirm != null && cancel != null) {
      buttonGroup.add(SizedBox(width: 12.w));
    }
    if (confirm != null) {
      buttonGroup.add(Expanded(
        child: CustomButton(
          shape: CustomButtonShape.stadium,
          size: CustomButtonSize.large,
          onPressed: onConfirm,
          child: confirm!,
        ),
      ));
    }
    return SafeArea(
      bottom: false,
      minimum: const EdgeInsets.only(top: AppTheme.margin),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: Theme.of(context).bottomSheetTheme.backgroundColor,
        shape: Theme.of(context).bottomSheetTheme.shape,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.all(AppTheme.margin),
                  child: DefaultTextStyle.merge(
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22.w,
                      fontWeight: FontWeight.w600,
                    ),
                    child: title!,
                  ),
                ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  controller: ModalScrollController.of(context),
                  child: SafeArea(
                    top: false,
                    bottom: !buttonGroup.isNotEmpty,
                    minimum: (minimum ?? const EdgeInsets.all(AppTheme.margin))
                        .copyWith(top: title != null ? 0 : null),
                    child: child,
                  ),
                ),
              ),
              if (buttonGroup.isNotEmpty)
                SafeArea(
                  top: false,
                  minimum: EdgeInsets.symmetric(
                    horizontal: AppTheme.margin,
                    vertical: 10.w,
                  ),
                  child: Row(children: buttonGroup),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomSheetWithShare extends StatelessWidget {
  final void Function()? onTap;

  const _BottomSheetWithShare({this.onTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Wrap(
        runSpacing: 15.w,
        children: List.generate(8, (index) {
          return SizedBox(
            width: constraints.maxWidth / 4,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: Column(
                children: [
                  CustomImage.asset(
                    url: 'url',
                    width: 60.w,
                    height: 60.w,
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    'Facebook',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.w,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _BottomSheetWithFilter extends StatefulWidget {
  const _BottomSheetWithFilter();

  @override
  _BottomSheetWithFilterState createState() => _BottomSheetWithFilterState();
}

class _BottomSheetWithFilterState extends State<_BottomSheetWithFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTitle(title: const Text('Field of work')),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.w,
          children: List.generate(10, (index) {
            return CustomButton(
              type:
                  index != 0 ? CustomButtonType.ghost : CustomButtonType.filled,
              size: CustomButtonSize.small,
              shape: CustomButtonShape.stadium,
              child: const Text('All'),
              onPressed: () {},
            );
          }),
        ),
        SizedBox(height: 20.w),
        _buildTitle(title: const Text('Salary')),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.w,
          children: List.generate(10, (index) {
            return CustomButton(
              type:
                  index != 0 ? CustomButtonType.ghost : CustomButtonType.filled,
              size: CustomButtonSize.small,
              shape: CustomButtonShape.stadium,
              child: const Text('All job'),
              onPressed: () {},
            );
          }),
        ),
        SizedBox(height: 20.w),
        _buildTitle(title: const Text('Type')),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.w,
          children: List.generate(10, (index) {
            return CustomButton(
              type:
                  index != 0 ? CustomButtonType.ghost : CustomButtonType.filled,
              size: CustomButtonSize.small,
              shape: CustomButtonShape.stadium,
              child: const Text('All job'),
              onPressed: () {},
            );
          }),
        ),
        SizedBox(height: 20.w),
        _buildTitle(title: const Text('Location')),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.w,
          children: List.generate(10, (index) {
            return CustomButton(
              type:
                  index != 0 ? CustomButtonType.ghost : CustomButtonType.filled,
              size: CustomButtonSize.small,
              shape: CustomButtonShape.stadium,
              child: const Text('All job'),
              onPressed: () {},
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTitle({
    required Widget title,
    Widget? more,
    void Function()? onMore,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.w),
      child: Row(
        children: [
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                fontSize: 20.w,
                fontWeight: FontWeight.w600,
              ),
              child: title,
            ),
          ),
          if (more != null)
            CustomButton(
              type: CustomButtonType.borderless,
              padding: const EdgeInsets.all(0),
              onPressed: onMore,
              child: more,
            ),
        ],
      ),
    );
  }
}

class _BottomSheetWithPicker extends StatelessWidget {
  final PickerAdapter adapter;
  final List<PickerDelimiter>? delimiters;

  const _BottomSheetWithPicker({
    required this.adapter,
    this.delimiters,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: 19.w,
      height: 1.2,
      fontWeight: FontWeight.w600,
      color: Theme.of(context).colorScheme.onSurface,
    );
    return DefaultTextStyle.merge(
      style: textStyle,
      child: Picker(
        adapter: adapter,
        itemExtent: 40.w,
        height: 270.w,
        backgroundColor: Colors.transparent,
        containerColor: Colors.transparent,
        hideHeader: true,
        textStyle: textStyle,
        delimiter: delimiters,
      ).makePicker(),
    );
  }
}
