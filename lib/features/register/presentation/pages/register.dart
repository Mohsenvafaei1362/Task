import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testproject/features/login/presentation/widgets/button.dart';
import 'package:testproject/features/login/presentation/widgets/text_field.dart';
import 'package:testproject/features/login/presentation/widgets/title_page.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // از بسته شدن صفحه جلوگیری می‌کند
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // کاربر دکمه برگشت را فشار داده است
          context.go('/'); // به صفحه لاگین بروید
        }
      },

      child: Scaffold(
        backgroundColor: Color.fromARGB(210, 71, 71, 109),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitlePage(
                title: 'Create Account',
                subtitle: 'Please register to your account',
              ),
              const SizedBox(height: 20),
              TextFieldWidget(labelText: 'Username'),
              const SizedBox(height: 20),
              TextFieldWidget(labelText: 'password'),
              const SizedBox(height: 40),
              WidgetButton(title: 'Register'),
              const SizedBox(height: 40),
              TextButton(
                onPressed: () {
                  context.go('/');
                },
                child: Text(
                  'Sign in',
                  style: TextStyle(
                    color: CupertinoColors.activeBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
