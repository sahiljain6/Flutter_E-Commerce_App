import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({
    super.key,
    required this.first,
    required this.second,
  });
  final Widget first;
  final Widget second;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Transform.scale(
              scaleY: 5,
              child: Image.asset(
                'assets/backgroundLogin.jpg',
                height: double.infinity,
              )),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.6),
                ]),
          ),
        ),
        first,
        second,
      ],
    );
  }
}
