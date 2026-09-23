part of 'index.dart';

class VacancyDetailPage extends StatelessWidget {
  const VacancyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Vacancy'),
      ),
      body: SafeArea(
        bottom: false,
        minimum: const EdgeInsets.all(AppTheme.margin).copyWith(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomCard.job(
              image: 'https://api.multiavatar.com/Binx Bond.png',
              title: const Text('UI/UX Designer'),
              subtitle: const Text('AirBNB'),
              label: const Text('Algeria - Contract'),
              salary: Text(Convert.toAmount('2350')),
              tag: const Text(
                'Active',
                style: TextStyle(color: AppTheme.success),
              ),
            ),
            SizedBox(height: 20.w),
            Text(
              'Applicants',
              style: TextStyle(
                fontSize: 20.w,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.w),
            Expanded(
              child: CustomListScrollView(
                childCount: 10,
                builder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: CustomCard.chat(
                      avatar: 'https://api.multiavatar.com/Binx Bond.png',
                      nickname: const Text('Lee'),
                      label: const Text('UI/UX Designer'),
                      actions: [
                        CustomButton.icon(
                          shape: CustomButtonShape.stadium,
                          icon: const Icon(Ionicons.chatbubble),
                          onPressed: () => context.pushNamed(
                            Routes.conversation,
                          ),
                        ),
                        CustomButton.icon(
                          shape: CustomButtonShape.stadium,
                          icon: const Icon(Ionicons.call),
                          onPressed: () => context.pushNamed(Routes.call),
                        ),
                      ],
                      operate: [
                        CustomButton(
                          shape: CustomButtonShape.stadium,
                          size: CustomButtonSize.small,
                          child: const Text('See Resume'),
                          onPressed: () => context.pushNamed(
                            Routes.vacancyResume,
                          ),
                        ),
                        CustomButton(
                          type: CustomButtonType.ghost,
                          shape: CustomButtonShape.stadium,
                          size: CustomButtonSize.small,
                          child: const Text('See Details'),
                          onPressed: () => context.pushNamed(
                            Routes.vacancyGeek,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
