part of 'index.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;
  final List<Color>? gradientColors;
  final Color? borderColor;
  final bool showBorder;
  final Color? shadowColor;
  final double? width;
  final double? height;
  final Clip clipBehavior;
  final void Function()? onTap;

  const CustomCard(
      {super.key,
      this.child,
      this.gradientColors,
      this.borderColor,
      this.showBorder = true,
      this.shadowColor,
      this.width,
      this.height,
      this.onTap,
      this.clipBehavior = Clip.none});

  factory CustomCard.job({
    Key? key,
    required Widget title,
    Widget? subtitle,
    Widget? label,
    Widget? salary,
    Widget? bottom,
    Widget? tag,
    bool? isCollect,
    String? image,
    void Function()? onTap,
  }) = _CardWithJob;

  factory CustomCard.chat({
    Key? key,
    required Widget nickname,
    String? avatar,
    Widget? label,
    List<Widget> actions,
    List<Widget> operate,
    int? count,
    int? timestamp,
    void Function()? onTap,
  }) = _CardWithChat;

  factory CustomCard.icon({
    Key? key,
    required Widget icon,
    Widget? text,
    Widget? label,
    Color? borderColor,
    Axis direction,
    void Function()? onTap,
  }) = _CardWithIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        clipBehavior: clipBehavior,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.all(Radius.circular(20.w)),
          border: showBorder
              ? Border.all(
                  color: borderColor ?? Theme.of(context).colorScheme.outline,
                  width: 1.w,
                )
              : null,
          gradient: gradientColors != null
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors!,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Theme.of(context).colorScheme.shadow,
              offset: Offset(0, 20.w),
              blurRadius: 10.w,
              spreadRadius: -10.w,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}

class _CardWithJob extends CustomCard {
  final Widget title;
  final Widget? subtitle;
  final Widget? label;
  final Widget? salary;
  final Widget? bottom;
  final Widget? tag;
  final bool? isCollect;
  final String? image;

  _CardWithJob({
    super.key,
    required this.title,
    this.subtitle,
    this.label,
    this.salary,
    this.bottom,
    this.tag,
    this.isCollect,
    this.image,
    super.onTap,
  }) : super(
          child: _CardWithJobChild(
            image: image,
            title: title,
            subtitle: subtitle,
            label: label,
            salary: salary,
            bottom: bottom,
            tag: tag,
            isCollect: isCollect,
          ),
        );
}

class _CardWithJobChild extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? label;
  final Widget? salary;
  final Widget? bottom;
  final Widget? tag;
  final bool? isCollect;
  final String? image;

  const _CardWithJobChild({
    required this.title,
    this.subtitle,
    this.label,
    this.salary,
    this.isCollect,
    this.image,
    this.bottom,
    this.tag,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    var body = <Widget>[];
    if (subtitle != null || label != null) {
      body.add(SizedBox(height: label == null ? 10.w : 5.w));
      if (subtitle != null) body.add(_buildSubtitle(colorScheme));
      body.add(SizedBox(height: subtitle == null ? 0 : 3.w));
      if (label != null) body.add(_buildLabel(colorScheme));
    }
    if (salary != null) {
      body = [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: body,
              ),
            ),
            _buildSalary(colorScheme),
          ],
        ),
      ];
    }

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CustomImage.network(
                    url: image ?? '',
                    width: 60.w,
                    height: 60.w,
                    radius: 8.w,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: isCollect != null ? 16.w + 24.w : 0,
                          ),
                          child: _buildTitle(colorScheme),
                        ),
                        ...body,
                      ],
                    ),
                  ),
                ],
              ),
              if (bottom != null) Divider(height: 32.w),
              if (bottom != null) bottom!,
            ],
          ),
        ),
        if (isCollect != null)
          Positioned(
            right: 0,
            top: 0,
            child: _buildCollect(colorScheme),
          ),
      ],
    );
  }

  Widget _buildTitle(ColorScheme colorScheme) {
    Widget text = DefaultTextStyle.merge(
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: subtitle == null || label == null ? 20.w : 18.w,
        color: colorScheme.onSurface,
      ),
      child: title,
    );
    if (tag == null) return text;
    text = Expanded(child: text);
    text = Row(
      children: [
        text,
        DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 14.w,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
          child: tag!,
        ),
      ],
    );
    return text;
  }

  Widget _buildSubtitle(ColorScheme colorScheme) {
    if (subtitle == null) return const SizedBox.shrink();
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: label == null ? 16.w : 13.w,
        color: colorScheme.onSurface.withValues(alpha: 0.9),
      ),
      child: subtitle!,
    );
  }

  Widget _buildLabel(ColorScheme colorScheme) {
    if (label == null) return const SizedBox.shrink();
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontSize: subtitle == null ? 13.w : 11.w,
        color: colorScheme.onSurface.withValues(alpha: 0.5),
      ),
      child: label!,
    );
  }

  Widget _buildSalary(ColorScheme colorScheme) {
    if (salary == null) return const SizedBox.shrink();
    return DefaultTextStyle.merge(
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 18.w,
        color: colorScheme.primary,
      ),
      child: salary!,
    );
  }

  Widget _buildCollect(ColorScheme colorScheme) {
    if (isCollect == null) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Icon(
        isCollect! ? Ionicons.bookmark : Ionicons.bookmark_outline,
        size: 24.w,
        color: colorScheme.primary,
      ),
    );
  }
}

