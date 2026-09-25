part of 'index.dart';

class CustomRequirementGroup extends StatelessWidget {
  final List<Widget> children;
  final bool showClear;
  final ValueChanged<int>? onClear;

  const CustomRequirementGroup({
    super.key,
    this.children = const [],
    this.showClear = false,
    this.onClear,
  });

  static Widget editor({
    Key? key,
    required IndexedWidgetBuilder builder,
    List<String> items = const [],
    ValueChanged<List<String>>? onChanged,
  }) {
    return _RequirementGroupWithEditor(
      key: key,
      items: items,
      builder: builder,
      onChanged: onChanged,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(children.length, (index) {
        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? 0 : 8.w),
          child: CustomRequirement(
            text: children[index],
            showClear: showClear,
            onClear: () => onClear?.call(index),
          ),
        );
      }),
    );
  }
}

class _RequirementGroupWithEditor extends StatefulWidget {
  final List<String> items;
  final IndexedWidgetBuilder builder;
  final ValueChanged<List<String>>? onChanged;

  const _RequirementGroupWithEditor({
    super.key,
    this.items = const [],
    required this.builder,
    this.onChanged,
  });

  @override
  _RequirementGroupWithEditorState createState() =>
      _RequirementGroupWithEditorState();
}

class _RequirementGroupWithEditorState
    extends State<_RequirementGroupWithEditor> {
  List<String> _items = [];

  @override
  void initState() {
    super.initState();
    _items = [...widget.items];
  }

  @override
  void didUpdateWidget(covariant _RequirementGroupWithEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    _items = [...widget.items];
  }

  void _onClear(int index) {
    setState(() {
      _items.removeAt(index);
    });
    widget.onChanged?.call(_items);
  }

  void _onInsert(String? value) {
    if ((value ?? '').isEmpty) return;
    setState(() {
      _items.add(value!);
    });
    widget.onChanged?.call(_items);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomRequirementGroup(
          showClear: true,
          onClear: _onClear,
          children: List.generate(_items.length, (index) {
            return widget.builder(context, index);
          }),
        ),
        SizedBox(height: 15.w),
        CustomButton(
          backgroundColor: colorScheme.primary.withValues(alpha: 0.1),
          foregroundColor: colorScheme.primary,
          shape: CustomButtonShape.stadium,
          size: CustomButtonSize.large,
          child: const Text('Add New Requirement'),
          onPressed: () async {
            var text = '';
            final result = await CustomBottomSheet.show<String>(
              context: context,
              title: const Text('Requirement'),
              confirm: const Text('Confirm'),
              cancel: const Text('Cancel'),
              builder: (context) => CustomInput(
                maxLines: 5,
                autofocus: true,
                onChanged: (value) => text = value,
              ),
              onConfirm: () => Navigator.of(context).pop(text),
              onCancel: () => Navigator.of(context).pop(),
            );
            _onInsert(result);
          },
        ),
      ],
    );
  }
}

class CustomRequirement extends StatelessWidget {
  final Widget text;
  final bool showClear;
  final VoidCallback? onClear;

  const CustomRequirement({
    super.key,
    required this.text,
    this.showClear = false,
    this.onClear,
  });

  EdgeInsets get _padding => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.w,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.all(Radius.circular(12.w)),
      ),
      child: Row(
        children: [
          Padding(
            padding: _padding,
            child: Icon(
              Icons.check_circle_outline_rounded,
              size: 24.w,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Expanded(
            child: DefaultTextStyle.merge(
              style: TextStyle(fontSize: 16.w),
              child: Padding(
                padding: _padding.copyWith(left: 0),
                child: text,
              ),
            ),
          ),
          if (showClear)
            CustomButton.icon(
              width: 24.w + _padding.horizontal,
              height: 24.w + _padding.vertical,
              padding: _padding,
              backgroundColor: Colors.transparent,
              foregroundColor: AppTheme.error,
              icon: const Icon(Icons.clear_rounded),
              onPressed: onClear,
            ),
        ],
      ),
    );
  }
}
