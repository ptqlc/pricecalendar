part of 'index.dart';

class ProfileEditPage extends StatefulWidget {
  final String roleType;

  const ProfileEditPage({
    super.key,
    required this.roleType,
  });

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileEditController>(
      init: ProfileEditController(roleType: widget.roleType),
      builder: (controller) {
        final ws = <Widget>[];
        if (controller.roleType == C.roleBoss) {
          ws.addAll([
            CustomAvatar.upload(
              url: controller.image,
              shape: CustomAvatarShape.radius,
              beforeChild: CustomCard.icon(
                icon: const Icon(Ionicons.cloud_upload),
                text: const Text('Upload Company Logo'),
              ),
            ),
            Divider(height: 48.w),
            CustomFormInput(
              label: 'Name of Company',
              required: true,
              controller: controller.nameInput,
            ),
            SizedBox(height: 20.w),
            CustomFormInput(
              label: 'Company Email',
              required: true,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailInput,
              iconData: Ionicons.mail_open,
            ),
            SizedBox(height: 20.w),
            CustomFormInput(
              label: 'Established date',
              required: true,
              readOnly: true,
              controller: controller.dateInput,
              iconData: Ionicons.chevron_down,
              onTap: () async {
                final result = await CustomBottomSheet.showDateTime(
                  context: context,
                  title: const Text('Established date'),
                  value: Date.fromStr(controller.dateInput.value.text),
                  minValue: DateTime(1960, 1, 1),
                  maxValue: DateTime.now(),
                );
                controller.changeDate(result);
              },
            ),
            SizedBox(height: 20.w),
            CustomFormInput(
              label: 'Country',
              required: true,
              readOnly: true,
              controller: controller.countryInput,
              iconData: Ionicons.chevron_down,
              onTap: () async {
                final result = await CustomBottomSheet.showPicker<String>(
                  context: context,
                  title: const Text('Country'),
                  items: ConfigStore.to.countries,
                  builder: (value) => Text(value),
                );
                controller.changeCountry(result);
              },
            ),
            SizedBox(height: 20.w),
            CustomFormInput(
              label: 'Company Address',
              maxLines: 3,
              required: true,
              controller: controller.addressInput,
            ),
          ]);
        } else {
          ws.addAll([
            CustomAvatar.upload(
              url: controller.image,
              beforeChild: CustomCard.icon(
                icon: const Icon(Ionicons.cloud_upload),
                text: const Text('Upload Photo Profile'),
              ),
            ),
            Divider(height: 48.w),
            CustomFormInput(
              label: 'Full Name',
              required: true,
              controller: controller.nameInput,
            ),
            SizedBox(height: 20.w),
            CustomFormInput(
              label: 'Email',
              required: true,
              iconData: Ionicons.mail_open,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailInput,
            ),
            SizedBox(height: 20.w),
            CustomFormInput(
              label: 'Date of birth',
              required: true,
              readOnly: true,
              iconData: Ionicons.chevron_down,
              controller: controller.dateInput,
              onTap: () async {
                final result = await CustomBottomSheet.showDateTime(
                  context: context,
                  title: const Text('Date of birth'),
                  value: Date.fromStr(controller.dateInput.value.text),
                  minValue: DateTime(1960, 1, 1),
                  maxValue: DateTime.now(),
                );
                controller.changeDate(result);
              },
            ),
            SizedBox(height: 20.w),
            CustomFormInput(
              label: 'Occupation',
              required: true,
              controller: controller.jobInput,
            ),
            SizedBox(height: 20.w),
            CustomFormInput(
              label: 'Address',
              maxLines: 3,
              required: true,
              controller: controller.addressInput,
            ),
          ]);
        }
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            appBar: CustomAppBar(
              title: const Text('Profile'),
            ),
            body: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SafeArea(
                minimum: const EdgeInsets.all(AppTheme.margin),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: ws,
                  ),
                ),
              ),
            ),
            bottomNavigationBar: CustomBottomAppBar.operate(
              text: const Text('Confirm'),
              onPressed: () => controller.onSubmit(context, _formKey),
            ),
          ),
        );
      },
    );
  }
}