class _CardWithChat extends CustomCard {
  final Widget nickname;
  final Widget? label;
  final String? avatar;
  final List<Widget> actions;
  final List<Widget> operate;
  final int? count;
  final int? timestamp;

  _CardWithChat({
    super.key,
    required this.nickname,
    this.avatar,
    this.label,
    this.actions = const [],
    this.operate = const [],
    this.count,
    this.timestamp,
    super.onTap,
  }) : super(
          child: _CardWithChatChild(
            nickname: nickname,
            avatar: avatar,
            label: label,
            actions: actions,
            operate: operate,
            count: count,
            timestamp: timestamp,
          ),
        );
}

class _CardWithChatChild extends StatelessWidget {
  final Widget nickname;
  final String? avatar;
  final Widget? label;
  final List<Widget> actions;
  final List<Widget> operate;
  final int? count;
  final int? timestamp;

  const _CardWithChatChild({
    required this.nickname,
    this.actions = const [],
    this.operate = const [],
    this.count,
    this.label,
    this.timestamp,
    this.avatar,
  });

  String get _time {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp ?? 0);
    return '${dateTime.hour}:${dateTime.minute}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final rightActions = <Widget>[];
    final bottomOperate = <Widget>[];
    final body = <Widget>[];
    if (label != null) {
      body.add(SizedBox(height: 5.w));
      body.add(DefaultTextStyle.merge(
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16.w,
          color: colorScheme.onSurface.withValues(alpha: 0.7),
          height: 1.2,
        ),
        child: timestamp != null
            ? Row(
                children: [
                  Expanded(child: label!),
                  SizedBox(width: 12.w),
                  Text(_time),
                ],
              )
            : label!,
      ));
    }
    for (var element in actions) {
      rightActions.add(SizedBox(width: 16.w));
      rightActions.add(element);
    }
    for (var index = 0; index < operate.length; index++) {
      if (index != 0) bottomOperate.add(SizedBox(width: 16.w));
      bottomOperate.add(Expanded(child: operate[index]));
    }
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.w, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  CustomAvatar.medium(url: avatar ?? ''),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            right: (count ?? 0) > 0 ? 22.w + 12.w : 0,
                          ),
                          child: DefaultTextStyle.merge(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.w,
                              color: colorScheme.onSurface,
                              height: 1.2,
                            ),
                            child: nickname,
                          ),
                        ),
                        ...body,
                      ],
                    ),
                  ),
                  ...rightActions,
                ],
              ),
              if (operate.isNotEmpty) Divider(height: 32.w),
              Row(children: bottomOperate),
            ],
          ),
        ),
        if ((count ?? 0) > 0)
          Positioned(
            right: 16.w,
            top: 16.w,
            child: _buildCount(),
          ),
      ],
    );
  }

  Widget _buildCount() {
    return Container(
      width: 22.w,
      height: 22.w,
      alignment: Alignment.center,
      decoration: const ShapeDecoration(
        color: AppTheme.error,
        shape: CircleBorder(),
      ),
      child: Text(
        count! > 100 ? '99' : count.toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: 13.w,
          height: 1.2,
        ),
      ),
    );
  }
}

class _CardWithIcon extends CustomCard {
  final Widget icon;
  final Widget? text;
  final Widget? label;
  final Axis direction;

  _CardWithIcon({
    super.key,
    required this.icon,
    this.text,
    this.label,
    this.direction = Axis.vertical,
    super.borderColor,
    super.onTap,
  }) : super(
          child: _CardWithIconChild(
            icon: icon,
            text: text,
            label: label,
            direction: direction,
          ),
        );
}

class _CardWithIconChild extends StatelessWidget {
  final Widget icon;
  final Widget? text;
  final Widget? label;
  final Axis direction;

  const _CardWithIconChild({
    required this.icon,
    this.text,
    this.label,
    this.direction = Axis.vertical,
  });

  EdgeInsetsGeometry get _padding {
    if (direction == Axis.horizontal) return EdgeInsets.all(20.w);
    return EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    Widget child = Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: colorScheme.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: IconTheme(
        data: IconThemeData(color: colorScheme.primary, size: 32.w),
        child: icon,
      ),
    );
    final ws = [child];
    if (direction == Axis.vertical) {
      if (text != null || label != null) ws.add(SizedBox(height: 12.w));
      if (text != null) {
        ws.add(DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.w),
          child: text!,
        ));
      }
      if (text != null && label != null) ws.add(SizedBox(height: 6.w));
      if (label != null) {
        ws.add(DefaultTextStyle.merge(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.w,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          child: label!,
        ));
      }
      child = Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: ws,
      );
    } else {
      Widget? textChild;
      Widget? labelChild;
      if (text != null) {
        textChild = DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 18.w,
            fontWeight: FontWeight.w600,
          ),
          child: text!,
        );
      }
      if (label != null) {
        labelChild = DefaultTextStyle.merge(
          style: TextStyle(
            fontSize: 15.w,
            color: colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          child: label!,
        );
      }
      if (text != null || label != null) ws.add(SizedBox(width: 20.w));
      if (textChild != null && labelChild != null) {
        ws.add(Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [labelChild, SizedBox(height: 6.w), textChild],
          ),
        ));
      } else if (textChild != null) {
        ws.add(Expanded(child: textChild));
      } else if (labelChild != null) {
        ws.add(Expanded(child: labelChild));
      }
      child = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: ws,
      );
    }
    return Padding(padding: _padding, child: child);
  }
}
