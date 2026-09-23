part of 'index.dart';

class CustomFormInput extends FormField<String> {
  final TextEditingController? controller;
  final String? label;
  final String? helper;
  final String? hintText;
  final bool required;
  final bool readOnly;
  final bool obscureText;
  final bool autofocus;
  final IconData? iconData;
  final int? maxLines;
  final void Function()? onTap;
  final void Function()? onIcon;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  CustomFormInput({
    super.key,
    this.controller,
    this.label,
    this.helper,
    this.hintText,
    this.required = false,
    this.readOnly = false,
    this.obscureText = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.onTap,
    this.onIcon,
    this.iconData,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    Validator<String?>? validator,
  }) : super(
          validator: (value) {
            if (required) {
              final call = RequiredValidator().call(value);
              if (validator == null) return call;
              return call ?? validator.call(value);
            }
            return validator?.call(value);
          },
          builder: (field) {
            final state = field as _CustomFormInputState;
            final decoration = const InputDecoration().applyDefaults(
              Theme.of(field.context).inputDecorationTheme,
            );
            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: CustomInput(
                controller: state._effectiveController,
                label: label,
                hintText: hintText,
                required: required,
                readOnly: readOnly,
                obscureText: obscureText,
                autofocus: autofocus,
                onTap: onTap,
                onIcon: onIcon,
                iconData: iconData,
                maxLines: maxLines,
                error: field.errorText,
                decoration: decoration,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
                onChanged: (value) {
                  field.didChange(value);
                  onChanged?.call(value);
                },
              ),
            );
          },
        );

  @override
  FormFieldState<String> createState() => _CustomFormInputState();
}

class _CustomFormInputState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller!.value;

  @override
  CustomFormInput get widget => super.widget as CustomFormInput;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) _registerController();
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) _registerController();
  }

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      final editingValue = widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null;
      _createLocalController(editingValue);
    } else {
      widget.controller!.addListener(_onControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CustomFormInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_onControllerChanged);
      widget.controller?.addListener(_onControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (widget.controller != null) {
        setValue(widget.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _onControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}

class CustomInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? helper;
  final String? hintText;
  final String? error;
  final bool required;
  final bool readOnly;
  final bool obscureText;
  final IconData? iconData;
  final int? minLines;
  final int? maxLines;
  final void Function()? onTap;
  final void Function()? onIcon;
  final ValueChanged<String>? onChanged;
  final InputDecoration decoration;
  final TextInputType? keyboardType;
  final bool autofocus;
  final List<TextInputFormatter>? inputFormatters;

  const CustomInput({
    super.key,
    this.controller,
    this.label,
    this.helper,
    this.hintText,
    this.error,
    this.required = false,
    this.readOnly = false,
    this.obscureText = false,
    this.onTap,
    this.onIcon,
    this.iconData,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.minLines,
    this.maxLines = 1,
    this.keyboardType,
    this.autofocus = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final decorationTheme = theme.inputDecorationTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (label != null || required)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (decorationTheme.contentPadding?.horizontal ?? 0) / 2,
              vertical: 10.w,
            ).copyWith(top: 0),
            child: RichText(
              text: TextSpan(
                text: label,
                style: decorationTheme.labelStyle,
                children: [
                  if (required)
                    TextSpan(
                      text: label != null ? ' *' : '*',
                      style: const TextStyle(color: AppTheme.error),
                    ),
                ],
              ),
            ),
          ),
        DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow,
                offset: Offset(0, 20.w),
                blurRadius: 10.w,
                spreadRadius: -10.w,
              ),
            ],
          ),
          child: TextField(
            autofocus: autofocus,
            controller: controller,
            readOnly: readOnly,
            onTap: onTap,
            obscureText: obscureText,
            onChanged: onChanged,
            minLines: minLines,
            maxLines: maxLines,
            inputFormatters: inputFormatters,
            keyboardType: keyboardType,
            style: TextStyle(
              fontFamily: 'Sans',
              fontSize: 18.w,
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
            decoration: decoration.copyWith(
              hintText: hintText,
              hintStyle: const TextStyle(fontWeight: FontWeight.normal),
              suffixIconConstraints: const BoxConstraints(),
              suffixIcon: _suffixIcon(decorationTheme),
            ),
          ),
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.topCenter,
          child: error != null
              ? Padding(
                  padding: EdgeInsets.only(top: 10.w),
                  child: CustomAlert.error(
                    size: CustomAlertSize.mini,
                    text: Text(error!),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        if (helper != null)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: (decorationTheme.contentPadding?.horizontal ?? 0) / 2,
              vertical: 10.w,
            ).copyWith(bottom: 0),
            child: Text(
              helper!,
              style: decorationTheme.helperStyle,
            ),
          )
      ],
    );
  }

  Widget? _suffixIcon(InputDecorationTheme decorationTheme) {
    if (iconData == null) return null;
    return Padding(
      padding: EdgeInsetsDirectional.only(
        end: (decorationTheme.contentPadding?.horizontal ?? 0) / 2,
      ),
      child: GestureDetector(
        onTap: onIcon,
        child: Icon(iconData!, size: 24.w),
      ),
    );
  }
}

