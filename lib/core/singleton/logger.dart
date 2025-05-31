import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utility/colors.dart';
import '../utility/customStrings.dart';
import '../utility/keys.dart';

class Log {
  var logger = Logger();

  print(String msg) {
    if (!kReleaseMode) {
      logger.d(msg);
    }
  }

  printError(String msg) {
    if (!kReleaseMode) {
      logger.e(msg);
    }
  }

  printInfo(String msg) {
    if (!kReleaseMode) {
      logger.i(msg);
    }
  }

  showMessageToast({required String message, BuildContext? context}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: ProjectColors().primaryColor,
      fontSize: 16.0,
    );
  }

  Future<void> openWebsite(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  hideKeyBoard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  showConfirmDialog(String message) {
    var ctx = GlobalVariableKeys.navigatorState.currentContext!;
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      transitionDuration: Duration(milliseconds: 500),
      context: ctx,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Card(
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 24,
                    bottom: 8,
                    left: 24,
                    right: 24,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Update later",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        message,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 12),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            CustomStrings().ok,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: ProjectColors().primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ).animate(anim1),
          child: child,
        );
      },
    );
  }

  Future<Widget> permissionDialogWithIcon(
    BuildContext context,
    IconData iconData,
    String title,
    String desc,
  ) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => AppAlertDialog(
            onConfirm: () {
              Navigator.of(context).pop();
              //openAppSettings();
            },
            iconData: iconData,
            title: title,
            subtitle: desc,
          ),
    );
  }

  String getWeekday(int weekDay) {
    switch (weekDay) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
    }
    return "";
  }

  String getMonth(int month) {
    String result = '';
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }
    return result;
  }
}

class AppAlertDialog extends StatelessWidget {
  final Function onConfirm;
  final String title;
  final IconData iconData;
  final String subtitle;

  const AppAlertDialog({
    super.key,
    required this.iconData,
    required this.onConfirm,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Set your radius here
      ),
      backgroundColor: ProjectColors().white,
      icon: Visibility(
        visible: iconData != null,
        child: Icon(iconData, size: 48, color: ProjectColors().white),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(color: ProjectColors().white, fontSize: 20),
      ),
      content: Text(subtitle, textAlign: TextAlign.center),
      contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 16),
      actions: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  onConfirm();
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: ProjectColors().primaryColor,
                    borderRadius: BorderRadius.circular(34),
                    border: Border.all(width: 1, color: ProjectColors().white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, size: 20, color: ProjectColors().white),
                      SizedBox(width: 4),
                      Text(
                        CustomStrings().confirm,
                        style: TextStyle(color: ProjectColors().white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                }, // User does not want to exit
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: ProjectColors().white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: ProjectColors().black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, size: 20, color: ProjectColors().black),
                      SizedBox(width: 4),
                      Text(CustomStrings().cancel),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
