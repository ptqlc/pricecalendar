part of 'index.dart';

class VacancyEditPage extends StatefulWidget {
  const VacancyEditPage({super.key});

  @override
  State<VacancyEditPage> createState() => _VacancyEditPageState();
}

class _VacancyEditPageState extends State<VacancyEditPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  void _onSubmit(VacancyEditController controller) async {
    if (_formKey.currentState?.validate() != true) {
      _tabController.animateTo(0);
      return;
    }
    await CustomDialog.show(
      context: context,
      builder: (context) => const CustomEmpty(
        icon: Icon(Icons.check_circle_rounded),
        title: Text('Successful!'),
      ),
      confirm: const Text('OK'),
      onConfirm: Navigator.of(context).pop,
    );
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VacancyEditController>(
      init: VacancyEditController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: CustomAppBar(
            title: const Text('Vacancy'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: CustomTabBar(
                  controller: _tabController,
                  isScrollable: false,
                  onTap: (_) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  tabs: const [
                    Tab(text: 'Job Details'),
                    Tab(text: 'Requirements'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _BuildVacancyForm(
                      formKey: _formKey,
                      controller: controller,
                      onLocationChanged: controller.changeLocation,
                      onTypeChanged: controller.changeType,
                      onStatusChanged: controller.changeStatus,
                    ),
                    SingleChildScrollView(
                      child: SafeArea(
                        minimum: const EdgeInsets.all(AppTheme.margin),
                        child: CustomRequirementGroup.editor(
                          items: controller.requirementList,
                          builder: (context, index) {
                            return Text(controller.requirementList[index]);
                          },
                          onChanged: controller.changeRequirementList,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomAppBar.operate(
            text: const Text('Update'),
            onPressed: () => _onSubmit(controller),
          ),
        ),
      ),
    );
  }
}

class _BuildVacancyForm extends StatefulWidget {
  final VacancyEditController controller;
  final GlobalKey<FormState> formKey;
  final ValueChanged<String>? onLocationChanged;
  final ValueChanged<String>? onTypeChanged;
  final ValueChanged<String>? onStatusChanged;

  const _BuildVacancyForm({
    required this.formKey,
    required this.controller,
    this.onLocationChanged,
    this.onTypeChanged,
    this.onStatusChanged,
  });

  @override
  _BuildVacancyFormState createState() => _BuildVacancyFormState();
}

class _BuildVacancyFormState extends State<_BuildVacancyForm>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: SafeArea(
        minimum: const EdgeInsets.all(AppTheme.margin),
        child: Form(
          key: widget.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomFormInput(
                label: 'Open Position',
                required: true,
                controller: widget.controller.positionInput,
              ),
              SizedBox(height: 20.w),
              CustomFormInput(
                label: 'Salary',
                required: true,
                iconData: Icons.attach_money_rounded,
                controller: widget.controller.salaryInput,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: AmountValidator(),
                inputFormatters: [AmountInputFormatter()],
              ),
              SizedBox(height: 20.w),
              CustomFormInput(
                label: 'Location',
                required: true,
                readOnly: true,
                controller: widget.controller.locationInput,
                iconData: Ionicons.chevron_down,
                onTap: () async {
                  final result = await CustomBottomSheet.showPicker<String>(
                    context: context,
                    title: const Text('Country'),
                    items: ConfigStore.to.countries,
                    builder: (value) => Text(value),
                  );
                  if (result == null) return;
                  widget.onLocationChanged?.call(result);
                },
              ),
              SizedBox(height: 20.w),
              CustomFormInput(
                label: 'Type',
                required: true,
                readOnly: true,
                controller: widget.controller.typeInput,
                iconData: Ionicons.chevron_down,
                onTap: () async {
                  final result = await CustomBottomSheet.showSelect<String>(
                    context: context,
                    title: const Text('Type'),
                    value: widget.controller.type,
                    items: [
                      'Full Time',
                      'Contract',
                      'Part Time',
                      'Temporary',
                      'Internship',
                    ],
                    builder: (value) => Text(value),
                  );
                  if (result == null) return;
                  widget.onTypeChanged?.call(result);
                },
              ),
              SizedBox(height: 20.w),
              CustomFormInput(
                label: 'Status',
                required: true,
                readOnly: true,
                controller: widget.controller.statusInput,
                iconData: Ionicons.chevron_down,
                onTap: () async {
                  final result = await CustomBottomSheet.showSelect<String>(
                    context: context,
                    title: const Text('Status'),
                    value: widget.controller.status,
                    items: ['Active', 'Inactive'],
                    builder: (value) => Text(value),
                  );
                  if (result == null) return;
                  widget.onStatusChanged?.call(result);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
