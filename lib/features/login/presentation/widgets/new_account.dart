import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewAccount extends StatelessWidget {
  const NewAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              context.go('/register');
            },
            child: Text(
              'You do not have an account?',
              style: TextStyle(
                color: Colors.white.withAlpha(700),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
