import 'package:flutter/material.dart';

import '../../../core/singleton/shared_pref.dart';
import '../../../core/utility/custom_appbar.dart';
import '../../core/utility/colors.dart';
import '../../core/utility/customStrings.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  NotificationPageScreenState createState() => NotificationPageScreenState();
}

class NotificationPageScreenState extends State<NotificationPage> {
  String logged = "";

  @override
  void initState() {
    super.initState();
    _loadHomeData(isReload: false);
  }

  _loadHomeData({required bool isReload}) {
    logged = SharedPref.getString(CustomStrings().token);
    //context.read<CartProvider>().showCart();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Set
        child: CustomAppBar(
          title: "Notifications",
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: RefreshIndicator(
        color: ProjectColors().white,
        backgroundColor: ProjectColors().primaryColor,
        strokeWidth: 1.0,
        onRefresh: _handleRefresh,
        child: SingleChildScrollView(
          child: Container(
            color: ProjectColors().primaryColor,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: ProjectColors().white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Column(spacing: 5, children: []),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    _loadHomeData(isReload: true);
  }
}
