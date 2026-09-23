part of 'index.dart';

enum CustomAvatarSize { large, medium, small }

enum CustomAvatarShape { circle, radius }

class CustomAvatar extends StatelessWidget {
  final String url;
  final double? diameter;
  final CustomAvatarSize? size;
  final CustomAvatarShape shape;
  final CustomImageType type;
  final void Function()? onTap;

  const CustomAvatar({
    super.key,
    required this.url,
    this.diameter,
    this.size,
    this.type = CustomImageType.network,
    this.shape = CustomAvatarShape.circle,
    this.onTap,
  });

  static Widget upload({
    String? url,
    CustomAvatarShape shape = CustomAvatarShape.circle,
    Widget? beforeChild,
    void Function()? onTap,
    Future<void> Function(String path)? onUpload,
  }) {
    return _AvatarWithUploadChild(
      url: url,
      shape: shape,
      beforeChild: beforeChild,
      onTap: onTap,
      onUpload: onUpload,
    );
  }

  const CustomAvatar.large({
    super.key,
    required this.url,
    this.onTap,
    this.type = CustomImageType.network,
    this.shape = CustomAvatarShape.circle,
  })  : diameter = null,
        size = CustomAvatarSize.large;

  const CustomAvatar.medium({
    super.key,
    required this.url,
    this.onTap,
    this.type = CustomImageType.network,
    this.shape = CustomAvatarShape.circle,
  })  : diameter = null,
        size = CustomAvatarSize.medium;

  const CustomAvatar.small({
    super.key,
    required this.url,
    this.onTap,
    this.type = CustomImageType.network,
    this.shape = CustomAvatarShape.circle,
  })  : diameter = null,
        size = CustomAvatarSize.small;

  double get _size {
    switch (size) {
      case CustomAvatarSize.large:
        return 100.w;
      case CustomAvatarSize.medium:
        return 60.w;
      case CustomAvatarSize.small:
        return 32.w;
      default:
        return diameter ?? 60.w;
    }
  }

  double get _radius {
    switch (shape) {
      case CustomAvatarShape.circle:
        return _size / 2;
      case CustomAvatarShape.radius:
        return 15.w;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomImage(
        url: url,
        type: type,
        width: _size,
        height: _size,
        radius: _radius,
      ),
    );
  }
}

class _AvatarWithUploadChild extends StatefulWidget {
  final String? url;
  final CustomAvatarShape shape;
  final Widget? beforeChild;
  final Future<void> Function(String path)? onUpload;
  final void Function()? onTap;

  const _AvatarWithUploadChild({
    this.url,
    this.beforeChild,
    this.onUpload,
    this.shape = CustomAvatarShape.circle,
    this.onTap,
  });

  @override
  _AvatarWithUploadChildState createState() => _AvatarWithUploadChildState();
}

class _AvatarWithUploadChildState extends State<_AvatarWithUploadChild> {
  late CustomImageType _type;
  late String _url;

  @override
  void initState() {
    super.initState();
    _type = CustomImageType.network;
    _url = widget.url ?? '';
  }

  @override
  void didUpdateWidget(covariant _AvatarWithUploadChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    _type = CustomImageType.network;
    _url = widget.url ?? '';
  }

  void _upload() async {
    final assets = await AssetsPicker.image(
      context: context,
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
    );
    if (assets == null) return;
    await widget.onUpload?.call(assets.path);
    setState(() {
      _type = CustomImageType.file;
      _url = assets.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    if (widget.beforeChild != null && _url.isEmpty) {
      return GestureDetector(
        onTap: _upload,
        child: widget.beforeChild,
      );
    }
    return Center(
      child: Stack(
        children: [
          CustomAvatar.large(
            url: _url,
            onTap: widget.onTap,
            shape: widget.shape,
            type: _type,
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _upload,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: ShapeDecoration(
                  color: colorScheme.primary,
                  shape: const CircleBorder(),
                ),
                child: Icon(
                  Ionicons.pencil,
                  size: 18.w,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
