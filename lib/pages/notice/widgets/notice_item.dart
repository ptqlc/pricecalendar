part of '../index.dart';

class BuildNoticeItem extends StatelessWidget {
  const BuildNoticeItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return CustomCard(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Ionicons.notifications_circle,
              size: 30.w,
              color: AppTheme.primary,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Your application to Apple Company has been read',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.w,
                    ),
                  ),
                  SizedBox(height: 3.w),
                  Text(
                    '17:00',
                    style: TextStyle(
                      fontSize: 14.w,
                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
