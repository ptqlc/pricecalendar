part of '../index.dart';

class BuildMessageList<T, E> extends StatelessWidget {
  final List<T> items;
  final E Function(T value) groupBy;
  final bool Function(E left, E right) groupRange;
  final int Function(E left, E right) groupComparator;
  final Widget Function(T value) groupHeaderBuilder;
  final int Function(T left, T right) itemComparator;
  final Widget Function(BuildContext context, T value) itemBuilder;

  const BuildMessageList({
    super.key,
    required this.items,
    required this.groupBy,
    required this.groupRange,
    required this.groupComparator,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    required this.itemComparator,
  });

  bool _isSeparator(int index) => index.isOdd;

  List<T> _getSortedList() {
    final elements = items;
    elements.sort((left, right) {
      final compareResult = groupComparator(groupBy(left), groupBy(right));
      if (compareResult != 0) return compareResult;
      return itemComparator(left, right);
    });
    return elements;
  }

  @override
  Widget build(BuildContext context) {
    final sortedList = _getSortedList();
    return CustomScrollView(
      reverse: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final actualIndex = index ~/ 2;
            if (index == sortedList.length * 2 - 1) {
              return _buildGroupSeparator(sortedList[actualIndex]);
            }
            if (_isSeparator(index)) {
              final curr = groupBy(sortedList[actualIndex]);
              final prev = groupBy(sortedList[actualIndex + 1]);
              if (groupRange(curr, prev)) return const SizedBox.shrink();
              return _buildGroupSeparator(sortedList[actualIndex]);
            }
            return itemBuilder(context, sortedList[actualIndex]);
          }, childCount: sortedList.length * 2),
        ),
      ],
    );
  }

  Widget _buildGroupSeparator(T element) => groupHeaderBuilder(element);
}
