part of '../index.dart';

class BuildMessage extends StatelessWidget {
  final bool isSelf;
  final String? text;

  const BuildMessage({
    super.key,
    this.isSelf = false,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      top: false,
      bottom: false,
      minimum: EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: 8.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        textDirection: isSelf ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Flexible(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.w)),
                color: colorScheme.tertiary,
                gradient: isSelf
                    ? LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.alphaBlend(
                            colorScheme.primary.withOpacity(0.85),
                            Colors.white,
                          ),
                          colorScheme.primary,
                        ],
                      )
                    : null,
              ),
              constraints: BoxConstraints(
                minWidth: 40.w,
                minHeight: 40.w,
              ),
              child: DefaultTextStyle.merge(
                style: TextStyle(
                  height: 1.2,
                  fontSize: 17.w,
                  color:
                      isSelf ? colorScheme.onTertiary : colorScheme.onSurface,
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15.w,
                    vertical: 10.4.w,
                  ),
                  child: Text(text ?? ''),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            width: 24.w,
            /*child: Icon(
              Icons.info_rounded,
              size: 24.w,
              color: AppTheme.error,
            ),*/
          ),
        ],
      ),
    );
  }
}
