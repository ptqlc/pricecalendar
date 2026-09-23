part of '../index.dart';

class BuildTitle extends StatelessWidget {
  final Widget title;
  final Widget? more;
  final void Function()? onMore;

  const BuildTitle({
    super.key,
    required this.title,
    this.more,
    this.onMore,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: 20.w,
      ).copyWith(top: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
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
              child: more!,
            ),
        ],
      ),
    );
  }
}
