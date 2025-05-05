import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testproject/core/extentions/extention.dart';
import 'package:testproject/features/login/domain/usecase/login_usecase.dart';
import 'package:testproject/features/login/presentation/bloc/login_bloc.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({super.key, this.title, this.bloc});
  final String? title;
  final LoginBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenwidth * 0.45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF8AB2A6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        onPressed: () {
          if (bloc?.username != null &&
              bloc!.username!.length > 3 &&
              bloc?.password != null &&
              bloc!.password!.length > 3) {
            bloc?.add(
              Login(
                params: LoginParams(
                  username: bloc?.username ?? '',
                  password: bloc?.password ?? '',
                ),
              ),
            );
          } else {
            final overlay = Overlay.of(context);
            final overlayEntry = OverlayEntry(
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
                              color: CupertinoColors.systemGrey.withOpacity(
                                0.2,
                              ),
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
                            Expanded(
                              child: Text(
                                'Please enter valid username and password',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: CupertinoTheme.of(
                                  context,
                                ).textTheme.textStyle.copyWith(
                                  color: CupertinoColors.destructiveRed,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
            );

            overlay.insert(overlayEntry);

            Future.delayed(Duration(seconds: 4), () {
              overlayEntry.remove();
            });
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text(
            //       'Please enter valid username and password',
            //       style: TextStyle(color: Colors.red),
            //     ),
            //     duration: const Duration(seconds: 2),
            //     backgroundColor: CULTURED_1,
            //   ),
            // );
          }
        },
        child:
            bloc?.state is LoginLoading
                ? CupertinoActivityIndicator(color: Colors.white)
                : Text(
                  title ?? 'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
      ),
    );
  }
}
