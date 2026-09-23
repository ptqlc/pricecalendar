part of '../index.dart';

class BuildLayout extends StatelessWidget {
  final RefreshController? refreshController;
  final void Function()? onRefresh;
  final void Function()? onLoading;
  final Widget? action;
  final List<Widget> children;
  final int? itemCount;
  final NullableIndexedWidgetBuilder itemBuilder;

  const BuildLayout({
    super.key,
    required this.itemBuilder,
    this.action,
    this.children = const [],
    this.itemCount,
    this.refreshController,
    this.onRefresh,
    this.onLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (action != null)
          SafeArea(
            top: false,
            bottom: false,
            minimum: EdgeInsets.symmetric(
              horizontal: AppTheme.margin,
              vertical: 10.w,
            ),
            child: action!,
          ),
        Expanded(
          child: CustomListScrollView(
            refreshController: refreshController,
            onRefresh: onRefresh,
            onLoading: onLoading,
            minimum: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
            slivers: [
              SliverSafeArea(
                top: false,
                bottom: false,
                minimum: EdgeInsets.only(top: 10.w),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: children,
                  ),
                ),
              ),
            ],
            builder: (context, index) => Padding(
              padding: EdgeInsets.only(top: index == 0 ? 0 : 20.w),
              child: itemBuilder.call(context, index),
            ),
            childCount: itemCount,
          ),
        ),
      ],
    );
  }
}
