part of 'index.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin {
  static const _initialPage = 1200;
  late final PageController _monthController;
  int _page = _initialPage;
  double _lastPagePosition = _initialPage.toDouble();
  int _lastSwipeDirection = 0;
  DateTime _selectedDate = DateTime.now();
  int _selectionAnimationKey = 0;

  DateTime get _month => _monthForPage(_page);

  @override
  void initState() {
    super.initState();
    _monthController = PageController(initialPage: _initialPage);
  }

  DateTime _monthForPage(int page) {
    final current = DateTime(DateTime.now().year, DateTime.now().month);
    return DateTime(current.year, current.month + page - _initialPage);
  }

  void _goToMonth(int offset) {
    if (!_monthController.hasClients ||
        _monthController.position.isScrollingNotifier.value) {
      return;
    }
    _monthController.animateToPage(
      _page + offset,
      duration: const Duration(milliseconds: 360),
      curve: Curves.easeOutCubic,
    );
  }

  void _onMonthScroll() {
    if (!_monthController.hasClients) return;
    final page = _monthController.page ?? _page.toDouble();
    final delta = page - _lastPagePosition;
    if (delta.abs() > 0.01) {
      _lastSwipeDirection = delta > 0 ? 1 : -1;
      _lastPagePosition = page;
    }
  }

  void _onMonthScrollEnd() {
    if (!_monthController.hasClients || _lastSwipeDirection == 0) return;
    final page = _monthController.page ?? _page.toDouble();
    final settledPage = page.round();
    if (settledPage == _page && page != _page.toDouble()) {
      _goToMonth(_lastSwipeDirection);
    }
    _lastSwipeDirection = 0;
  }

  @override
  void dispose() {
    _monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final today = DateTime.now();
    return Scaffold(
      // The status bar can be transparent on some platforms, so the root
      // background must match the red calendar tab bar.
      backgroundColor: AppTheme.primary,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: AppTheme.primary,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
          systemNavigationBarColor: AppTheme.warmSurface,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(
          bottom: false,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _CalendarHeader(
                  month: _month,
                  onPrevious: () => _goToMonth(-1),
                  onNext: () => _goToMonth(1),
                  onToday: () {
                    final current = DateTime(today.year, today.month);
                    _monthController.animateToPage(
                      _initialPage +
                          (current.year - DateTime.now().year) * 12 +
                          current.month -
                          DateTime.now().month,
                      duration: const Duration(milliseconds: 360),
                      curve: Curves.easeOutCubic,
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: AppTheme.paper,
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 18),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _Weekday('日', isWeekend: true),
                          _Weekday('一'),
                          _Weekday('二'),
                          _Weekday('三'),
                          _Weekday('四'),
                          _Weekday('五'),
                          _Weekday('六', isWeekend: true),
                        ],
                      ),
                      const SizedBox(height: 10),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          const columnGap = 2.0;
                          const rowGap = 5.0;
                          final cellWidth =
                              (constraints.maxWidth - columnGap * 6) / 7;
                          final cellHeight = math.max(62.0, cellWidth / .92);
                          final visibleMonth = _month;
                          final leadingDays =
                              DateTime(visibleMonth.year, visibleMonth.month, 1)
                                      .weekday %
                                  7;
                          final daysInMonth = DateTime(
                                  visibleMonth.year, visibleMonth.month + 1, 0)
                              .day;
                          final rowCount =
                              ((leadingDays + daysInMonth + 6) ~/ 7)
                                  .clamp(5, 6);
                          final gridHeight =
                              cellHeight * rowCount + rowGap * (rowCount - 1);
                          return SizedBox(
                            height: gridHeight,
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification.metrics.axis ==
                                    Axis.horizontal) {
                                  if (notification
                                      is ScrollUpdateNotification) {
                                    _onMonthScroll();
                                  } else if (notification
                                      is ScrollEndNotification) {
                                    _onMonthScrollEnd();
                                  }
                                }
                                return false;
                              },
                              child: Stack(
                                fit: StackFit.expand,
                                clipBehavior: Clip.hardEdge,
                                children: [
                                  PageView.builder(
                                    controller: _monthController,
                                    physics: const PageScrollPhysics(
                                      parent: BouncingScrollPhysics(),
                                    ),
                                    onPageChanged: (page) {
                                      _page = page;
                                      final month = _monthForPage(page);
                                      final now = DateTime.now();
                                      final isCurrentMonth =
                                          month.year == now.year &&
                                              month.month == now.month;
                                      _selectedDate = isCurrentMonth
                                          ? DateTime(
                                              now.year, now.month, now.day)
                                          : DateTime(
                                              month.year, month.month, 1);
                                      _lastPagePosition = page.toDouble();
                                      setState(() {});
                                    },
                                    itemBuilder: (context, page) => _MonthGrid(
                                      month: _monthForPage(page),
                                      today: today,
                                      selectedDate: _selectedDate,
                                      selectionAnimationKey: _selectionAnimationKey,
                                      cellHeight: cellHeight,
                                      lunarLabel: _lunarLabel,
                                  onSelect: (date) {
                                    setState(() {
                                      _selectedDate = date;
                                      _selectionAnimationKey++;
                                    });
                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(SnackBar(
                                            content: Text(
                                                '已选择  ${DateFormat('yyyy年M月d日').format(date)}'),
                                            duration: const Duration(
                                                milliseconds: 900),
                                          ));
                                      },
                                    ),
                                  ),
                                  _SelectionOverlay(
                                    month: _month,
                                    selectedDate: _selectedDate,
                                    cellWidth: cellWidth,
                                    cellHeight: cellHeight,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                sliver: SliverToBoxAdapter(
                  child: _AlmanacCard(month: _month),
                ),
              ),
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 24),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Expanded(
                          child: _FeatureCard(
                              icon: '☁', title: '天气', subtitle: '查看未来天气')),
                      SizedBox(width: 10),
                      Expanded(
                          child: _FeatureCard(
                              icon: '▣', title: '查吉日', subtitle: '择日与提醒')),
                      SizedBox(width: 10),
                      Expanded(
                          child: _FeatureCard(
                              icon: '午', title: '时辰', subtitle: '今日宜忌')),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _lunarLabel(int day) {
    const labels = ['初一', '初二', '初三', '初四', '初五', '初六', '初七', '初八', '初九', '初十'];
    return labels[(day - 1) % labels.length];
  }

  @override
  bool get wantKeepAlive => true;
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid(
      {required this.month,
      required this.today,
      required this.selectedDate,
      required this.selectionAnimationKey,
      required this.cellHeight,
      required this.lunarLabel,
      required this.onSelect});

  final DateTime month;
  final DateTime today;
  final DateTime selectedDate;
  final int selectionAnimationKey;
  final double cellHeight;
  final String Function(int day) lunarLabel;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final leadingDays = firstDay.weekday % 7;
    final itemCount = ((leadingDays + daysInMonth + 6) ~/ 7) * 7;
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 2,
        mainAxisSpacing: 5,
        mainAxisExtent: cellHeight,
      ),
      itemBuilder: (context, index) {
        final date = DateTime(month.year, month.month, index - leadingDays + 1);
        final isOutsideMonth = date.month != month.month;
        return _DayCell(
          day: date.day,
          lunar: lunarLabel(date.day),
          isToday: !isOutsideMonth && DateUtils.isSameDay(date, today),
          isSelected: DateUtils.isSameDay(date, selectedDate),
          selectionAnimationKey: selectionAnimationKey,
          isOutsideMonth: isOutsideMonth,
          isWeekend: date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday,
          onTap: () => onSelect(date),
        );
      },
    );
  }
}

