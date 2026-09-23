part of 'index.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = BottomNavigationBarTheme.of(context);
    return CustomBottomAppBar(
      child: DefaultTextStyle.merge(
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: theme.unselectedLabelStyle,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(items.length, (index) {
                return _BottomNavigationTile(
                  theme: theme,
                  data: items[index],
                  isSelected: currentIndex == index,
                  onTap: onTap != null ? () => onTap!(index) : null,
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

class _BottomNavigationTile extends StatelessWidget {
  final BottomNavigationBarItem data;
  final bool isSelected;
  final BottomNavigationBarThemeData theme;
  final void Function()? onTap;

  const _BottomNavigationTile({
    required this.data,
    required this.theme,
    this.isSelected = false,
    this.onTap,
  });

  IconThemeData get iconTheme =>
      theme.unselectedIconTheme ?? const IconThemeData();

  double get _extensionWidth {
    final textPainter = TextPainter(
      text: TextSpan(text: data.label, style: theme.unselectedLabelStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: 160.w);
    return textPainter.width + (iconTheme.size ?? 0) + 32.w + 12.w;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isSelected ? _extensionWidth : (iconTheme.size ?? 0) + 32.w,
        height: 46.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
          color:
              isSelected ? theme.selectedItemColor : theme.unselectedItemColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconTheme(data: iconTheme, child: data.icon),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text(data.label ?? ''),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
