import 'package:flutter/material.dart';

class Detail extends StatelessWidget {
  const Detail(
      {super.key,
      required this.title,
      this.value = '                 ',
      this.alignment = MainAxisAlignment.start,
      this.mobile = false});
  final String title;
  final String value;
  final bool mobile;
  final MainAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 12),
      child: FittedBox(
        child: Row(
          mainAxisAlignment: alignment,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 15,
                color: Colors.cyan.shade400,
              ),
            ),
            SizedBox(
              width: 260,
              child: Text(
                mobile ? '+91-$value' : value,
                softWrap: true,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
