import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testproject/core/utils/colors.dart';
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
        backgroundColor: BACKGROUND_GRAY_COLOR_ICON.withValues(alpha: .5),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TitlePage(title: 'Register Page'),
              const SizedBox(height: 20),
              TextFieldWidget(labelText: 'Username'),
              const SizedBox(height: 20),
              TextFieldWidget(labelText: 'password'),
              const SizedBox(height: 40),
              WidgetButton(title: 'Register'),
            ],
          ),
        ),
      ),
    );
  }
}
