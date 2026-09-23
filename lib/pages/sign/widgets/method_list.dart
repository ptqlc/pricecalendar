part of '../index.dart';

class BuildMethodItem {
  final Widget text;
  final String icon;
  final void Function()? onTap;

  BuildMethodItem({
    required this.text,
    required this.icon,
    this.onTap,
  });
}

class BuildMethodList extends StatelessWidget {
  final List<BuildMethodItem> items;

  const BuildMethodList({
    super.key,
    this.items = const [],
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Wrap(
        runSpacing: 20.w,
        spacing: 20.w,
        children: items.map((item) => IconTheme.merge(
          data: IconThemeData(size: 24.w),
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17.w,
            ),
            child: CustomCard(
              onTap: item.onTap,
              width: constraints.maxWidth / 2 - 10.w,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 16.w),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      item.icon,
                      width: 22.w,
                      height: 22.w,
                    ),
                    SizedBox(width: 12.w),
                    item.text,
                  ],
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}
