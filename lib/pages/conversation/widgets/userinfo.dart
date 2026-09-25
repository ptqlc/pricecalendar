part of '../index.dart';

class BuildUserinfo extends StatelessWidget {
  final String avatar;
  final String nickname;
  final String status;

  const BuildUserinfo({
    super.key,
    required this.avatar,
    required this.nickname,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        CustomAvatar(url: avatar, diameter: 40.w),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                nickname,
                style: TextStyle(fontSize: 18.w),
              ),
              SizedBox(height: 3.w),
              Text(
                status,
                style: TextStyle(
                  fontSize: 12.w,
                  fontWeight: FontWeight.normal,
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
