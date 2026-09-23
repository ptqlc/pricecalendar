part of '../index.dart';

class BuildCategory extends StatelessWidget {
  final List<CategoryModel> items;
  final void Function(int? value)? onTap;

  const BuildCategory({
    super.key,
    this.items = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.w),
      height: 38.w,
      child: ListView.builder(
        padding: const EdgeInsets.only(right: AppTheme.margin),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: index == 0 ? AppTheme.margin : 12.w,
          ),
          child: CustomButton(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            type: index == 0 ? CustomButtonType.filled : CustomButtonType.ghost,
            shape: CustomButtonShape.stadium,
            child: index == 0
                ? const Text('All Job')
                : Text(items[index - 1].name ?? ''),
            onPressed: () {
              if (index != 0) onTap?.call(items[index - 1].value);
            },
          ),
        ),
        itemCount: items.length + 1,
      ),
    );
  }
}
