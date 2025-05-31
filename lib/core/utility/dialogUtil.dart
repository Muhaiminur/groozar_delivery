import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'colors.dart';
import 'customStrings.dart';

class DialogUtils {
  static Future<bool> showNormalDialog(
    BuildContext context, {
    String? title,
    required String message,
    required String yesText,
    required String noText,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext con) {
        return Dialog(
          alignment: Alignment.center,
          insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5), // Reduce roundness
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Controls content padding
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevent unnecessary space
              children: [
                getTitle(title),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 10, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(message, textAlign: TextAlign.left),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // Align actions to the right
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(con).pop(true);
                      },
                      child: Text(yesText, style: TextStyle(color: Colors.red)),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(con).pop(false);
                      },
                      child: Text(noText),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
    return result ?? false; // Return false if dismissed
  }

  static Future<void> showBigDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String icon,
    required Color titleColor,
  }) async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Set your radius here
          ),
          backgroundColor: ProjectColors().white,
          icon: SvgPicture.asset(icon, height: 40, width: 40),
          title: Text(title, style: TextStyle(color: titleColor, fontSize: 20)),
          content: Text(message, textAlign: TextAlign.center),
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          contentTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctx, false);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.minPositive, 40),
                      backgroundColor: Color(0xFFF4F4F4),
                      // Gray background
                      foregroundColor: Colors.white,
                      // Text color
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ), // Optional: rounded corners
                    ),
                    child: Text(
                      CustomStrings().close,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  static Future<bool> showBigDialogWithButtons(
    BuildContext context, {
    required String title,
    required String message,
    required String icon,
    required Color titleColor,
    required String leftButtonText,
    required Color leftButtonColor,
    required String rightButtonText,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Set your radius here
          ),
          backgroundColor: ProjectColors().white,
          icon: SvgPicture.asset(icon, height: 40, width: 40),
          title: Text(title, style: TextStyle(color: titleColor, fontSize: 20)),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(color: ProjectColors().black),
          ),
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          actionsPadding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          contentTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctx, true);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.minPositive, 40),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ), // Padding
                    ),
                    child: Text(
                      leftButtonText,
                      style: TextStyle(color: leftButtonColor),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(ctx, false);
                    },
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.minPositive, 40),
                      backgroundColor: Color(0xFFF4F4F4),
                      // Gray background
                      foregroundColor: Colors.white,
                      // Text color
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      // Padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ), // Optional: rounded corners
                    ),
                    child: Text(
                      rightButtonText,
                      style: TextStyle(color: ProjectColors().black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    return result ?? false; // Return true if the user chose to exit
  }

  static getTitle(String? title) {
    if (title == null || title.isEmpty) {
      return Visibility(visible: false, child: SizedBox());
    } else {
      return Visibility(
        visible: true,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 10, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      );
    }
  }
}
