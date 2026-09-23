part of 'index.dart';

class JobCollectPage extends StatelessWidget {
  const JobCollectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Saved Jobs'),
      ),
      body: CustomListScrollView(
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
      ),
    );
  }
}