class _SelectionOverlay extends StatelessWidget {
  const _SelectionOverlay(
      {required this.month,
      required this.selectedDate,
      required this.cellWidth,
      required this.cellHeight});

  final DateTime month;
  final DateTime selectedDate;
  final double cellWidth;
  final double cellHeight;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(month.year, month.month, 1);
    final selectedInMonth =
        selectedDate.year == month.year && selectedDate.month == month.month;
    final day = selectedInMonth ? selectedDate.day : 1;
    final index = firstDay.weekday % 7 + day - 1;
    final left = (index % 7) * (cellWidth + 2);
    final top = (index ~/ 7) * (cellHeight + 5);
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      left: left,
      top: top,
      width: cellWidth,
      height: cellHeight,
      child: IgnorePointer(
        child: SizedBox(
          width: cellWidth,
          height: cellHeight,
          child: CustomPaint(
            painter: _SelectionBorderPainter(),
          ),
        ),
      ),
    );
  }
}

class _SelectionBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(5),
    );
    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CalendarHeader extends StatelessWidget {
  const _CalendarHeader(
      {required this.month,
      required this.onPrevious,
      required this.onNext,
      required this.onToday});

  final DateTime month;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onToday;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 12, 14, 0),
      decoration: const BoxDecoration(color: AppTheme.primary),
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            const Icon(Icons.spa_outlined, color: Colors.white, size: 26),
            const SizedBox(width: 6),
            const Flexible(
              child: Text('养生日历',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: onPrevious,
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(minWidth: 24, minHeight: 24),
                          icon: const Icon(Icons.chevron_left, size: 24)),
                      Flexible(
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(DateFormat('yyyy年MM月').format(month),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700)))),
                      IconButton(
                          onPressed: onNext,
                          color: Colors.white,
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(minWidth: 24, minHeight: 24),
                          icon: const Icon(Icons.chevron_right, size: 24)),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: onToday,
                color: Colors.white,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 30, minHeight: 40),
                icon: const Icon(Icons.today_outlined, size: 21)),
            IconButton(
                onPressed: onNext,
                color: Colors.white,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 30, minHeight: 40),
                icon: const Icon(Icons.add, size: 26)),
          ],
        ),
      ),
    );
  }
}

