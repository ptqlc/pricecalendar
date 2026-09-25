part of '../index.dart';

class BuildUserinfo extends StatelessWidget {
  final String? avatar;
  final String? name;
  final String? email;
  final String? summary;

  const BuildUserinfo({
    super.key,
    this.avatar,
    this.name,
    this.email,
    this.summary,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        CustomAvatar.upload(
          url: avatar ?? '',
          onTap: () {
            CustomGallery.show(
              context: context,
              items: [
                CustomGalleryItem(
                  type: CustomImageType.network,
                  url: avatar ?? '',
                ),
              ],
            );
          },
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: DefaultTextStyle.merge(
            style: TextStyle(
              fontSize: 16.w,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  name ?? '',
                  style: TextStyle(
                    fontSize: 23.w,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.w),
                Text(email ?? ''),
                SizedBox(height: 5.w),
                Text(summary ?? ''),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
