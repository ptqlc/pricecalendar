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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomAvatar(
          diameter: 160.w,
          url: avatar,
        ),
        SizedBox(height: 20.w),
        DefaultTextStyle.merge(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 26.w, fontWeight: FontWeight.w600),
          child: Text(nickname),
        ),
        SizedBox(height: 10.w),
        DefaultTextStyle.merge(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.w,
            color:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          child: Text(status),
        ),
      ],
    );
  }
}
