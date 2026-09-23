part of '../index.dart';

class BuildPolicyLink extends StatelessWidget {
  final void Function()? onTerms;
  final void Function()? onPrivacy;

  const BuildPolicyLink({
    super.key,
    this.onTerms,
    this.onPrivacy,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
        children: [
          const TextSpan(
            text: 'Terms of service',
            // recognizer: TapGestureRecognizer()..onTap = onTerms,
          ),
          TextSpan(
            text: ' & ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const TextSpan(
            text: 'Privacy policy',
            // recognizer: TapGestureRecognizer()..onTap = onPrivacy,
          ),
        ],
      ),
    );
  }
}
