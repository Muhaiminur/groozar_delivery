import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/singleton/logger.dart';
import '../../../core/singleton/shared_pref.dart';
import '../../../core/utility/dialogUtil.dart';
import '../../../generated/assets.dart';
import '../../core/utility/colors.dart';
import '../../core/utility/customStrings.dart';
import '../authentication/login_screen.dart';
import 'home_screen.dart';

class MainPage extends StatefulWidget {
  final int? initialIndex;

  const MainPage({super.key, this.initialIndex});

  @override
  MainPageScreenState createState() => MainPageScreenState();
}

class MainPageScreenState extends State<MainPage> {
  String logged = "";
  PageController? _pageController;
  int _page = 0;
  GlobalKey btnKey = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    logged = SharedPref.getString(CustomStrings().token);
    _page = widget.initialIndex ?? 0;
    _pageController = PageController(initialPage: _page);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        //bool shouldExit = await exitDialog();
        bool shouldExit = await DialogUtils.showNormalDialog(
          context,
          message: CustomStrings().exit,
          yesText: CustomStrings().yes,
          noText: CustomStrings().no,
        );
        if (shouldExit) {
          //exiting app
          exit(0);
        } else {
          Log().print("User chose not to exit");
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: onPageChanged,
          controller: _pageController,
          children: [
            HomePage(),
            HomePage(),
            HomePage(),
            logged.isNotEmpty ? HomePage() : LoginPage(),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 0,
              elevation: 0,
              currentIndex: _page,
              onTap: (int index) {
                setState(() {
                  _page = index;
                });
                navigationTapped(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: NavItem(
                    iconString: Assets.imagesIcHome,
                    isSelected: 0 == _page,
                    label: CustomStrings().home,
                  ),
                  label: CustomStrings().home,
                ),
                BottomNavigationBarItem(
                  icon: NavItem(
                    iconString: Assets.imagesIcCategory,
                    isSelected: 1 == _page,
                    label: CustomStrings().categories,
                  ),
                  label: CustomStrings().categories,
                ),
                BottomNavigationBarItem(
                  icon: NavItem(
                    iconString: Assets.imagesIcFab,
                    isSelected: 2 == _page,
                    label: CustomStrings().favourite,
                  ),
                  label: CustomStrings().favourite,
                ),
                BottomNavigationBarItem(
                  icon: NavItem(
                    iconString: Assets.imagesIcUser,
                    isSelected: 3 == _page,
                    label: CustomStrings().profile,
                  ),
                  label: CustomStrings().profile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    _pageController?.animateToPage(
      page,
      duration: const Duration(milliseconds: 10),
      curve: Curves.ease,
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    super.key,
    required this.isSelected,
    required this.iconString,
    required this.label,
  });

  final bool isSelected;
  final String label, iconString;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(
        /*color:
            isSelected ? ProjectColors().primaryColor : ProjectColors().white,*/
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              iconString,
              colorFilter:
                  isSelected
                      ? ColorFilter.mode(
                        ProjectColors().primaryColor,
                        BlendMode.srcIn,
                      )
                      : ColorFilter.mode(
                        ProjectColors().blue1,
                        BlendMode.srcIn,
                      ),
              height: 16,
              width: 16,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.raleway(
                color:
                    isSelected
                        ? ProjectColors().primaryColor
                        : ProjectColors().blue1,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
