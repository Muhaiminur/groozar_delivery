import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/singleton/shared_pref.dart';
import '../core/utility/customStrings.dart';
import '../core/utility/routes.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      if (kReleaseMode) {
        //versionCheck(context);
        navigatePage(context);
      } else {
        navigatePage(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image.asset(
        "assets/images/ic_splash.png",
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }

  Future<void> navigatePage(BuildContext context) async {
    String logged = SharedPref.getString(CustomStrings().token) ?? "";
    if (Platform.isAndroid) {
      SharedPref.setString(CustomStrings().deviceType, CustomStrings().android);
    } else if (Platform.isIOS) {
      SharedPref.setString(CustomStrings().deviceType, CustomStrings().ios);
    }
    if (logged.isEmpty) {
      Navigator.pushReplacementNamed(context, welcomePage);
    } else {
      Navigator.pushReplacementNamed(context, welcomePage);
    }
  }

  /*versionCheck(context) async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    int currentVersion = int.parse(info.buildNumber);
    Log().printInfo("currentVersionName:${info.version}");
    Log().printInfo("currentVersionCode :${info.buildNumber}");
    final remoteConfig = FirebaseRemoteConfig.instance;
    try {
      await remoteConfig.fetchAndActivate();
      int newAndroidVersion = int.parse(
        remoteConfig.getString('android_force_update_remote_version'),
      );
      int newIosVersion = int.parse(
        remoteConfig.getString('ios_force_update_remote_version'),
      );
      Log().printInfo("RemoteVersionCode :$newAndroidVersion");
      Platform.isAndroid
          ? newAndroidVersion > currentVersion
              ? _showVersionDialog(
                context,
                remoteConfig.getString('update_playStore_link'),
                remoteConfig.getBool("forceUpdate"),
              )
              : navigatePage(context)
          : newIosVersion > currentVersion
          ? _showVersionDialog(
            context,
            remoteConfig.getString('update_appStore_link'),
            remoteConfig.getBool("forceUpdate"),
          )
          : navigatePage(context);
    } catch (exception) {
      Log().printInfo(
        'Unable to fetch remote config. Cached or default values will be used',
      );
    }
  }

  _showVersionDialog(c, String updateLink, bool forceUpdate) async {
    await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Set your radius here
          ),
          backgroundColor: ProjectColors().white,
          title: Text(
            "New Update Available",
            textAlign: TextAlign.center,
            style: TextStyle(color: ProjectColors().primaryColor, fontSize: 20),
          ),
          content: Text(
            "There is a newer version available. Please update it.",
            textAlign: TextAlign.center,
          ),
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          contentTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          actions: [
            Row(
              children: [
                !forceUpdate
                    ? Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(ctx, false);
                          navigatePage(c);
                        },
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: ProjectColors().white,
                            borderRadius: BorderRadius.circular(34),
                            border: Border.all(
                              width: 1,
                              color: ProjectColors().black,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close,
                                size: 20,
                                color: ProjectColors().black,
                              ),
                              SizedBox(width: 4),
                              Text("Later"),
                            ],
                          ),
                        ),
                      ),
                    )
                    : SizedBox(),
                SizedBox(width: !forceUpdate ? 10 : 0),
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      _launchURL(updateLink);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: ProjectColors().white,
                        borderRadius: BorderRadius.circular(34),
                        border: Border.all(
                          width: 1,
                          color: ProjectColors().primaryColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.check,
                            size: 20,
                            color: ProjectColors().primaryColor,
                          ),
                          SizedBox(width: 4),
                          Text(
                            "Update",
                            style: TextStyle(
                              color: ProjectColors().primaryColor,
                            ),
                          ),
                        ],
                      ),
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

  _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }*/
}
