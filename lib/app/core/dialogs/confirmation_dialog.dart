import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

class ConfirmationDialog extends StatelessWidget {
  final String message;
  final GestureTapCallback onConfirmPressed;
  final String title;

  const ConfirmationDialog({
    required this.onConfirmPressed,
    required this.message,
    required this.title,
    super.key,
  });

  static void showConfirmationDialog({
    required String message,
    required GestureTapCallback onConfirmPressed,
    required String title,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          onConfirmPressed: onConfirmPressed,
          title: title,
          message: message,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  child: Container(
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(UniconsLine.question_circle, color: Colors.blue[300], size: 50),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(title, style: TextStyle(color: Colors.grey[700], fontSize: 32)),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(message, style: TextStyle(color: Colors.grey[500], fontSize: 18)),
                            ),
                            const SizedBox(height: 32),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: OutlinedButton(
                                onPressed: () => Modular.to.pop(),
                                child: Text(
                                  'Não',
                                  style: TextStyle(color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: ElevatedButton(
                                onPressed: () => onConfirmPressed,
                                style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
                                child: const Text('Sim', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
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
