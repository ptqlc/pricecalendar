part of 'index.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  State<ApplicationPage> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with AutomaticKeepAliveClientMixin {
  final List<String> _bossTag = ['All', 'Active', 'Inactive'];
  final List<String> _geekTag = ['All', 'Accepted', 'Interview', 'Rejected'];

  List<Tab> get _tabs {
    if (ConfigStore.to.isBossMode) {
      return _bossTag.map<Tab>((item) => Tab(text: item)).toList();
    }
    return _geekTag.map<Tab>((item) => Tab(text: item)).toList();
  }

  Widget get _action {
    if (ConfigStore.to.isBossMode) {
      return CustomButton.icon(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        icon: const Icon(Ionicons.add_circle),
        onPressed: () => context.pushNamed(Routes.vacancyEdit),
      );
    }
    return CustomButton.icon(
      padding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      icon: const Icon(Ionicons.bookmark),
      onPressed: () => context.pushNamed(Routes.jobCollect),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Applications'),
        actions: [_action],
      ),
      body: DefaultTabController(
        length: _tabs.length,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: CustomTabBar(tabs: _tabs),
            ),
            Expanded(
              child: TabBarView(
                children: List.generate(_tabs.length, (index) {
                  if (ConfigStore.to.isBossMode) {
                    return _BuildBossApplicationList(_bossTag[index]);
                  }
                  return _BuildGeekApplicationList(_geekTag[index]);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _BuildBossApplicationList extends StatefulWidget {
  final String tag;

  const _BuildBossApplicationList(this.tag);

  @override
  _BuildBossApplicationListState createState() =>
      _BuildBossApplicationListState();
}

class _BuildBossApplicationListState extends State<_BuildBossApplicationList>
    with AutomaticKeepAliveClientMixin {
  String _getStatus(int index) {
    if (widget.tag != 'All') return widget.tag;
    if (index == 0 || index == 1) return 'Active';
    return 'Inactive';
  }

  Color _getColor(String value) {
    if (value == 'Active') return AppTheme.success;
    return AppTheme.error;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ApplicationController>(
      tag: widget.tag,
      init: ApplicationController(),
      builder: (controller) => CustomListScrollView(
        refreshController: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        minimum: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
        builder: (context, index) {
          final status = _getStatus(index);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: CustomCard.job(
              image: 'https://api.multiavatar.com/Binx Bond.png',
              title: const Text('Financial Planner'),
              subtitle: const Text('AirBNB'),
              label: const Text('Algeria - Contract'),
              salary: Text(Convert.toAmount('2350')),
              tag: Text(status, style: TextStyle(color: _getColor(status))),
              onTap: () => context.pushNamed(Routes.vacancyDetail),
            ),
          );
        },
        childCount: controller.list.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _BuildGeekApplicationList extends StatefulWidget {
  final String tag;

  const _BuildGeekApplicationList(this.tag);

  @override
  _BuildGeekApplicationListState createState() =>
      _BuildGeekApplicationListState();
}

class _BuildGeekApplicationListState extends State<_BuildGeekApplicationList>
    with AutomaticKeepAliveClientMixin {
  String _getStatus(int index) {
    if (widget.tag != 'All') return widget.tag;
    if (index == 0) return 'Interview';
    if (index == 1) return 'Accepted';
    return 'Rejected';
  }

  Color _getColor(String value) {
    if (value == 'Interview') return AppTheme.primary;
    if (value == 'Accepted') return AppTheme.success;
    return AppTheme.error;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ApplicationController>(
      tag: widget.tag,
      init: ApplicationController(),
      builder: (controller) => CustomListScrollView(
        refreshController: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        minimum: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
        builder: (context, index) {
          final status = _getStatus(index);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.w),
            child: CustomCard.job(
              image: 'https://api.multiavatar.com/Binx Bond.png',
              title: const Text('UI/UX Designer'),
              subtitle: const Text('AirBNB'),
              bottom: CustomTag(
                text: Text(status),
                color: _getColor(status),
              ),
              onTap: () => context.pushNamed(Routes.applyDetail),
            ),
          );
        },
        childCount: controller.list.length,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
