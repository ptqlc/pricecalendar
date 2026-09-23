part of 'index.dart';

class VacancyGeekPage extends StatefulWidget {
  const VacancyGeekPage({super.key});

  @override
  State<VacancyGeekPage> createState() => _VacancyGeekPageState();
}

class _VacancyGeekPageState extends State<VacancyGeekPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VacancyGeekController>(
      init: VacancyGeekController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: CustomAppBar(
            title: const Text('Applicants'),
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SafeArea(
              minimum: const EdgeInsets.all(AppTheme.margin),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomCard.chat(
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
                      ],
                    ),
                    SizedBox(height: 30.w),
                    CustomFormInput(
                      label: 'Mark Status as',
                      required: true,
                      readOnly: true,
                      controller: controller.markInput,
                      iconData: Ionicons.chevron_down,
                      onTap: () async {
                        final result =
                            await CustomBottomSheet.showSelect<String>(
                          context: context,
                          title: const Text('Mark Status as'),
                          value: controller.mark,
                          items: [
                            'Accepted',
                            'Schedule to Interview',
                            'Rejected',
                          ],
                          builder: (value) => Text(value),
                        );
                        if (result == null) return;
                        controller.changeMark(result);
                      },
                    ),
                    SizedBox(height: 20.w),
                    CustomFormInput(
                      label: 'Datetime',
                      required: true,
                      readOnly: true,
                      iconData: Ionicons.time,
                      controller: controller.dateInput,
                      onTap: () async {
                        final result = await CustomBottomSheet.showDateTime(
                          context: context,
                          title: const Text('Datetime'),
                          value: Date.fromStr(controller.dateInput.value.text),
                          minValue: DateTime.now(),
                          maxValue: DateTime(2099, 1, 1),
                        );
                        if (result == null) return;
                        controller.changeDate(result);
                      },
                    ),
                    SizedBox(height: 20.w),
                    CustomFormInput(
                      label: 'Message',
                      required: true,
                      maxLines: 5,
                      controller: controller.messageInput,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomAppBar.operate(
            text: const Text('Send to Applicants'),
            onPressed: () async {
              if (_formKey.currentState?.validate() != true) return;
              await CustomDialog.show(
                context: context,
                builder: (context) => const CustomEmpty(
                  icon: Icon(Icons.check_circle_rounded),
                  title: Text('Successful!'),
                  label: Text('Notifications have been sent to applicants.'),
                ),
                confirm: const Text('OK'),
                onConfirm: Navigator.of(context).pop,
              );
              if (context.mounted) context.pop();
            },
          ),
        ),
      ),
    );
  }
}
