import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testproject/core/extentions/extention.dart';
import 'package:testproject/features/login/presentation/bloc/login_bloc.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({super.key, this.title, this.bloc});
  final String? title;
  final LoginBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.screenwidth * 0.8,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        onPressed: () async {
          if (bloc?.username != null &&
              bloc!.username!.length > 3 &&
              bloc?.password != null &&
              bloc!.password!.length > 3 &&
              await bloc?.toDoPreferences.getUsername() != null &&
              await bloc?.toDoPreferences.getUsername() == bloc?.username &&
              await bloc?.toDoPreferences.getPass() != null &&
              await bloc?.toDoPreferences.getPass() == bloc?.password) {
            context.go('/todo');
            // bloc?.add(
            //   Login(
            //     params: LoginParams(
            //       username: bloc?.username ?? '',
            //       password: bloc?.password ?? '',
            //     ),
            //   ),
            // );
          } else {
            final overlay = Overlay.of(context);
            final overlayEntry = overlayDialog();

            overlay.insert(overlayEntry);

            Future.delayed(Duration(seconds: 4), () {
              overlayEntry.remove();
            });
          }
        },
        child:
            bloc?.state is LoginLoading
                ? CupertinoActivityIndicator(color: Colors.black)
                : Text(
                  title ?? 'Sign in',
                  style: TextStyle(color: Colors.white),
                ),
      ),
    );
  }

  //! cupertino dialog
  OverlayEntry overlayDialog() {
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
                    Expanded(
                      child: Text(
                        'Please enter valid username and password',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: CupertinoTheme.of(context).textTheme.textStyle
                            .copyWith(color: CupertinoColors.destructiveRed),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
