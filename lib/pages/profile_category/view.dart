part of 'index.dart';

class ProfileCategoryPage extends StatelessWidget {
  const ProfileCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<ProfileCategoryController>(
      init: ProfileCategoryController(),
      builder: (controller) => Scaffold(
        appBar: CustomAppBar(
          title: const Text('What job you want?'),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            minimum: const EdgeInsets.all(AppTheme.margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Choose 1-5 job categories and we’ll optimize the job vacancy for you.',
                ),
                SizedBox(height: 15.w),
                CustomCheckboxGroup<CategoryModel>(
                  items: controller.categories,
                  values: controller.selected,
                  maxCount: 5,
                  rowCount: 2,
                  showIcon: false,
                  builder: (int index, bool isSelected) {
                    final item = controller.categories[index];
                    return CustomCard.icon(
                      borderColor: isSelected ? colorScheme.primary : null,
                      icon: Icon(item.icon ?? Ionicons.information),
                      text: item.name != null ? Text(item.name!) : null,
                    );
                  },
                  onChanged: controller.changedCategories,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomAppBar.operate(
          text: const Text('Next'),
          onPressed: () {
            if (controller.selected.isEmpty) {
              CustomToast.text('Select at least 1 categories');
              return;
            }
            context.pushNamed(
              Routes.profileEdit,
              queryParameters: {'roleType': C.roleGeek},
            );
          },
        ),
      ),
    );
  }
}
