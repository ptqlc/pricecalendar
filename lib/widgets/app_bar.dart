part of 'index.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    super.automaticallyImplyLeading,
    super.title,
    List<Widget>? actions,
    super.centerTitle,
    super.titleSpacing,
    super.backgroundColor,
    super.systemOverlayStyle,
  }) : super(
          actions: _buildActions(actions),
        );

  static List<Widget>? _buildActions(List<Widget>? items) {
    if ((items ?? []).isEmpty) return null;
    final ws = <Widget>[];
    for (var element in items!) {
      ws.add(Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: AppTheme.margin),
        child: element,
      ));
    }
    return ws;
  }
}
