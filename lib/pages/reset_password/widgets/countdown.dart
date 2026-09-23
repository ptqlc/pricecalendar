part of '../index.dart';

class BuildCountdown extends StatefulWidget {
  final Future<void> Function()? onTap;

  const BuildCountdown({
    super.key,
    this.onTap,
  });

  @override
  State<BuildCountdown> createState() => _BuildCountdownState();
}

class _BuildCountdownState extends State<BuildCountdown> {
  Timer? _timer;
  bool _isSending = false;
  int _countdown = 60;

  @override
  void initState() {
    super.initState();
    _onStart();
  }

  @override
  void dispose() {
    _onCancel();
    super.dispose();
  }

  void _onStart() {
    setState(() {
      _isSending = false;
      _countdown = 60;
    });
    if (_timer != null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown < 1) {
        _onCancel();
      } else {
        setState(() {
          _countdown -= 1;
        });
      }
    });
  }

  void _onCancel() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Widget build(BuildContext context) {
    late Widget textChild;
    if (_countdown < 1 && !_isSending) {
      textChild = const Text('Get code again');
    } else if (_isSending) {
      textChild = const Text('Sending...');
    } else {
      textChild = RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(text: 'Resend code in'),
            TextSpan(
              text: ' $_countdown ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const TextSpan(text: 'seconds'),
          ],
        ),
      );
    }
    return CustomButton(
      type: CustomButtonType.borderless,
      onPressed: _countdown < 1 && !_isSending
          ? () async {
              _isSending = true;
              setState(() {});
              try {
                await widget.onTap?.call();
                _onStart();
              } catch(error) {
                _isSending = false;
                setState(() {});
              }
            }
          : null,
      child: textChild,
    );
  }
}
