part of 'index.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  Future<String?> _showInputDialog({
    required String title,
    required TextEditingController controller,
    Validator<String?>? validator,
    int maxLines = 1,
  }) async {
    return CustomDialog.show<String?>(
      context: context,
      title: Text(title),
      confirm: const Text('Confirm'),
      cancel: const Text('Cancel'),
      builder: (context) => CustomInput(
        controller: controller,
        maxLines: maxLines,
        autofocus: true,
      ),
      onCancel: () => Navigator.of(context).pop(),
      onConfirm: () {
        final text = controller.value.text.trim();
        if (validator == null) {
          Navigator.of(context).pop(text);
          return;
        }
        final error = validator.call(text);
        if (error != null) CustomToast.text(error);
        Navigator.of(context).pop(error == null ? text : null);
      },
    );
  }

  void _updateGeekName(ProfileController controller) async {
    controller.textInput.text = controller.geek?.name ?? '';
    final result = await _showInputDialog(
      title: 'Full Name',
      controller: controller.textInput,
      validator: RequiredValidator(),
    );
    if (result == null) return;
    controller.updateGeekInfo(GeekModel(name: result));
  }

  void _updateGeekEmail(ProfileController controller) async {
    controller.textInput.text = controller.geek?.email ?? '';
    final result = await _showInputDialog(
      title: 'Email',
      controller: controller.textInput,
      validator: EmailValidator(),
    );
    if (result == null) return;
    controller.updateGeekInfo(GeekModel(email: result));
  }

  void _updateGeekBirthday(ProfileController controller) async {
    final result = await CustomBottomSheet.showDateTime(
      context: context,
      title: const Text('Date of birth'),
      value: DateTime.fromMillisecondsSinceEpoch(
        controller.geek?.birthday ?? 0,
      ).toLocal(),
      minValue: DateTime(1960, 1, 1),
      maxValue: DateTime.now(),
    );
    if (result == null) return;
    final timestamp = Date.fromTimeToMilli(result);
    controller.updateGeekInfo(GeekModel(birthday: timestamp));
  }

  void _updateGeekAddress(ProfileController controller) async {
    controller.textInput.text = controller.geek?.address ?? '';
    final result = await _showInputDialog(
      title: 'Address',
      controller: controller.textInput,
      maxLines: 3,
      validator: RequiredValidator(),
    );
    if (result == null) return;
    controller.updateGeekInfo(GeekModel(address: result));
  }

  void _updateGeekOccupation(ProfileController controller) async {
    controller.textInput.text = controller.geek?.occupation ?? '';
    final result = await _showInputDialog(
      title: 'Occupation',
      controller: controller.textInput,
      validator: RequiredValidator(),
    );
    if (result == null) return;
    controller.updateGeekInfo(GeekModel(occupation: result));
  }

  void _updateBossCountry(ProfileController controller) async {
    final result = await CustomBottomSheet.showPicker<String>(
      context: context,
      title: const Text('Country'),
      items: ConfigStore.to.countries,
      builder: (value) => Text(value),
    );
    if (result == null) return;
    controller.updateBossInfo(BossModel(country: result));
  }

  void _updateBossEstablished(ProfileController controller) async {
    final result = await CustomBottomSheet.showDateTime(
      context: context,
      title: const Text('Established date'),
      value: DateTime.fromMillisecondsSinceEpoch(
        controller.boss?.established ?? 0,
      ).toLocal(),
      minValue: DateTime(1960, 1, 1),
      maxValue: DateTime.now(),
    );
    if (result == null) return;
    final timestamp = Date.fromTimeToMilli(result);
    controller.updateBossInfo(BossModel(established: timestamp));
  }

  void _updateBossAddress(ProfileController controller) async {
    controller.textInput.text = controller.boss?.address ?? '';
    final result = await _showInputDialog(
      title: 'Company Address',
      controller: controller.textInput,
      maxLines: 3,
      validator: RequiredValidator(),
    );
    if (result == null) return;
    controller.updateBossInfo(BossModel(address: result));
  }

  void _updateBossName(ProfileController controller) async {
    controller.textInput.text = controller.boss?.name ?? '';
    final result = await _showInputDialog(
      title: 'Name of Company',
      controller: controller.textInput,
      validator: RequiredValidator(),
    );
    if (result == null) return;
    controller.updateBossInfo(BossModel(name: result));
  }

  void _updateBossEmail(ProfileController controller) async {
    controller.textInput.text = controller.boss?.email ?? '';
    final result = await _showInputDialog(
      title: 'Email',
      controller: controller.textInput,
      validator: EmailValidator(),
    );
    if (result == null) return;
    controller.updateBossInfo(BossModel(email: result));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        final ws = <Widget>[];
        if (ConfigStore.to.roleType == C.roleBoss) {
          ws.add(CustomCellGroup(
            children: [
              CustomCell(
                title: const Text('Name of Company'),
                value: Text(controller.boss?.name ?? ''),
                onTap: () => _updateBossName(controller),
              ),
              CustomCell(
                title: const Text('Company Email'),
                value: Text(controller.boss?.email ?? ''),
                onTap: () => _updateBossEmail(controller),
              ),
              CustomCell(
                title: const Text('Established date'),
                value: Text(Date.fromMilliToStr(controller.boss?.established)),
                onTap: () => _updateBossEstablished(controller),
              ),
              CustomCell(
                title: const Text('Country'),
                value: Text(controller.boss?.country ?? ''),
                onTap: () => _updateBossCountry(controller),
              ),
              CustomCell(
                title: const Text('Company Address'),
                value: Text(controller.boss?.address ?? ''),
                onTap: () => _updateBossAddress(controller),
              ),
            ],
          ));
        } else {
          ws.add(CustomCellGroup(
            children: [
              CustomCell(
                title: const Text('Full Name'),
                value: Text(controller.geek?.name ?? ''),
                onTap: () => _updateGeekName(controller),
              ),
              CustomCell(
                title: const Text('Email'),
                value: Text(controller.geek?.email ?? ''),
                onTap: () => _updateGeekEmail(controller),
              ),
              CustomCell(
                title: const Text('Date of birth'),
                value: Text(Date.fromMilliToStr(controller.geek?.birthday)),
                onTap: () => _updateGeekBirthday(controller),
              ),
              CustomCell(
                title: const Text('Occupation'),
                value: Text(controller.geek?.occupation ?? ''),
                onTap: () => _updateGeekOccupation(controller),
              ),
              CustomCell(
                title: const Text('Address'),
                value: Text(controller.geek?.address ?? ''),
                onTap: () => _updateGeekAddress(controller),
              ),
            ],
          ));
        }
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Scaffold(
            appBar: CustomAppBar(
              title: const Text('Profile'),
              actions: [
                CustomButton.icon(
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                  icon: const Icon(Ionicons.settings_sharp),
                  onPressed: () => context.pushNamed(Routes.settings),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                minimum: const EdgeInsets.all(AppTheme.margin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    BuildUserinfo(
                      avatar: 'https://api.multiavatar.com/Binx Bond.png',
                      name: controller.name,
                      email: UserStore.to.account,
                      summary: controller.summary,
                    ),
                    SizedBox(height: 20.w),
                    ...ws,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
