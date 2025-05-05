import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:testproject/config/router/go_router.dart';
import 'package:testproject/config/theme/theme_data_manager.dart';
import 'package:testproject/core/network/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(environment: Env.dev);
  runApp(
    EasyDynamicThemeWidget(
      //! تنظیم حالت پیش‌فرض تم به حالت روشن (Light)
      initialThemeMode: ThemeMode.light,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'وب اپلیکیشن فلاتر',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      routerConfig: RouterPage.router,
    );
  }
}
