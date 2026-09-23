part of 'index.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        late final NullableIndexedWidgetBuilder itemBuilder;
        final children = <Widget>[];
        final itemCount = controller.list.length;
        children.add(const BuildBanner(
          items: [AppTheme.primary,AppTheme.error,AppTheme.success],
        ));
        if (ConfigStore.to.isBossMode) {
          children.add(const BuildTitle(
            title: Text('Recent People Applied'),
          ));
          itemBuilder = (context, index) {
            return CustomCard.chat(
              avatar: 'https://api.multiavatar.com/Binx Bond.png',
              nickname: const Text('John Jobs'),
              label: const Text('software development'),
              operate: [
                CustomButton(
                  shape: CustomButtonShape.stadium,
                  size: CustomButtonSize.small,
                  child: const Text('See Resume'),
                  onPressed: () => context.pushNamed(Routes.vacancyResume),
                ),
                CustomButton(
                  type: CustomButtonType.ghost,
                  shape: CustomButtonShape.stadium,
                  size: CustomButtonSize.small,
                  child: const Text('See Details'),
                  onPressed: () => context.pushNamed(Routes.vacancyGeek),
                ),
              ],
            );
          };
        } else {
          children.add(BuildTitle(
            title: const Text('Job Recommendation'),
            more: const Text('See all'),
            onMore: () => context.pushNamed(Routes.job),
          ));
          itemBuilder = (context, index) {
            final isCollect = index == 0 || index == 4;
            return CustomCard.job(
              image: 'https://api.multiavatar.com/Binx Bond.png',
              title: const Text('UI/UX Designer'),
              subtitle: const Text('AirBNB'),
              label: const Text('United States - Full Time'),
              salary: Text(Convert.toAmount('2350')),
              isCollect: isCollect,
              onTap: () => context.pushNamed(Routes.jobDetail),
            );
          };
        }
        return Scaffold(
          appBar: CustomAppBar(
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
              child: CustomInputSearch(
                readOnly: true,
                onTap: () => context.pushNamed(Routes.jobSearch),
              ),
            ),
            actions: [
              CustomButton.icon(
                padding: EdgeInsets.zero,
                backgroundColor: Colors.transparent,
                icon: const Icon(Ionicons.notifications),
                onPressed: () => context.pushNamed(Routes.notice),
              ),
            ],
          ),
          body: BuildLayout(
            refreshController: controller.refreshController,
            onRefresh: controller.onRefresh,
            onLoading: controller.onLoading,
            itemBuilder: itemBuilder,
            itemCount: itemCount,
            children: children,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
