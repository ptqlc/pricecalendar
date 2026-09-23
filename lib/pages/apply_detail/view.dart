part of 'index.dart';

class ApplyDetailPage extends StatelessWidget {
  const ApplyDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: const Text('Applications'),
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
                value: const Text('\$2.350'),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar.operate(
        text: const Text('Discover another job'),
        onPressed: () {},
      ),
    );
  }
}
