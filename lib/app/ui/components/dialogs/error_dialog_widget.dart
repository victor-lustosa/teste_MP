import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../buttons/icon_button_widget.dart';
import 'modal_close_button_widget.dart';

class ErrorDialogWidget extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onClose;

  const ErrorDialogWidget({
    super.key,
    required this.title,
    required this.message,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      clipBehavior: Clip.none,
      insetPadding: const EdgeInsets.all(3),
      contentPadding: const EdgeInsets.all(20),
      backgroundColor: Colors.red,
      content: IntrinsicHeight(
        child: Row(
          children: [
            const ModalCloseButtonWidget(),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    message,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (onClose != null) {
                        onClose!();
                      }
                    },
                    child: const SizedBox(
                        height: 28,
                        child: IconButtonWidget(
                            color: Colors.black26,
                            iOSIcon: CupertinoIcons.clear,
                            androidIcon: Icons.clear))),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<void> showCustomErrorDialog(
    {required BuildContext context,
    required String title,
    required String message,
    Function()? onClose}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.transparent,
    builder: (BuildContext context) {
      return Stack(
        children: [
          Positioned(
            bottom: 40,
            left: 13,
            right: 13,
            child: ErrorDialogWidget(
              title: title,
              message: message,
              onClose: onClose,
            ),
          ),
        ],
      );
    },
  );
}
