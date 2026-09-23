part of '../index.dart';

class BuildBanner extends StatelessWidget {
  final List items;

  const BuildBanner({
    super.key,
    this.items = const [],
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        aspectRatio: 19 / 9,
        enlargeCenterPage: false,
        enableInfiniteScroll: items.length > 1,
        autoPlay: items.length > 1,
      ),
      items: items.map((item) {
        return SafeArea(
          minimum: const EdgeInsets.symmetric(
            horizontal: AppTheme.margin,
          ).copyWith(bottom: 30.w),
          child: CustomCard(
            clipBehavior: Clip.antiAlias,
            showBorder: false,
            gradientColors: [
              Color.alphaBlend(item.withOpacity(0.6), Colors.white),
              item,
            ],
            shadowColor: item.withOpacity(0.4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20.w),
                    child: Text(
                      'How to find a perfect job for you',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                CustomImage.asset(
                  url: 'assets/images/banner.png',
                  width: 150.w,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
