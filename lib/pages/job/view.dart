part of 'index.dart';

class JobPage extends StatelessWidget {
  const JobPage({super.key});

  List<Tab> get _tabs {
    final items = <Tab>[];
    items.add(const Tab(text: 'All Job'));
    for (var element in ConfigStore.to.categories) {
      items.add(Tab(text: element.name));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(right: AppTheme.margin),
          child: CustomInputSearch(
            readOnly: true,
            onTap: () => context.pushNamed(Routes.jobSearch),
          ),
        ),
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
                  return const _BuildJobList();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildJobList extends StatefulWidget {
  const _BuildJobList();

  @override
  _BuildJobListState createState() => _BuildJobListState();
}

class _BuildJobListState extends State<_BuildJobList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListScrollView(
      minimum: const EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
      ),
      builder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: CustomCard.job(
            image: 'https://api.multiavatar.com/Binx Bond.png',
            title: const Text('UI/UX Designer'),
            subtitle: const Text('AirBNB'),
            label: const Text('United States - Full Time'),
            salary: Text(Convert.toAmount('2350')),
            isCollect: true,
            onTap: () => context.pushNamed(Routes.jobDetail),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
