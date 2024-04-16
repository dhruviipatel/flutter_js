import 'package:flutter/material.dart';
import 'package:smart_snackbars/smart_snackbars.dart';

class SnackbarTest extends StatelessWidget {
  const SnackbarTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              SmartSnackBars.showCustomSnackBar(
                context: context,
                duration: const Duration(milliseconds: 1000),
                animationCurve: Curves.ease,
                child: Center(
                  child: Row(
                    children: [
                      Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            const SizedBox(width: 10),
                            const Text(
                              "Data is deleted",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              );
            },
            child: Text("click")),
      ),
    );
  }
}