class _Weekday extends StatelessWidget {
  const _Weekday(this.label, {this.isWeekend = false});
  final String label;
  final bool isWeekend;
  @override
  Widget build(BuildContext context) => SizedBox(
      width: 38,
      child: Text(label,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color:
                  isWeekend ? const Color(0xFFC83D3D) : const Color(0xFF333333),
              fontWeight: FontWeight.w600)));
}

class _DayCell extends StatelessWidget {
  const _DayCell(
      {required this.day,
      required this.lunar,
      required this.isToday,
      required this.isSelected,
      required this.selectionAnimationKey,
      required this.isOutsideMonth,
      required this.isWeekend,
      required this.onTap});
  final int day;
  final String lunar;
  final bool isToday;
  final bool isSelected;
  final int selectionAnimationKey;
  final bool isOutsideMonth;
  final bool isWeekend;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.transparent, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 26,
              child: TweenAnimationBuilder<double>(
                key: ValueKey('$day-$selectionAnimationKey'),
                tween: Tween(begin: isSelected ? 0.22 : 1.0, end: 1.0),
                duration: const Duration(milliseconds: 720),
                curve: Curves.elasticOut,
                builder: (context, scale, child) => Transform.scale(
                  scale: scale,
                  child: child,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text('$day',
                      style: TextStyle(
                          fontSize: isToday ? 31 : 27,
                          height: 1,
                          fontWeight:
                              isToday ? FontWeight.w700 : FontWeight.w500,
                          color: isOutsideMonth
                              ? (isWeekend
                                  ? const Color(0xFFC83D3D)
                                      .withValues(alpha: 0.25)
                                  : Colors.black.withValues(alpha: 0.15))
                              : isWeekend
                                  ? const Color(0xFFC83D3D)
                                  : Colors.black)),
                ),
              ),
            ),
            const SizedBox(height: 1),
            SizedBox(
              height: 17,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(lunar,
                    style: TextStyle(
                        fontSize: 14,
                        color: isOutsideMonth
                            ? (isWeekend
                                ? const Color(0xFFC83D3D)
                                    .withValues(alpha: 0.45)
                                : Colors.black.withValues(alpha: 0.25))
                            : isToday
                                ? const Color(0xFFD9342B)
                                : const Color(0xFF444444))),
              ),
            ),
            SizedBox(
              height: 10,
              child: Text(isToday ? '今' : '',
                  style:
                      const TextStyle(fontSize: 10, color: Color(0xFFD9342B))),
            ),
          ]),
        ),
      );
}

class _AlmanacCard extends StatelessWidget {
  const _AlmanacCard({required this.month});
  final DateTime month;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
        decoration: BoxDecoration(
            color: const Color(0xFFFFF8E9),
            borderRadius: BorderRadius.circular(18)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(DateFormat('M月节气').format(month),
                style: const TextStyle(
                    color: Color(0xFFC7352E),
                    fontFamily: 'serif',
                    fontSize: 27,
                    fontWeight: FontWeight.w700)),
            const Spacer(),
            OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF8D563D),
                    side: const BorderSide(color: Color(0xFFE9D5B9)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                child: const Text('日程查询 ›'))
          ]),
          const SizedBox(height: 8),
          const Text('• 今日宜静心  • 适合记录重要安排',
              style: TextStyle(color: Color(0xFF77716A), fontSize: 15)),
          const SizedBox(height: 8),
          const Text('宜  规划 · 读书 · 会友        忌  熬夜 · 忘记提醒',
              style: TextStyle(fontSize: 14, color: Color(0xFF4B4844))),
        ]),
      );
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard(
      {required this.icon, required this.title, required this.subtitle});
  final String icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(children: [
        Text(icon, style: const TextStyle(fontSize: 25)),
        const SizedBox(height: 7),
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 3),
        Text(subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: Colors.black54))
      ]));
}
