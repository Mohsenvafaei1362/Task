import 'package:flutter/material.dart';
import 'package:testproject/core/extentions/extention.dart';
import 'package:testproject/gen/assets.gen.dart';

class TitlePage extends StatelessWidget {
  const TitlePage({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text(
          //   title ?? 'Login Page',
          //   style: TextStyle(
          //     fontSize: 24,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.white.withAlpha(700),
          //   ),
          // ),
          Assets.images.logo4.image(
            width: context.screenwidth * 0.45,
            height: 160,
            color: Colors.white.withAlpha(200),
          ),
        ],
      ),
    );
  }
}
