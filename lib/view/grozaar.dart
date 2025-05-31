import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grozaar_delivery/view/splash_screen.dart';
import 'package:provider/provider.dart';
import '../core/utility/keys.dart';
import '../core/utility/route_observer.dart';
import '../core/utility/routes.dart';

class Grozaar extends StatefulWidget {
  Grozaar({super.key});

  @override
  _GrozaarState createState() => _GrozaarState();
}

class _GrozaarState extends State<Grozaar> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MyRouteObserver routeObserver = MyRouteObserver();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: MultiProvider(
        providers: [
          /*ChangeNotifierProvider(create: (_) => CommonProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),*/
        ],
        child: MaterialApp(
          navigatorObservers: [routeObserver],
          navigatorKey: GlobalVariableKeys.navigatorState,
          //theme: iFarmerTheme(Brightness.light),
          initialRoute: splash,
          routes: {
            splash: (context) => const Splash(),
            /*welcomePage: (context) => const WelcomePage(),
            homePage: (context) => const HomePage(),
            mainPage: (context) => const MainPage(),
            categoryPage: (context) => const CategoryPage(),
            categoryProductPage:
                (context) => CategoryProductPage(
                  args: ModalRoute.of(context)!.settings.arguments as Map,
                ),
            productDetailsPage:
                (context) => ProductDetailsPage(
                  args: ModalRoute.of(context)!.settings.arguments as Map,
                ),
            cartPage: (context) => const CartPage(),
            checkoutPage: (context) => const CheckoutPage(),
            registrationPage: (context) => const RegistrationPage(),
            loginPage: (context) => const LoginPage(),
            profilePage: (context) => const CustomerProfilePage(),
            profileEditPage: (context) => const ProfileEditPage(),
            orderListPage: (context) => const OrderListPage(),
            promotionPage: (context) => const PromotionPage(),
            notificationPage: (context) => const NotificationPage(),
            orderDetailsPage:
                (context) => OrderDetailsPage(
              args: ModalRoute.of(context)!.settings.arguments as Map,
            ),*/
          },
        ),
      ),
    );
  }
}
