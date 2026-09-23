part of 'index.dart';

enum CustomAlertSize { normal, mini }

class CustomAlert extends StatelessWidget {
  final Widget icon;
  final Widget text;
  final CustomAlertSize size;
  final Color? color;

  const CustomAlert({
    super.key,
    required this.icon,
    required this.text,
    this.color,
    this.size = CustomAlertSize.normal,
  });

  const factory CustomAlert.error({
    required Widget text,
    CustomAlertSize size,
  }) = _AlertWithError;

  const factory CustomAlert.success({
    required Widget text,
    CustomAlertSize size,
  }) = _AlertWithSuccess;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = color ?? Theme.of(context).colorScheme.onSurface;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size == CustomAlertSize.mini ? 10.w : 16.w,
        vertical: size == CustomAlertSize.mini ? 5.w : 10.w,
      ),
      decoration: ShapeDecoration(
        color: backgroundColor.withOpacity(0.1),
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconTheme(
            data: IconThemeData(
              size: size == CustomAlertSize.mini ? 18.w : 24.w,
              color: backgroundColor,
            ),
            child: icon,
          ),
          SizedBox(width: size == CustomAlertSize.mini ? 6.w : 10.w),
          Flexible(
            child: DefaultTextStyle.merge(
              style: TextStyle(
                fontSize: size == CustomAlertSize.mini ? 15.w : 17.w,
                color: backgroundColor,
              ),
              child: text,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlertWithError extends CustomAlert {
  const _AlertWithError({
    required super.text,
    super.size,
  }) : super(
          icon: const Icon(Icons.error_rounded),
          color: AppTheme.error,
        );
}

class _AlertWithSuccess extends CustomAlert {
  const _AlertWithSuccess({
    required super.text,
    super.size,
  }) : super(
          icon: const Icon(Icons.check_circle_rounded),
          color: AppTheme.success,
        );
}
