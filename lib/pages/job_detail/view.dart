part of 'index.dart';

class JobDetailPage extends StatelessWidget {
  const JobDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Job Details'),
        actions: [
          CustomButton.icon(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            foregroundColor: AppTheme.warning,
            icon: const Icon(Ionicons.remove_circle_outline),
            onPressed: () {
              CustomDialog.show(
                context: context,
                builder: (context) => const Text('Report this job？'),
                confirm: const Text('Report'),
                cancel: const Text('Cancel'),
                onConfirm: () => Navigator.of(context).pop(),
                onCancel: () => Navigator.of(context).pop(),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.all(AppTheme.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomCard.job(
                image: 'https://api.multiavatar.com/Binx Bond.png',
                title: const Text('UI/UX Designer'),
                subtitle: const Text('AirBNB'),
              ),
              SizedBox(height: 30.w),
              CustomCell.simple(
                padding: EdgeInsets.symmetric(vertical: 6.w).copyWith(
                  top: 0,
                ),
                title: const Text('Salary'),
                value: Text(Convert.toAmount('2350')),
              ),
              CustomCell.simple(
                padding: EdgeInsets.symmetric(vertical: 6.w),
                title: const Text('Type'),
                value: const Text('Full Time'),
              ),
              CustomCell.simple(
                padding: EdgeInsets.symmetric(vertical: 6.w).copyWith(
                  bottom: 0,
                ),
                title: const Text('Location'),
                value: const Text('United States'),
              ),
              Divider(height: 48.w),
              Text(
                'Requirements',
                style: TextStyle(
                  fontSize: 20.w,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.w),
              const CustomRequirementGroup(
                children: [
                  Text('Experienced in Figma or Sketch.'),
                  Text('Able to work in large or small team.'),
                  Text(
                      'At least 1 year of working experience in agency, freelance, or start-up.'),
                  Text('Able to keep up with the latest trends.'),
                  Text('Have relevant experience for at least 3 years.'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar.operate(
        text: const Text('Apply Now'),
        actions: [
          CustomButton.icon(
            icon: const Icon(Ionicons.bookmark),
            onPressed: () {},
          ),
        ],
        onPressed: () {},
      ),
    );
  }
}
