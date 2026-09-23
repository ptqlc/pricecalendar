part of 'index.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return GetBuilder<ResetPasswordController>(
      init: ResetPasswordController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: CustomAppBar(
            title: const Text('Reset Password'),
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
                    Text(
                      UserStore.to.isLogin
                          ? 'Select which contact details should we use to reset your password'
                          : 'Enter your email to reset your password',
                    ),
                    SizedBox(height: 20.w),
                    UserStore.to.isLogin
                        ? CustomCard.icon(
                            direction: Axis.horizontal,
                            borderColor: colorScheme.primary,
                            icon: const Icon(Icons.email_rounded),
                            text: Text(controller.emailInput.value.text),
                            label: const Text('via Email:'),
                          )
                        : CustomFormInput(
                            label: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            required: true,
                            controller: controller.emailInput,
                            validator: EmailValidator(),
                          ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomAppBar.operate(
            text: const Text('Continue'),
            onPressed: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              final result = await controller.onSendEmail(_formKey);
              if (result != true) return;
              if (context.mounted) {
                context.pushNamed(Routes.resetPasswordVerify);
              }
            },
          ),
        ),
      ),
    );
  }
}

class ResetPasswordVerifyPage extends StatelessWidget {
  const ResetPasswordVerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      builder: (controller) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            title: const Text('Reset Password'),
          ),
          body: Center(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: SafeArea(
                top: false,
                minimum: const EdgeInsets.all(AppTheme.margin)
                    .copyWith(top: Screen.statusBar),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Code has been send to ${controller.sendTo}',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 60.w),
                    CustomInputCode(
                      errorText: 'Code: 8888',
                      validator: controller.onCodeVerify,
                      onCompleted: (key, value) {
                        if (key.currentState?.validate() != true) return;
                        context.pushReplacementNamed(Routes.resetPasswordEdit);
                      },
                    ),
                    SizedBox(height: 60.w),
                    BuildCountdown(
                      onTap: controller.onResendEmail,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordEditPage extends StatefulWidget {
  const ResetPasswordEditPage({super.key});

  @override
  State<ResetPasswordEditPage> createState() => _ResetPasswordEditPageState();
}

class _ResetPasswordEditPageState extends State<ResetPasswordEditPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordController>(
      builder: (controller) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: CustomAppBar(
            title: const Text('Reset Password'),
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
                    const Text('Create a new password'),
                    SizedBox(height: 32.w),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.showPassword,
                      builder: (context, value, child) => CustomFormInput(
                        label: 'New Password',
                        required: true,
                        obscureText: !value,
                        iconData:
                            value ? Icons.visibility : Icons.visibility_off,
                        controller: controller.passwordInput,
                        validator: PasswordValidator(),
                        onIcon: controller.onShowPassword,
                      ),
                    ),
                    SizedBox(height: 20.w),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.showPassword,
                      builder: (context, value, child) => CustomFormInput(
                        label: 'Confirm New Password',
                        required: true,
                        obscureText: !value,
                        iconData:
                            value ? Icons.visibility : Icons.visibility_off,
                        controller: controller.password2Input,
                        validator: EqualValidator(controller.passwordInput),
                        onIcon: controller.onShowPassword,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomAppBar.operate(
            text: const Text('Save'),
            onPressed: () async {
              final result = await controller.onSubmit(context, _formKey);
              if (result != true) return;
              if (context.mounted) {
                context.pushReplacementNamed(Routes.resetPasswordSuccess);
              }
            },
          ),
        ),
      ),
    );
  }
}

class ResetPasswordSuccessPage extends StatelessWidget {
  const ResetPasswordSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(),
      body: const Center(
        child: SingleChildScrollView(
          child: SafeArea(
            top: false,
            minimum: EdgeInsets.all(AppTheme.margin),
            child: CustomEmpty(
              icon: Icon(Icons.insert_emoticon),
              title: Text('Congrats!'),
              label: Text('Your account is ready to use'),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar.operate(
        text: const Text('Go to homepage'),
        onPressed: () => context.goNamed(Routes.main),
      ),
    );
  }
}
