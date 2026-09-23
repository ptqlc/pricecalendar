part of 'index.dart';

class CustomGalleryItem {
  final CustomImageType type;
  final String url;

  CustomGalleryItem({required this.type, required this.url});
}

class CustomGallery extends StatefulWidget {
  final List<CustomGalleryItem> items;
  final int initialPage;
  final void Function()? onTap;

  const CustomGallery({
    super.key,
    this.items = const [],
    this.onTap,
    this.initialPage = 0,
  });

  static Future<void> show({
    required BuildContext context,
    List<CustomGalleryItem> items = const [],
    int initialPage = 0,
  }) async {
    await Navigator.of(context).push(
      CupertinoDialogRoute(
        context: context,
        builder: (context) => ExtendedImageSlidePage(
          slideAxis: SlideAxis.both,
          resetPageDuration: const Duration(milliseconds: 150),
          child: CustomGallery(
            initialPage: initialPage,
            items: items,
            onTap: () => Navigator.of(context).pop(),
          ),
          slidePageBackgroundHandler: (offset, size) {
            final distance = Offset(size.width, size.height).distance;
            var opacity = offset.distance / (distance / 2.0);
            opacity = min(1.0, max(1.0 - opacity, 0.0));
            return Colors.black.withOpacity(opacity);
          },
        ),
      ),
    );
  }

  @override
  State<CustomGallery> createState() => _CustomGalleryState();
}

class _CustomGalleryState extends State<CustomGallery> {
  final _currentIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _currentIndex.value = widget.initialPage;
  }

  @override
  void dispose() {
    AppTheme.setSystemStyle();
    super.dispose();
  }

  GestureConfig _config(ExtendedImageState state) {
    return GestureConfig(
      minScale: 1.0,
      inPageView: true,
      initialScale: 1.0,
      maxScale: 5.0,
      animationMaxScale: 6.0,
      initialAlignment: InitialAlignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ws = <Widget>[];
    if (widget.items.length > 1) {
      ws.add(ExtendedImageGesturePageView.builder(
        controller: ExtendedPageController(
          initialPage: widget.initialPage,
          pageSpacing: 0,
          shouldIgnorePointerWhenScrolling: true,
        ),
        onPageChanged: (index) => _currentIndex.value = index,
        itemCount: widget.items.length,
        itemBuilder: (context, index) => CustomImage(
          type: widget.items.first.type,
          url: widget.items[index].url,
          fit: BoxFit.contain,
          mode: ExtendedImageMode.gesture,
          enableSlideOutPage: true,
          initGestureConfig: _config,
        ),
      ));
      ws.add(Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: _buildIndicators(),
      ));
    } else if (widget.items.length == 1) {
      ws.add(CustomImage(
        url: widget.items.first.url,
        type: widget.items.first.type,
        fit: BoxFit.contain,
        mode: ExtendedImageMode.gesture,
        enableSlideOutPage: true,
        initGestureConfig: _config,
      ));
    }

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: widget.onTap,
      child: Theme(
        data: AppTheme.dark,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: AppTheme.systemStyleDark.copyWith(
            systemNavigationBarColor: Colors.black,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: ws,
          ),
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    return SafeArea(
      minimum: const EdgeInsets.all(AppTheme.margin),
      child: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, value, child) => Wrap(
          spacing: 10.w,
          runSpacing: 10.w,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: List.generate(widget.items.length, (index) {
            final opacity = index == value ? 1.0 : 0.5;
            return Container(
              width: 10.w,
              height: 10.w,
              decoration: ShapeDecoration(
                shape: const CircleBorder(),
                color: Colors.white.withOpacity(opacity),
              ),
            );
          }),
        ),
      ),
    );
  }
}
