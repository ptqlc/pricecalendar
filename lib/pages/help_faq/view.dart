part of 'index.dart';

class HelpFAQPage extends StatelessWidget {
  const HelpFAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('FAQ'),
      ),
      body: DefaultTabController(
        length: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.w),
              child: const CustomTabBar(
                tabs: [
                  Tab(text: 'General'),
                  Tab(text: 'Login'),
                  Tab(text: 'Account'),
                  Tab(text: 'Tips'),
                ],
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  _BuildHelpFAQList(),
                  _BuildHelpFAQList(),
                  _BuildHelpFAQList(),
                  _BuildHelpFAQList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildHelpFAQList extends StatefulWidget {
  const _BuildHelpFAQList();

  @override
  _BuildHelpFAQListState createState() => _BuildHelpFAQListState();
}

class _BuildHelpFAQListState extends State<_BuildHelpFAQList>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CustomListScrollView(
      minimum: const EdgeInsets.symmetric(horizontal: AppTheme.margin),
      builder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: const CustomExpansionTile(
            title: Text('What is Gawean?'),
            child: Text('What is Gawean?'),
          ),
        );
      },
      childCount: 20,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