class CustomInputSearch extends StatelessWidget {
  final IconData iconData;
  final String? hintText;
  final TextEditingController? controller;
  final bool readOnly;
  final void Function()? onTap;

  const CustomInputSearch({
    super.key,
    this.iconData = Icons.search_rounded,
    this.hintText,
    this.controller,
    this.readOnly = false,
    this.onTap,
  });

  EdgeInsetsGeometry get _padding {
    return EdgeInsets.symmetric(
      vertical: 13.w,
      horizontal: 20.w,
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = Theme.of(context).inputDecorationTheme;
    return TextField(
      readOnly: readOnly,
      controller: controller,
      onTap: onTap,
      style: TextStyle(
        fontFamily: 'Sans',
        fontSize: 16.w,
        height: 1.2,
      ),
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.tertiary,
        contentPadding: _padding.subtract(EdgeInsets.symmetric(
          horizontal: _padding.horizontal / 4,
        )),
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _padding.horizontal / 4,
          ),
          child: Icon(
            iconData,
            size: 24.w,
            color: const Color(0xFF858C94),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(),
        hintText: hintText ?? 'Search',
        enabledBorder: inputDecoration.enabledBorder?.copyWith(
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: inputDecoration.enabledBorder?.copyWith(
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        disabledBorder: inputDecoration.enabledBorder?.copyWith(
          borderSide: const BorderSide(color: Colors.transparent),
        ),
      ),
    );
  }
}

class CustomInputCode extends StatefulWidget {
  final int? count;
  final bool enabled;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final void Function(GlobalKey<FormState> key, String value)? onCompleted;

  const CustomInputCode({
    super.key,
    this.count,
    this.onCompleted,
    this.validator,
    this.enabled = true,
    this.errorText,
  });

  @override
  State<CustomInputCode> createState() => _CustomInputCodeState();
}

class _CustomInputCodeState extends State<CustomInputCode> {
  final _formKey = GlobalKey<FormState>();

  int get _count => widget.count ?? 4;

  PinTheme _defaultTheme(ThemeData theme) {
    return PinTheme(
      width: double.infinity,
      height: 68.w,
      padding: const EdgeInsets.all(0),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      textStyle: theme.textTheme.bodyMedium?.copyWith(
        fontSize: 30.w,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(20.w)),
        border: theme.inputDecorationTheme.border != null
            ? Border.fromBorderSide(
                theme.inputDecorationTheme.border!.borderSide,
              )
            : null,
      ),
    );
  }

  PinTheme _focusedTheme(ThemeData theme) {
    if (theme.inputDecorationTheme.border == null) return _defaultTheme(theme);
    return _defaultTheme(theme).copyBorderWith(
      border: Border.fromBorderSide(
        theme.inputDecorationTheme.focusedBorder!.borderSide,
      ),
    );
  }

  PinTheme _errorTheme(ThemeData theme) {
    if (theme.inputDecorationTheme.border == null) return _defaultTheme(theme);
    return _defaultTheme(theme).copyBorderWith(
      border: Border.fromBorderSide(
        theme.inputDecorationTheme.errorBorder!.borderSide,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Pinput(
        length: _count,
        autofocus: true,
        defaultPinTheme: _defaultTheme(theme),
        focusedPinTheme: _focusedTheme(theme),
        errorPinTheme: _errorTheme(theme),
        errorText: widget.errorText,
        enabled: widget.enabled,
        showCursor: false,
        pinputAutovalidateMode: PinputAutovalidateMode.disabled,
        errorBuilder: (error, value) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: (_defaultTheme(theme).margin?.horizontal ?? 0) / 2,
            ).copyWith(top: 10.w),
            child: CustomAlert.error(
              size: CustomAlertSize.mini,
              text: Text(error ?? 'Error'),
            ),
          );
        },
        validator: widget.validator,
        onCompleted: (value) => widget.onCompleted?.call(_formKey, value),
      ),
    );
  }
}
