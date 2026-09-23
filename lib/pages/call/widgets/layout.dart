part of '../index.dart';

class BuildLayout extends StatelessWidget {
  final Widget infoChild;
  final Widget operateChild;

  const BuildLayout({
    super.key,
    required this.infoChild,
    required this.operateChild,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SafeArea(
          minimum: const EdgeInsets.all(AppTheme.margin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 7,
                child: infoChild,
              ),
              const Expanded(
                flex: 2,
                child: Visibility(
                  visible: false,
                  child: Center(
                    child: CustomAlert.error(
                      text: Text(
                        'Error info',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: operateChild,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
