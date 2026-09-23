part of 'index.dart';

class RolePage extends StatelessWidget {
  const RolePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<RoleController>(
      init: RoleController(),
      builder: (controller) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          systemOverlayStyle: Theme.of(context).brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(
                child: Center(
                  child: CustomEmpty(
                    icon: CustomImage.asset(
                      url: 'assets/images/logo.png',
                      fit: BoxFit.contain,
                    ),
                    title: Text('Find Job'),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.w),
                    topRight: Radius.circular(30.w),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.shadow,
                      offset: Offset(0, -30.w),
                      blurRadius: 15.w,
                      spreadRadius: -15.w,
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  minimum: const EdgeInsets.all(AppTheme.margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 15.w),
                      Icon(
                        Icons.person_pin_rounded,
                        size: 48.w,
                        color: AppTheme.primary,
                      ),
                      SizedBox(height: 20.w),
                      const Text(
                        'What are you looking for?',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 32.w),
                      CustomRadioGroup<String>(
                        items: controller.roleTypeList,
                        value: controller.roleType,
                        rowCount: 2,
                        showIcon: false,
                        builder: (index, isSelected) {
                          final item = controller.roleTypeList[index];
                          final color = isSelected ? colorScheme.primary : null;
                          switch (item) {
                            case C.roleBoss:
                              return CustomCard.icon(
                                borderColor: color,
                                icon: const Icon(Ionicons.person),
                                text: const Text('I want an employee'),
                              );
                            default:
                              return CustomCard.icon(
                                borderColor: color,
                                icon: const Icon(Ionicons.briefcase),
                                text: const Text('I want a job'),
                              );
                          }
                        },
                        onChanged: controller.onChanged,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomAppBar.operate(
          text: const Text('Next'),
          onPressed: () => controller.onSubmit(context),
        ),
      ),
    );
  }
}
