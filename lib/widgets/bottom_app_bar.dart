part of 'index.dart';

class CustomBottomAppBar extends StatelessWidget {
  final Widget child;

  const CustomBottomAppBar({
    super.key,
    required this.child,
  });

  factory CustomBottomAppBar.operate({
    required Widget text,
    List<Widget> actions,
    void Function()? onPressed,
  }) = _BottomAppBarWithOperate;

  EdgeInsets get _padding {
    return EdgeInsets.symmetric(
      horizontal: AppTheme.margin,
      vertical: 10.w,
    ).copyWith(bottom: Screen.bottomBar > 0 ? 0 : null);
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Padding(
        padding: _padding.add(EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        )),
        child: child,
      ),
    );
  }
}

class _BottomAppBarWithOperate extends CustomBottomAppBar {
  final Widget text;
  final List<Widget> actions;
  final void Function()? onPressed;

  _BottomAppBarWithOperate({
    required this.text,
    this.onPressed,
    this.actions = const [],
  }) : super(
          child: _BottomAppBarWithOperateChild(
            text: text,
            actions: actions,
            onPressed: onPressed,
          ),
        );
}

class _BottomAppBarWithOperateChild extends StatelessWidget {
  final Widget text;
  final List<Widget> actions;
  final void Function()? onPressed;

  const _BottomAppBarWithOperateChild({
    required this.text,
    this.actions = const [],
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final ws = <Widget>[];
    for (var index = 0; index < actions.length; index++) {
      ws.add(actions[index]);
      ws.add(SizedBox(width: 10.w));
    }
    return Row(
      children: [
        ...ws,
        Expanded(
          child: CustomButton(
            shape: CustomButtonShape.stadium,
            size: CustomButtonSize.large,
            onPressed: onPressed,
            child: text,
          ),
        ),
      ],
    );
  }
}
