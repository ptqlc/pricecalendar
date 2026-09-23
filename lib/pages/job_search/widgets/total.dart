part of '../index.dart';

class BuildTotal extends StatelessWidget {
  const BuildTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      minimum: EdgeInsets.symmetric(
        horizontal: AppTheme.margin,
        vertical: 5.w,
      ),
      child: Row(
        children: [
          Text(
            'Result',
            style: TextStyle(
              fontSize: 20.w,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              '489',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 16.w, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          SizedBox(width: 5.w),
          Text(
            'founds',
            style: TextStyle(
              fontSize: 16.w,
            ),
          ),
        ],
      ),
    );
  }
}
