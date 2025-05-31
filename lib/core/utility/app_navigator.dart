import 'package:flutter/material.dart';

import '../singleton/logger.dart';

abstract class RouteNames {
  RouteNames._();

  static const String splash = "/splash";
  static const String loginChoose = '/login-choose';
  static const String login = '/login';
  static const String pilgrimRegistration = '/pilgrim-registration';
  static const String landing = '/';
  static const String home = '/home';
  static const String health = '/health';
  static const String flight = '/flight';
  static const String flightDetails = '/flight-details';
  static const String pinSet = '/pin-set';
  static const String accommodation = '/accommodation';
  static const String accommodationDetails = '/accommodation-details';

  static const String familyInvite = '/family-invite';
  static const String familyRegistration = '/family-registration';
  static const String otpVerify = '/otp-verify';
  static const String familyPinSet = '/family-pin-set';
  static const String selectAccount = '/select-account';

  static const String weather = '/weather';
  static const String kibla = '/kibla';
  static const String medicalRecords = '/medical-records';

  static const String itemList = '/items';
  static const String itemDetails = '/item-details';
  static const String guidancePage = '/guidance-page';
  static const String hajjGuidancePage = '/hajj-guidance-page';
  static const String hajjGuidanceDetailsPage = '/hajj-guidance-details-page';
  static const String harmainPage = '/harmain-page';
  static const String discoverPage = '/discover-page';
  static const String discoverDetailsPage = '/discover-details-page';
  static const String quranPage = '/quran-page';

  static const String sos = '/sos';

  static const String profile = '/profile';
  static const String familyProfile = '/family-profile';
  static const String walletPage = '/wallet-page';
  static const String tasbihPage = '/tasbih-page';
  static const String agencyPage = '/agency-page';
  static const String groupChat = '/group-chat';
}

abstract class AppNavigator {
  AppNavigator._();

  static final navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    Log().printInfo("Current Route==>> ${settings.name}");
    switch (settings.name) {
      case RouteNames.splash:
      //return MaterialPageRoute(builder: (_) => Splash());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
