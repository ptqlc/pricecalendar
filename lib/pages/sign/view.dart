part of 'index.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignController>(
      init: SignController(),
      builder: (controller) => GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: CustomAppBar(
            systemOverlayStyle: Theme.of(context).brightness == Brightness.light
                ? SystemUiOverlayStyle.dark
                : SystemUiOverlayStyle.light,
            backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: SafeArea(
              top: false,
              minimum: const EdgeInsets.all(AppTheme.margin).copyWith(
                top: Screen.statusBar,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 24.w),
                    CustomEmpty(
                      icon: const CustomImage.asset(
                        url: 'assets/images/logo.png',
                        fit: BoxFit.contain,
                      ),
                      title: Text(
                        'Sign in to your account',
                        style: TextStyle(fontSize: 23.w),
                      ),
                    ),
                    SizedBox(height: 32.w),
                    CustomFormInput(
                      label: 'Email',
                      required: true,
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailInput,
                      validator: EmailValidator(),
                    ),
                    SizedBox(height: 20.w),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.showPassword,
                      builder: (context, value, child) => CustomFormInput(
                        label: 'Password',
                        required: true,
                        obscureText: !value,
                        iconData:
                            value ? Icons.visibility : Icons.visibility_off,
                        controller: controller.passwordInput,
                        validator: PasswordValidator(),
                        onIcon: controller.onShowPassword,
                      ),
                    ),
                    SizedBox(height: 30.w),
                    CustomButton(
                      size: CustomButtonSize.large,
                      shape: CustomButtonShape.stadium,
                      child: const Text('Sign in'),
                      onPressed: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        final result = await controller.onLogin(_formKey);
                        if (result != true) return;
                        if (context.mounted) context.pushNamed(Routes.role);
                      },
                    ),
                    SizedBox(height: 10.w),
                    Center(
                      child: CustomButton(
                        type: CustomButtonType.borderless,
                        padding: EdgeInsets.all(10.w),
                        child: const Text('Forgot the password?'),
                        onPressed: () => context.pushNamed(
                          Routes.resetPassword,
                        ),
                      ),
                    ),
                    SizedBox(height: 22.w),
                    const Text(
                      'or continue with',
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 24.w),
                    BuildMethodList(
                      items: [
                        BuildMethodItem(
                          icon: 'assets/images/icon_facebook.png',
                          text: const Text('Facebook'),
                        ),
                        BuildMethodItem(
                          icon: 'assets/images/icon_google.png',
                          text: const Text('Google'),
                        ),
                      ],
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
