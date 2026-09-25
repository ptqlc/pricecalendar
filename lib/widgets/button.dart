part of 'index.dart';

enum CustomButtonType { filled, ghost, borderless }

enum CustomButtonSize { large, medium, small }

enum CustomButtonShape { radius, stadium }

class CustomButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final CustomButtonType type;
  final CustomButtonSize size;
  final CustomButtonShape shape;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool isIcon;

  const CustomButton({
    super.key,
    required this.child,
    this.onPressed,
    this.foregroundColor,
    this.backgroundColor,
    this.type = CustomButtonType.filled,
    this.size = CustomButtonSize.medium,
    this.shape = CustomButtonShape.radius,
    this.width,
    this.height,
    this.padding,
    this.isIcon = false,
  });

  factory CustomButton.icon({
    Key? key,
    required Icon icon,
    void Function()? onPressed,
    Color? foregroundColor,
    Color? backgroundColor,
    CustomButtonShape shape,
    CustomButtonSize size,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
  }) = _ButtonWithIcon;

  OutlinedBorder? get _shape {
    switch (shape) {
      case CustomButtonShape.stadium:
        return const StadiumBorder();
      case CustomButtonShape.radius:
        return RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.w),
        );
    }
  }

  EdgeInsetsGeometry? get _padding {
    switch (size) {
      case CustomButtonSize.large:
        return EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.w);
      case CustomButtonSize.medium:
        return EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.w);
      case CustomButtonSize.small:
        return EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.w);
    }
  }

  double? get _fontSize {
    switch (size) {
      case CustomButtonSize.large:
        return 18.w;
      case CustomButtonSize.medium:
        return 16.w;
      case CustomButtonSize.small:
        return 14.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(
            Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontSize: _fontSize),
          ),
          padding: WidgetStateProperty.all(padding ?? _padding),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            switch (type) {
              case CustomButtonType.filled:
                return foregroundColor ??
                    (isIcon ? colorScheme.primary : colorScheme.onPrimary);
              case CustomButtonType.ghost:
              case CustomButtonType.borderless:
                final color = foregroundColor ?? colorScheme.primary;
                final opacity = color.a / 2;
                if (states.contains(WidgetState.pressed)) {
                  return color.withValues(alpha: opacity);
                }
                if (states.contains(WidgetState.disabled)) {
                  return color.withValues(alpha: opacity);
                }
                return color;
            }
          }),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            switch (type) {
              case CustomButtonType.filled:
                final color = backgroundColor ??
                    colorScheme.primary.withValues(alpha: isIcon ? 0.1 : 1);
                final opacity = color.a / 2;
                if (states.contains(WidgetState.pressed)) {
                  return color.withValues(alpha: opacity);
                }
                if (states.contains(WidgetState.disabled)) {
                  return color.withValues(alpha: opacity);
                }
                return color;
              case CustomButtonType.ghost:
              case CustomButtonType.borderless:
                return Colors.transparent;
            }
          }),
          side: WidgetStateProperty.resolveWith((states) {
            switch (type) {
              case CustomButtonType.filled:
              case CustomButtonType.borderless:
                return BorderSide.none;
              case CustomButtonType.ghost:
                final color = foregroundColor ?? colorScheme.primary;
                final opacity = color.a / 2;
                if (states.contains(WidgetState.pressed)) {
                  return BorderSide(
                    color: color.withValues(alpha: opacity),
                    width: 2.w,
                  );
                }
                if (states.contains(WidgetState.disabled)) {
                  return BorderSide(color: color.withValues(alpha: opacity));
                }
                return BorderSide(
                  color: color,
                  width: 2.w,
                );
            }
          }),
          shape: WidgetStateProperty.all(_shape),
        ),
        child: child,
      ),
    );
  }
}

class _ButtonWithIcon extends CustomButton {
  final Icon icon;

  _ButtonWithIcon({
    super.key,
    required this.icon,
    super.onPressed,
    super.foregroundColor,
    Color? backgroundColor,
    super.size,
    super.shape,
    super.width,
    super.height,
    EdgeInsetsGeometry? padding,
  }) : super(
          child: _ButtonWithIconChild(
            icon: icon,
            size: size,
            padding: padding,
          ),
          backgroundColor:
              backgroundColor ?? foregroundColor?.withValues(alpha: 0.1),
          isIcon: true,
          padding: padding ?? const EdgeInsets.all(0),
        );
}

class _ButtonWithIconChild extends StatelessWidget {
  final Icon icon;
  final CustomButtonSize size;
  final EdgeInsetsGeometry? padding;

  const _ButtonWithIconChild({
    required this.icon,
    required this.size,
    this.padding,
  });

  double? get _iconSize {
    switch (size) {
      case CustomButtonSize.large:
        return 30.w;
      case CustomButtonSize.medium:
        return 24.w;
      case CustomButtonSize.small:
        return 18.w;
    }
  }

  double get _padding {
    switch (size) {
      case CustomButtonSize.large:
        return 12.w;
      case CustomButtonSize.medium:
        return 10.w;
      case CustomButtonSize.small:
        return 8.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding == null ? EdgeInsets.all(_padding) : const EdgeInsets.all(0),
      child: IconTheme.merge(
        data: IconThemeData(size: _iconSize),
        child: icon,
      ),
    );
  }
}
