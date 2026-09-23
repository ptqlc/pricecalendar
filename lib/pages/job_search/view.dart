part of 'index.dart';

class JobSearchPage extends StatelessWidget {
  const JobSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        appBar: CustomAppBar(
          titleSpacing: 0,
          title: const Padding(
            padding: EdgeInsets.only(right: AppTheme.margin),
            child: CustomInputSearch(),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const BuildTotal(),
            Expanded(
              child: CustomListScrollView(
                minimum: const EdgeInsets.symmetric(
                  horizontal: AppTheme.margin,
                ),
                childCount: 10,
                builder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: CustomCard.job(
                    image: 'https://api.multiavatar.com/Binx Bond.png',
                    title: const Text('UI/UX Designer'),
                    subtitle: const Text('AirBNB'),
                    label: const Text('United States - Full Time'),
                    salary: Text(Convert.toAmount('2350')),
                    isCollect: index == 1,
                    onTap: () => context.pushNamed(Routes.jobDetail),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
