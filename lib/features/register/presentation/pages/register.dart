import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testproject/core/extentions/extention.dart';
import 'package:testproject/core/network/di/di.dart';
import 'package:testproject/features/login/presentation/widgets/text_field.dart';
import 'package:testproject/features/login/presentation/widgets/title_page.dart';
import 'package:testproject/features/register/domain/usecase/register_usecase.dart';
import 'package:testproject/features/register/presentation/bloc/register_bloc.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late RegisterBloc bloc;
  @override
  void initState() {
    bloc = getIt<RegisterBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.go('/');
        }
      },

      child: BlocProvider(
        create: (context) => bloc,
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccess) {
              context.go('/');
              final overlay = Overlay.of(context);
              final overlayEntry = overlayDialog(
                Text(
                  'Register Success',
                  style: CupertinoTheme.of(context).textTheme.textStyle
                      .copyWith(color: CupertinoColors.systemGreen),
                ),

                Icon(
                  CupertinoIcons.checkmark_alt_circle_fill,
                  color: CupertinoColors.systemGreen,
                ),
              );

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
                    TitlePage(
                      title: 'Create Account',
                      subtitle: 'Please register to your account',
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      labelText: 'Username',
                      onChanged: (value) {
                        bloc.toDoPreferences.saveUsername(value);
                        bloc.username = value;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      labelText: 'password',
                      onChanged: (value) {
                        bloc.toDoPreferences.savePass(value);
                        bloc.password = value;
                      },
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: context.screenwidth * 0.8,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                        ),
                        onPressed: () {
                          if (bloc.username != null &&
                              bloc.username!.length > 3 &&
                              bloc.password != null &&
                              bloc.password!.length > 3) {
                            bloc.add(
                              Registeration(
                                RegisterParams(
                                  firstName: bloc.username ?? '',
                                  lastName: bloc.password ?? '',
                                  age: 0,
                                ),
                              ),
                            );
                          } else {
                            final overlay = Overlay.of(context);
                            final overlayEntry = overlayDialog(
                              Text(
                                'Please enter valid data',
                                style: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.copyWith(
                                  color: CupertinoColors.destructiveRed,
                                ),
                              ),

                              Icon(
                                CupertinoIcons.clear_thick_circled,
                                color: CupertinoColors.destructiveRed,
                              ),
                            );

                            overlay.insert(overlayEntry);

                            Future.delayed(Duration(seconds: 4), () {
                              overlayEntry.remove();
                            });
                          }
                        },
                        child:
                            state is RegisterLoading
                                ? CupertinoActivityIndicator(
                                  color: Colors.black,
                                )
                                : Text(
                                  'Sign up',
                                  style: TextStyle(color: Colors.white),
                                ),
                      ),
                    ),

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
            );
          },
        ),
      ),
    );
  }

  //! cupertino popup dialog
  OverlayEntry overlayDialog(Widget message, Widget icon) {
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
                  children: [icon, SizedBox(width: 8), message],
                ),
              ),
            ),
          ),
    );
  }
}
