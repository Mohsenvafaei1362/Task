import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testproject/core/network/di/di.dart';
import 'package:testproject/features/login/presentation/bloc/login_bloc.dart';
import 'package:testproject/features/login/presentation/widgets/button.dart';
import 'package:testproject/features/login/presentation/widgets/new_account.dart';
import 'package:testproject/features/login/presentation/widgets/text_field.dart';
import 'package:testproject/features/login/presentation/widgets/title_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late LoginBloc bloc;
  @override
  void initState() {
    bloc = getIt<LoginBloc>();
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          return;
        }
      },

      child: BlocProvider(
        create: (context) => bloc,
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.go('/todo');
            }
            if (state is DataError) {
              final overlay = Overlay.of(context);
              final overlayEntry = overlayDialog(state);

              overlay.insert(overlayEntry);

              Future.delayed(Duration(seconds: 4), () {
                overlayEntry.remove();
              });
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TitlePage(),
                    const SizedBox(height: 30),
                    TextFieldWidget(
                      labelText: 'Username',
                      onChanged: (value) {
                        bloc.username = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      labelText: 'password',
                      onChanged: (value) {
                        bloc.password = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    WidgetButton(bloc: bloc),
                    const SizedBox(height: 20),
                    NewAccount(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  //! cupertino dialog
  OverlayEntry overlayDialog(DataError state) {
    return OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            child: CupertinoPopupSurface(
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: CupertinoColors.systemTeal.withAlpha(20),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: CupertinoColors.systemGrey.withOpacity(0.2),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      CupertinoIcons.clear_thick_circled,
                      color: CupertinoColors.destructiveRed,
                    ),
                    SizedBox(width: 8),
                    Text(
                      state.message ?? 'Error',
                      style: CupertinoTheme.of(context).textTheme.textStyle
                          .copyWith(color: CupertinoColors.destructiveRed),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
